import 'package:get/get.dart';
import '../core/network/network_module.dart';
import '../core/sync/sync_engine.dart';
import '../data/local/app_database.dart';
import '../data/local/notes_dao.dart';
import '../data/local/sync_queue_dao.dart';
import '../data/repositories/notes_repository.dart';
import '../data/repositories/notes_repositories_implement.dart';
import '../controllers/home_controller.dart';
import '../controllers/notes_controller.dart';
import '../core/sync/connectivity_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    NetworkModule.init();

    // Database
    Get.put(AppDatabase(), permanent: true);
    Get.put(NotesDao(Get.find()), permanent: true);
    Get.put(SyncQueueDao(Get.find()), permanent: true);
    Get.put(ConnectivityService(), permanent: true);  
    // Sync
    Get.put(SyncEngine(), permanent: true);

    // Repository
    Get.put<NotesRepository>(
      NotesRepositoryImplement(),
      permanent: true,
    );

    // Controllers
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<NotesController>(() => NotesController());
  }
}
