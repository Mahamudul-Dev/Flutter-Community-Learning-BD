import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_simple_todo/entities/todo_entity.dart';
import 'package:flutter_bloc_simple_todo/fragments/incomplete_todo_fragment.dart';
import 'package:gap/gap.dart';

import '../bloc/todo_bloc.dart';
import '../fragments/completed_todo_fragment.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My BLoC Todo App'),
        actions: [
          ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CompletedTodoFragment()));
              }, child: Text('Completed Todo')),
        ],
      ),

      body: BlocListener<TodoBloc, TodoState>(listener: (context, state){
        if(state is TodoAdded){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Todo Added')));
          context.read<TodoBloc>().add(FetchTodos());
        }

        if(state is TodoLoaded){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Todo Loded')));
        }

        if(state is TodoDeleted){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Todo Deleted')));
          context.read<TodoBloc>().add(FetchTodos());
        }

        if(state is TodoCompleted){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Todo Completed')));
          context.read<TodoBloc>().add(FetchTodos());
        }

        if(state is TodoError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
        }

      }, child: IncompleteTodoFragment(),),

      floatingActionButton: BlocBuilder<TodoBloc, TodoState>(builder: (context, state){
        return  FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          showDialog(context: context, builder: (context)=> _addTodoDialog(context, state.titleController, state.descriptionController, state.dateController));
        },
      );
      })
    );
  }


  Widget _addTodoDialog(BuildContext context, TextEditingController? titleController, TextEditingController? descriptionController, TextEditingController? dateController){ {
    return AlertDialog(
      title: Text('Add New Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
            ),
          ),

          Gap(10),

          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
            ),
          ),

          Gap(10),


          TextField(
            controller: dateController,
            decoration: InputDecoration(
              suffixIcon: IconButton(onPressed: ()  {
                showDatePicker(context: context, firstDate: DateTime(2022), lastDate: DateTime(2030), initialDate: DateTime.now()).then((value) => dateController?.text = value.toString());
              }, icon: Icon(Icons.calendar_month))
            ),
          )
        ],
      ),

      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel')),
        TextButton(onPressed: (){
          context.read<TodoBloc>().add(AddTodo(TodoEntity(title: titleController!.text, description: descriptionController!.text, dateTime: DateTime.parse(dateController!.text))));
        }, child: Text('Save'))
      ],
    );
  }
}
}