import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

import '../../../models/user_model.dart';
import 'auth_errors.dart' as auth_errors;

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUerOrError(Map<dynamic, dynamic> result) {
    //result key e variavel html
    if (result['result'] != null) {
      //instanciando usuario para Signin
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      //mensagem de erro
      return AuthResult.error(auth_errors.authErrorsString(result['error']));
    }
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      Endpoints.validateToken,
      HttpMethods.post,
      {
        'X-Parse-Session-Token': token,
      },
      {},
    );

    /*
      //result key e variavel html
      if (result['result'] != null) {
        //instanciando usuario para Signin
        final user = UserModel.fromJson(result['result']);
        return AuthResult.success(user);
      } else {
        //mensagem de erro
        return AuthResult.error(auth_errors.authErrorsString(result['error']));
      }
    */

    return handleUerOrError(result);
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      Endpoints.signin,
      HttpMethods.post,
      {},
      {
        "email": email,
        "password": password,
      },
    );

    /*
      //result key e variavel html
      if (result['result'] != null) {
        //print("Signin funcionou!");
        //print(result['result']);

        //instanciando usuario para Signin
        final user = UserModel.fromJson(result['result']);
        return AuthResult.success(user);

        //print(user);
      } else {
        //print("Signin nao funcionou!");

        //mensagem de erro
        //return AuthResult.error(result['error']);
        return AuthResult.error(auth_errors.authErrorsString(result['error']));
        //print(result['error']);
      }
    */

    return handleUerOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      Endpoints.signup,
      HttpMethods.post,
      {},
      // TODO body enviar dados
      user.toJson(),
    );

    return handleUerOrError(result);
  }
}
