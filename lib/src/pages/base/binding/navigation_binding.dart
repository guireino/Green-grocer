import 'package:get/get.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    //ingetando na memoria celular
    Get.lazyPut(() => NavigationBinding());
  }
}
