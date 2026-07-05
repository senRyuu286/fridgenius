import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/mock_data.dart';
import '../../models/user_profile.dart';

/// ViewModel for the profile screen. Exposes mock user data for now.
class ProfileViewModel extends Notifier<UserProfile> {
  @override
  UserProfile build() =>
      // TODO(backend): load the signed-in user's profile from Firestore.
      MockData.user;

  void logout() {
    // TODO(backend): sign out via FirebaseAuth and clear local state.
  }
}

final profileProvider =
    NotifierProvider<ProfileViewModel, UserProfile>(ProfileViewModel.new);
