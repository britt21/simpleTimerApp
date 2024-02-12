import 'package:equatable/equatable.dart';
import 'package:simple_timer_app/data/todo.dart';

abstract class TodoEvent extends Equatable {

  const TodoEvent();

  @override
  List<Object?> get props => [];
}


  class TodoStarted extends TodoEvent{}
  class AddTodo extends TodoEvent{

   final Todo todo;

   const AddTodo(this.todo);

   @override
   List<Object> get props => [todo];

  }
  class EditTodo extends TodoEvent{
    final Todo todo;

  final int index;

  EditTodo(this.index,this.todo);

  @override
    List<Object?> get props => [index];


}

