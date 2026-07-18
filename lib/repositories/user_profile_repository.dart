import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/user_profile.dart';

/// Read/write access to the stored user profile (dietary preferences,
/// allergies, …).
abstract interface class UserProfileRepository {
  /// Returns the profile document for [userId], or `null` if none exists yet.
  Future<UserProfile?> fetchProfile(String userId);

  /// Creates the `users/{userId}` document if it does not already exist.
  /// Safe to call on every sign-up; won't clobber an existing profile.
  Future<void> createProfileIfMissing(UserProfile profile);
}

/// Firestore-backed [UserProfileRepository] reading `users/{userId}`.
class FirestoreUserProfileRepository implements UserProfileRepository {
  FirestoreUserProfileRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<UserProfile?> fetchProfile(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return null;
    final data = doc.data() ?? <String, dynamic>{};
    data['id'] = doc.id;
    return UserProfile.fromJson(data);
  }

  @override
  Future<void> createProfileIfMissing(UserProfile profile) async {
    final data = profile.toJson()
      // `id` is the document id, not a stored field.
      ..remove('id')
      // Let Firestore stamp the server time regardless of client clock.
      ..['createdAt'] = FieldValue.serverTimestamp();
    // merge: true makes this a safe no-clobber upsert.
    await _firestore
        .collection('users')
        .doc(profile.id)
        .set(data, SetOptions(merge: true));
  }
}

/// Injects the app-wide [UserProfileRepository]. Override in tests with a fake.
final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return FirestoreUserProfileRepository();
});
