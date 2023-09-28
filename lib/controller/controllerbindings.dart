import 'package:get/get.dart';
import 'package:getx_todos/controller/controller.dart';

class ControllerBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(Controller());
  }
  
}