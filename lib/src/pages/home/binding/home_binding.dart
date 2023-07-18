import 'package:get/get.dart';
import 'package:greengrocer/src/pages/home/controller/home_controller.dart';

// os Bindings injetada as dependecias quando um tela e chamada
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeController());
  }
}
