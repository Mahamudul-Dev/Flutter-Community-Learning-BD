part of 'todo_bloc.dart';


sealed class TodoState extends Equatable {
  final TextEditingController? titleController;
  final TextEditingController? descriptionController;
  final TextEditingController? dateController;

  const TodoState(this.titleController, this.descriptionController, this.dateController);
  @override
  List<Object?> get props => [];
}


class TodoLoading extends TodoState {

  const TodoLoading(super.titleController, super.descriptionController, super.dateController);

  @override
  List<Object?> get props => [super.titleController, super.descriptionController, super.dateController];
}


class TodoAdded extends TodoState {
  const TodoAdded(super.titleController, super.descriptionController, super.dateController);
  @override
  List<Object?> get props => [super.titleController, super.descriptionController, super.dateController];
}

class TodoLoaded extends TodoState {
  final List<TodoEntity> completedTodos;
  final List<TodoEntity> inCompletedTodos;

  const TodoLoaded(super.titleController, super.descriptionController, super.dateController, this.completedTodos, this.inCompletedTodos);

  @override
  List<Object?> get props => [super.titleController, super.descriptionController, super.dateController, completedTodos, inCompletedTodos];
}


class TodoDeleted extends TodoState {
  const TodoDeleted(super.titleController, super.descriptionController, super.dateController);
  @override
  List<Object?> get props => [super.titleController, super.descriptionController, super.dateController];
}

class TodoCompleted extends TodoState {
  const TodoCompleted(super.titleController, super.descriptionController, super.dateController);
  @override
  List<Object?> get props => [super.titleController, super.descriptionController, super.dateController];
}


class TodoError extends TodoState {
  final String error;
  const TodoError(this.error, super.titleController, super.descriptionController, super.dateController);
  @override
  List<Object?> get props => [error, super.titleController, super.descriptionController, super.dateController];
}