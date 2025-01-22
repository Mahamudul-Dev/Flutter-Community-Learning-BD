import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_simple_todo/bloc_observer.dart';
import 'package:flutter_bloc_simple_todo/locator.dart';

import 'my_todo_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  Bloc.observer = AppBlocObserver();
  runApp(const MyTodoApp());
}
