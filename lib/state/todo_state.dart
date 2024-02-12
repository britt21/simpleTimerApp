import 'package:equatable/equatable.dart';

import '../data/todo.dart';

enum TodoStatus { initial, loading, success, error }


class TodoState extends Equatable {
  List<Todo> todos;
  final TodoStatus todoStatus;

  TodoState({
    this.todos = const [], // Provide default value for todos
    this.todoStatus = TodoStatus.initial, // Provide default value for todoStatus
  });

  TodoState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      todoStatus: status ?? this.todoStatus,
    );
  }

  factory TodoState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfTodos = (json["todo"] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList();

      return TodoState(
        todos: listOfTodos,
        todoStatus: TodoStatus.values.firstWhere(
                (element) => element.name.toString() == json["todoStatus"]),
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "todo": todos,
      "todoStatus": todoStatus.name,
    };
  }

  @override
  List<Object?> get props => [todos, todoStatus];
}
