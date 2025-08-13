import 'package:counter/counter/couter_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  RxInt count = 0.obs; //observable variable
  RxInt limit = 0.obs;
  TextEditingController limitTxtController = TextEditingController();
  void increment() {
    if (count.value < limit.value) {
      count.value++;
    } 
  }

  void decrement() {
    if (count.value > 0) count.value--;
  }

  void reset() {
    count.value = 0;
  }

  void saveLimit() {
    limit.value = int.parse(limitTxtController.text);
    print(limitTxtController.text);
    Get.off(CounterScreen());
  }
}

//create quize app with following screens :- 
// 1. Start screen with instruction and start btn
// 2. Quize screen 
// 3. Display questions and display four options as btn and on top display the score and on bottom show next or submit btn
// 4. To display quize score with detail, which are right and wrong