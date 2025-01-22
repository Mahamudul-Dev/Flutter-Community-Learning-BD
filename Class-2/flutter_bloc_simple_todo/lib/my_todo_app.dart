import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_todo/screens/screens.dart';

import 'bloc/todo_bloc.dart';

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=> TodoBloc()..add(FetchTodos())),
    ], child: MaterialApp(
      home: HomeScreen(),
    ));
    
  }
}