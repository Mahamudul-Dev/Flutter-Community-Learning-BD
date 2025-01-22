import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_todo/bloc/todo_bloc.dart';

class IncompleteTodoFragment extends StatelessWidget {
  const IncompleteTodoFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state){
      if(state is TodoLoaded){
        return ListView.builder(
        itemCount: state.inCompletedTodos.length,
        itemBuilder: (context, index){
          return ListTile(
            leading: Icon(Icons.incomplete_circle_rounded),
            title: Text(state.inCompletedTodos[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.inCompletedTodos[index].description),
                 ElevatedButton(onPressed: (){
                    context.read<TodoBloc>().add(MarkAsCompleted(state.inCompletedTodos[index].id));
                  }, child: Text('Make Complete')),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<TodoBloc>().add(DeleteTodo(state.inCompletedTodos[index].id));
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
    });
  }
}