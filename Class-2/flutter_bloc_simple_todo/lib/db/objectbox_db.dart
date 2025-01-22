import 'package:flutter_bloc_simple_todo/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';



class ObjectboxDb {

  late final Store store;

  Future<void> setupStore () async {

    final dir = await getApplicationDocumentsDirectory();

    final st = await openStore(directory:  '${dir.path}/objectbox.db');
    store = st;
  }
}