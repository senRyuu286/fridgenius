// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String,
  email: json['email'] as String?,
  displayName: json['displayName'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  dietaryPreferences:
      (json['dietaryPreferences'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  allergies:
      (json['allergies'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isOnboarded: json['isOnboarded'] as bool? ?? false,
  dailyGenerationCap:
      json['dailyGenerationCap'] as Map<String, dynamic>? ?? const {},
  createdAt: _dateTimeFromTimestamp(json['createdAt']),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'dietaryPreferences': instance.dietaryPreferences,
      'allergies': instance.allergies,
      'isOnboarded': instance.isOnboarded,
      'dailyGenerationCap': instance.dailyGenerationCap,
      'createdAt': _dateTimeToTimestamp(instance.createdAt),
    };
