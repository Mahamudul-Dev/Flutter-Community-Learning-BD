import 'package:flutter_bloc_simple_todo/objectbox.g.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final dir = await getApplicationDocumentsDirectory();
  final store = await openStore(directory: '${dir.path}/objectbox.db');
  locator.registerSingleton<Store>(store);
}