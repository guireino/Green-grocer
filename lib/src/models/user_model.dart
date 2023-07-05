// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

//build_runner foi usado para compilar class e para criar arquivo user_model.g.dart
//utilizando no terminal comando: flutter pub run build_runner build para criar arquivo user_model.g.dart mesmo com aviso erro
part 'user_model.g.dart';

//utilizando plugins: dart data class generator
@JsonSerializable()
class UserModel {
  // na hora conversao ele vai mudar name para fullname
  @JsonKey(name: 'fullname')
  String? name;
  String? email, phone, cpf, password, id, token;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.cpf,
    this.password,
    this.id,
    this.token,
  });

  /*

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: String? name, email, phone, cpf, password, id,.fromMap(map['token'] as Map<String,dynamic>),
    );
  }

  //trasformando objeto em um map com seus atributos
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token.toMap(),
    };
  }

  */

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  //returno com os valores
  @override
  String toString() => 'UserModel(name: $name, token: $token)';
}
