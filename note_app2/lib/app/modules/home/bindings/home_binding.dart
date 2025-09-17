// lib/app/modules/home/bindings/home_binding.dart
import 'package:get/get.dart';
import '../../../data/repositories/note_repository.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register repository
    Get.lazyPut<NoteRepository>(
      () => NoteRepository(),
    );

    // Register controller
    Get.lazyPut<HomeController>(
      () => HomeController(noteRepository: Get.find()),
    );
  }
}