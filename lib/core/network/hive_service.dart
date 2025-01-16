import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:kitchening/features/auth/data/model/user_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    //To initialize hive database in application directory
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}kitchening.db';
    Hive.init(path);

    //We need to register adapters here
    Hive.registerAdapter(UserHiveModelAdapter());
  }
}
