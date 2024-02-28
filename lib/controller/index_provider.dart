import 'package:get/get.dart';

class IndexProvider extends GetxController {
  int index = 0;
  void changeIndex(int i) {
    index = i;
    update();
  }
}
