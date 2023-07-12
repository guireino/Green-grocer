import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greengrocer/src/models/user_model.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthResult with _$AuthResult {
  // generator for classes Success os dois resutado para chamada signIn do auth_respository
  factory AuthResult.success(UserModel user) = Success;
  factory AuthResult.error(String message) = Error;
}
