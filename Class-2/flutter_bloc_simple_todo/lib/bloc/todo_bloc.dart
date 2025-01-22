import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_simple_todo/entities/todo_entity.dart';
import 'package:flutter_bloc_simple_todo/locator.dart';

import '../objectbox.g.dart';

part 'todo_event.dart';
part 'todo_state.dart';


class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading(null, null, null)) {

    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final dateController = TextEditingController();

    final todoBox = locator.get<Store>().box<TodoEntity>();
    
    on<AddTodo>((event, emit) async{
      emit(TodoLoading(titleController, descriptionController, dateController));
      try {
        await todoBox.putAsync(event.todo);
        titleController.clear();
        descriptionController.clear();
        dateController.clear();

        emit(TodoAdded(titleController, descriptionController, dateController));

      } catch (e) {
        emit(TodoError('Failed to add todo: ${e.toString()}', titleController, descriptionController, dateController));
      }
    });
    on<FetchTodos>((event, emit) {
      emit(TodoLoading(titleController, descriptionController, dateController));
      try {
        final allTodo = todoBox.getAll();
        final completedTodos = allTodo.where((todo) => todo.isDone).toList();
        final incompleteTodos = allTodo.where((todo) => !todo.isDone).toList();
        emit(TodoLoaded(titleController, descriptionController, dateController, completedTodos, incompleteTodos));
      } catch (e) {
        emit(TodoError('Failed to fetch todos: ${e.toString()}', titleController, descriptionController, dateController));
      }
    });

    on<DeleteTodo>((event, emit) {
      todoBox.remove(event.id);
      emit(TodoDeleted(titleController, descriptionController, dateController));
    });


    on<MarkAsCompleted>((event, emit){
      try {
        final todo = todoBox.get(event.id);
        if(todo != null) {
          todo.isDone = true;
          todoBox.put(todo);
          emit(TodoCompleted(titleController, descriptionController, dateController));
        } else {
          emit(TodoError('Could not find todo', titleController, descriptionController, dateController));
        }
      } catch (e) {
        emit(TodoError('Failed to mark todo as completed: ${e.toString()}', titleController, descriptionController, dateController));
      }
    });
  }
  
}