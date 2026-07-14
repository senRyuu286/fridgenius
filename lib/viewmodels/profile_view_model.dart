import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/mock_data.dart';
import '../models/user_profile.dart';
import 'auth_view_model.dart';

/// ViewModel for the profile screen. Builds from the live Firebase user,
/// falling back to mock data for fields Firebase Auth doesn't provide
/// (dietary preferences, allergies, onboarding flag — no Firestore user
/// doc yet).
class ProfileViewModel extends Notifier<UserProfile> {
  @override
  UserProfile build() {
    // Rebuild whenever auth state changes (sign in/out) so this stays in sync.
    final authState = ref.watch(authStateProvider);
    final user = authState.value;

    if (user == null) {
      // Signed out — fall back to mock data rather than crash the screen.
      // Shouldn't normally be visible since logout() also redirects away.
      return MockData.user;
    }

    return UserProfile(
      id: user.uid,
      email: user.email,
      displayName: user.displayName,
      avatarUrl: user.photoURL,
      // TODO(backend): source from Firestore once a user-profile doc exists.
      dietaryPreferences: MockData.user.dietaryPreferences,
      allergies: MockData.user.allergies,
      isOnboarded: true,
      createdAt: user.metadata.creationTime,
    );
  }

  Future<void> logout() async {
    await ref.read(authViewModelProvider.notifier).signOut();
  }
}

final profileProvider =
    NotifierProvider<ProfileViewModel, UserProfile>(ProfileViewModel.new);