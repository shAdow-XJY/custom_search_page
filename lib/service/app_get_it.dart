import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';

import 'index_db.dart';


/// get_it to easy make Singleton Class
GetIt appGetIt = GetIt.instance;

Future<void> setupAppGetIt({bool test = false}) async {

  appGetIt.registerSingleton<EventBus>(EventBus(), instanceName: "EventBus");

  IndexDB indexDB = IndexDB();
  await indexDB.init();
  appGetIt.registerSingleton<IndexDB>(indexDB, instanceName: "IndexDB");

}
