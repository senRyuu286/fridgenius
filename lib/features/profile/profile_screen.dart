import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../widgets/neo_widgets.dart';
import 'profile_view_model.dart';

/// Profile: avatar, name/email, editable-looking fields, settings, logout.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileProvider);
    final initials = (user.displayName ?? 'F')
        .trim()
        .split(RegExp(r'\s+'))
        .map((w) => w.isEmpty ? '' : w[0])
        .take(2)
        .join()
        .toUpperCase();

    return Scaffold(
      body: DottedBackground(
        child: Column(
          children: [
            NeoAppBar(
              title: 'Profile',
              onBack: () => _back(context),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: Container(
                      width: 96,
                      height: 96,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.coral,
                        border: AppBorders.all,
                        borderRadius: AppRadii.cardRadius,
                        boxShadow: AppShadows.hard,
                      ),
                      child: Text(initials,
                          style: AppText.display.copyWith(fontSize: 40)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                      child: Text(user.displayName ?? 'Fridgenius Cook',
                          style: AppText.title)),
                  const SizedBox(height: 4),
                  Center(
                      child: Text(user.email ?? 'no-email',
                          style: AppText.body)),
                  const SizedBox(height: 28),
                  NeoTextField(
                    label: 'Display name',
                    controller:
                        TextEditingController(text: user.displayName ?? ''),
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  NeoTextField(
                    label: 'Email',
                    controller: TextEditingController(text: user.email ?? ''),
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 28),
                  Text('SETTINGS',
                      style: AppText.caption.copyWith(
                          fontWeight: FontWeight.w800, letterSpacing: 1.2)),
                  const SizedBox(height: 12),
                  const _SettingsList(),
                  const SizedBox(height: 28),
                  NeoButton(
                    label: 'Log Out',
                    icon: Icons.logout,
                    variant: NeoButtonVariant.light,
                    onPressed: () {
                      ref.read(profileProvider.notifier).logout();
                      context.go('/signin');
                    },
                  ),
                  const SizedBox(height: 40),
                ],
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
      context.go('/favorites');
    }
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList();

  static const _items = <(IconData, String)>[
    (Icons.restaurant_menu, 'Dietary preferences'),
    (Icons.notifications_none, 'Notifications'),
    (Icons.help_outline, 'Help & support'),
    (Icons.info_outline, 'About Fridgenius'),
  ];

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < _items.length; i++)
            Column(
              children: [
                if (i != 0) const Divider(height: 1, color: AppColors.black),
                ListTile(
                  leading: Icon(_items[i].$1, color: AppColors.black),
                  title: Text(_items[i].$2, style: AppText.bodyBold),
                  trailing: const Icon(Icons.chevron_right,
                      color: AppColors.black),
                  // TODO(backend): navigate to the matching settings screen.
                  onTap: () {},
                ),
              ],
            ),
        ],
      ),
    );
  }
}
