import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/user_profile.dart';
import '../repositories/user_profile_repository.dart';
import 'auth_view_model.dart';

/// ViewModel for the profile screen. Builds from the live Firebase user, then
/// enriches it with the stored Firestore profile (dietary preferences,
/// allergies, onboarding flag). Exposes an [AsyncValue] so the screen can drive
/// its own loading / error states.
class ProfileViewModel extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    // Rebuild whenever auth state changes (sign in/out) so this stays in sync.
    final user = ref.watch(authStateProvider).value;
    if (user == null) {
      // Signed out — a minimal placeholder. logout() also redirects away, so
      // this shouldn't normally be visible.
      return const UserProfile(id: 'anonymous');
    }

    final stored =
        await ref.read(userProfileRepositoryProvider).fetchProfile(user.uid);

    return UserProfile(
      id: user.uid,
      email: user.email ?? stored?.email,
      displayName: user.displayName ?? stored?.displayName,
      avatarUrl: user.photoURL ?? stored?.avatarUrl,
      dietaryPreferences: stored?.dietaryPreferences ?? const [],
      allergies: stored?.allergies ?? const [],
      dailyGenerationCap: stored?.dailyGenerationCap ?? const {},
      isOnboarded: stored?.isOnboarded ?? true,
      createdAt: stored?.createdAt ?? user.metadata.creationTime,
    );
  }

  Future<void> logout() async {
    await ref.read(authViewModelProvider.notifier).signOut();
  }
}

final profileProvider =
    AsyncNotifierProvider<ProfileViewModel, UserProfile>(ProfileViewModel.new);
