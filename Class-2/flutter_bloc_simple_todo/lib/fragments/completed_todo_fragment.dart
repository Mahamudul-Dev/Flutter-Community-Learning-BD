import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';

class CompletedTodoFragment extends StatelessWidget {
  const CompletedTodoFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Todo'),),

      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if(state is TodoLoaded){
          print({
            'inCompletedTodos': state.inCompletedTodos.length,
            'completedTodos': state.completedTodos.length
          });
        return ListView.builder(
        itemCount: state.completedTodos.length,
        itemBuilder: (context, index){
          return ListTile(
            leading: Icon(Icons.incomplete_circle_rounded),
            title: Text(state.completedTodos[index].title),
            subtitle: Text(state.completedTodos[index].description),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<TodoBloc>().add(DeleteTodo(state.completedTodos[index].id));
              },
            ),
          );
      });
      } else if(state is TodoError){
        return Center(
          child: Text(state.error)
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
      }),
    );
  }
}