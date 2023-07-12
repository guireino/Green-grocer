String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return "Digite seu email!";
  }

  if (!email.isNotEmpty) {
    return "Digite um email valido!";
  }

  return null;
}

String? passwordValidator(password) {
  if (password == null || password.isEmpty) {
    return "Digite sua senha!";
  }

  if (password.length < 7) {
    return "Digite uma senha com pelos menos 7 caracteres.";
  }

  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return "Digite um  nome!";
  }

  final names = name.split('');

  if (names.length == 1) {
    return "Digite seu nome completo!";
  }
  return null;
}
