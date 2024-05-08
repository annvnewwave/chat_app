import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'auth_entity.freezed.dart';
part 'auth_entity.g.dart';

@freezed
class AuthEntity with _$AuthEntity {
  const factory AuthEntity({
    String? id,
    String? fullName,
    String? email,
    String? password,
  }) = _AuthEntity;

  factory AuthEntity.fromJson(Map<String, Object?> json) =>
      _$AuthEntityFromJson(json);
}
