import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/respository/auth_respository.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    //await Future.delayed(const Duration(seconds: 2));
    await authRepository.signIn(email: email, password: password);

    isLoading.value = false;
  }
}
