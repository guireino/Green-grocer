const String baseUrl = 'https://parseapi.back4app.com/functions';

// class onde esta variaveis caminho https
abstract class Endpoints {
  static const String signin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
}
