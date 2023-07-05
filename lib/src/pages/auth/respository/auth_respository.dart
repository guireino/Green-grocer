import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/services/http_manager.dart';

import '../../../models/user_model.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      Endpoint.signin,
      HttpMethods.post,
      {},
      {
        "email": email,
        "password": password,
      },
    );

    //result key e variavel html
    if (result['result'] != null) {
      print("Signin funcionou!");
      //print(result['result']);

      //instanciando novo usuario
      final user = UserModel.fromJson(result['result']);
      print(user);
    } else {
      print("Signin nao funcionou!");
      print(result['error']);
    }
  }
}
