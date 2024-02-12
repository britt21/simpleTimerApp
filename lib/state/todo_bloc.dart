import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:simple_timer_app/state/todo_state.dart';
import 'package:simple_timer_app/state/todp_event.dart';

import '../data/todo.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState()) {
    on<TodoStarted>(_onStarted);
    on<AddTodo>(_onAddTodo);
    on<EditTodo>(_onEditTodo);
  }

  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    return TodoState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    return state.toJson();
  }

  void _onStarted(TodoStarted event, Emitter<TodoState> emit) {
    List<Todo> todos =
        List.from(state.todos); // Create a copy of the existing todos

    emit(TodoState(todos: todos, todoStatus: TodoStatus.success));
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    emit(
      state.copyWith(
        status: TodoStatus.loading,
      ),
    );

    try {
      List<Todo> updatedTodos =
          List.from(state.todos); // Create a copy of the existing todos
      updatedTodos.insert(0, event.todo);

      print("saveddtodo ${state.todos}");
      emit(
        state.copyWith(
          todos: updatedTodos, // Update the state with the new list of todos
          status: TodoStatus.success,
        ),
      );
    } catch (e) {
      print("SOMETHINGWRONG");
      emit(
        state.copyWith(
          status: TodoStatus.error,
        ),
      );
    }
  }

  void _onEditTodo(EditTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(status: TodoStatus.loading)); // Set loading status

    try {
      // Update the description of the todo item at the specified index
      List<Todo> updatedTodos = List.from(state.todos);
      updatedTodos[event.index].index = event.index;
      updatedTodos[event.index].description = event.todo.description;

      emit(state.copyWith(todos: updatedTodos, status: TodoStatus.success)); // Emit updated state
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error)); // Emit error status if an exception occurs
    }
  }

}
