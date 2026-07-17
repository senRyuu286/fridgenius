import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme/app_theme.dart';
import '../widgets/neo_widgets.dart';
import '../viewmodels/camera_scan_view_model.dart';
import '../viewmodels/fridge_view_model.dart';

/// Camera scan: point the camera at your ingredients, capture, and let on-device
/// detection suggest ingredients. The detected list is reviewed/edited before
/// being added to the fridge and used to generate recipes.
class CameraScanScreen extends ConsumerStatefulWidget {
  const CameraScanScreen({super.key});

  @override
  ConsumerState<CameraScanScreen> createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends ConsumerState<CameraScanScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  String? _initError;
  bool _capturing = false;

  final _addController = TextEditingController();
  String _draft = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Start each visit from the live camera, not a stale review.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cameraScanProvider.notifier).reset();
    });
    _setupCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    _addController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      controller.dispose();
      _controller = null;
    } else if (state == AppLifecycleState.resumed) {
      _setupCamera();
    }
  }

  Future<void> _setupCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) setState(() => _initError = 'No camera found on this device.');
        return;
      }
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller =
          CameraController(back, ResolutionPreset.medium, enableAudio: false);
      await controller.initialize();
      if (!mounted) {
        controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _initError = null;
      });
    } catch (_) {
      if (mounted) {
        setState(() => _initError =
            'Camera unavailable. Grant camera permission and try again.');
      }
    }
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null ||
        !controller.value.isInitialized ||
        _capturing) {
      return;
    }
    setState(() => _capturing = true);
    try {
      final file = await controller.takePicture();
      await ref.read(cameraScanProvider.notifier).detect(file.path);
    } catch (_) {
      await ref.read(cameraScanProvider.notifier).detect('');
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  void _addDraft() {
    ref.read(cameraScanProvider.notifier).add(_addController.text);
    _addController.clear();
    setState(() => _draft = '');
  }

  void _addAndGenerate() {
    final detected = ref.read(cameraScanProvider).detected;
    final fridge = ref.read(ingredientListProvider.notifier);
    for (final name in detected) {
      fridge.add(name);
    }
    ref.read(cameraScanProvider.notifier).reset();
    context.pushReplacement('/results');
  }

  void _retake() {
    ref.read(cameraScanProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final scan = ref.watch(cameraScanProvider);

    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            NeoHeader(
              title: 'Scan Ingredients',
              subtitle: 'Point at your ingredients and capture.',
              onBack: () => _back(context),
            ),
            Expanded(
              child: scan.detecting
                  ? const AsyncLoadingView()
                  : scan.hasScanned
                      ? _ReviewView(
                          scan: scan,
                          addController: _addController,
                          draft: _draft,
                          onDraftChanged: (v) => setState(() => _draft = v),
                          onAdd: _addDraft,
                          onRemove: (name) => ref
                              .read(cameraScanProvider.notifier)
                              .remove(name),
                          onRetake: _retake,
                          onGenerate: _addAndGenerate,
                        )
                      : _CameraView(
                          controller: _controller,
                          initError: _initError,
                          capturing: _capturing,
                          onCapture: _capture,
                        ),
            ),
          ],
        ),
      ),
    );
  }

  void _back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/fridge');
    }
  }
}

/// Live camera preview + shutter button (or a permission/error card).
class _CameraView extends StatelessWidget {
  const _CameraView({
    required this.controller,
    required this.initError,
    required this.capturing,
    required this.onCapture,
  });

  final CameraController? controller;
  final String? initError;
  final bool capturing;
  final VoidCallback onCapture;

  @override
  Widget build(BuildContext context) {
    if (initError != null) {
      return AsyncErrorView(message: initError!);
    }
    final controller = this.controller;
    if (controller == null || !controller.value.isInitialized) {
      return const AsyncLoadingView();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.black,
                border: AppBorders.all,
                borderRadius: AppRadii.cardRadius,
                boxShadow: AppShadows.hard,
              ),
              clipBehavior: Clip.antiAlias,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.value.previewSize?.height ?? 1080,
                  height: controller.value.previewSize?.width ?? 1920,
                  child: CameraPreview(controller),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          NeoButton(
            label: capturing ? 'Detecting…' : 'Capture',
            icon: Icons.camera_alt,
            onPressed: capturing ? null : onCapture,
          ),
        ],
      ),
    );
  }
}

/// Detected-ingredient review: editable chips, add field, retake / generate.
class _ReviewView extends StatelessWidget {
  const _ReviewView({
    required this.scan,
    required this.addController,
    required this.draft,
    required this.onDraftChanged,
    required this.onAdd,
    required this.onRemove,
    required this.onRetake,
    required this.onGenerate,
  });

  final ScanState scan;
  final TextEditingController addController;
  final String draft;
  final ValueChanged<String> onDraftChanged;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;
  final VoidCallback onRetake;
  final VoidCallback onGenerate;

  @override
  Widget build(BuildContext context) {
    final canAdd = draft.trim().isNotEmpty;
    final canGenerate = scan.detected.isNotEmpty;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            children: [
              if (scan.error != null) ...[
                NeoCard(
                  color: AppColors.cream,
                  child: Row(
                    children: [
                      const Text('⚠️', style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(scan.error!, style: AppText.body),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
              Text('Detected ingredients', style: AppText.heading),
              const SizedBox(height: 4),
              Text(
                'Remove anything wrong, add anything missed, then generate.',
                style: AppText.body,
              ),
              const SizedBox(height: 16),
              if (scan.detected.isEmpty)
                NeoCard(
                  color: AppColors.cream,
                  child: Row(
                    children: [
                      const Text('🥕', style: TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Nothing detected. Add ingredients manually below, '
                          'or retake the photo.',
                          style: AppText.body,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final name in scan.detected)
                      NeoPill(
                        label: name,
                        color: AppColors.white,
                        onRemove: () => onRemove(name),
                      ),
                  ],
                ),
              const SizedBox(height: 24),
              NeoTextField(
                label: 'Add an ingredient',
                hint: 'e.g. Tomatoes',
                controller: addController,
                prefixIcon: Icons.add,
                onChanged: onDraftChanged,
              ),
              const SizedBox(height: 12),
              NeoButton(
                label: 'Add Ingredient',
                icon: Icons.add,
                variant: NeoButtonVariant.secondary,
                onPressed: canAdd ? onAdd : null,
              ),
              const SizedBox(height: 24),
              NeoButton(
                label: 'Retake Photo',
                icon: Icons.replay,
                variant: NeoButtonVariant.light,
                onPressed: onRetake,
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: NeoButton(
              label: 'Add & Generate Recipes',
              icon: Icons.auto_awesome,
              onPressed: canGenerate ? onGenerate : null,
            ),
          ),
        ),
      ],
    );
  }
}
