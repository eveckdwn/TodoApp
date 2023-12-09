import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screen/main/write/d_write_todo.dart';
import 'bloc/bloc_status.dart';
import 'bloc/todo_bloc_state.dart';
import 'bloc/todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoBlocState> {
  TodoBloc() : super(const TodoBlocState(BlocStatus.initial, <Todo>[])){
    on<TodoAddEvent>(_addTodo);
    // on<TodoAddEvent>(_addTodo, transformer: ); //  bloc_concurrency package를 이용하면 유용할 수 있음.
    on<TodoContentUpdateEvent>(_editTodo);
    on<TodoStatusUpdateEvent>(_changeTodoStatus);
    on<TodoRemovedEvent>(_removeTodo);
  }

  void _addTodo(TodoAddEvent event, Emitter<TodoBlocState> emit) async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      final copiedOldTodoList = List.of(state.todoList);
      //  mounted: 현재 스크린이 살아있는지를 체크할 수 있음.
      copiedOldTodoList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          title: result.text,
          dueDate: result.dateTime,
          createdTime: DateTime.now(),
          status: TodoStatus.incomplete,
      ));
      emitNewList(copiedOldTodoList, emit);
    }
  }

  void _changeTodoStatus(TodoStatusUpdateEvent event, Emitter<TodoBlocState> emit) async {
    final copiedOldTodoList = List.of(state.todoList);
    final todo = event.updatedTodo;
    final todoIndex = copiedOldTodoList.indexWhere((element) => element.id == todo.id);

    TodoStatus status = todo.status;
    switch (todo.status) {
      case TodoStatus.incomplete:
        status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          status = TodoStatus.incomplete;
        });
    }
    copiedOldTodoList[todoIndex] = todo.copyWith(status: status);
    emitNewList(copiedOldTodoList, emit);
  }



  void _editTodo(TodoContentUpdateEvent event, Emitter<TodoBlocState> emit) async {
    final todo = event.updatedTodo;
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      final copiedOldTodoList = List.of(state.todoList);
      copiedOldTodoList[copiedOldTodoList.indexOf(todo)] = todo.copyWith(title: result.text, dueDate: result.dateTime, modifiedTime: DateTime.now());
      emitNewList(copiedOldTodoList, emit);
    }
  }

  void _removeTodo(TodoRemovedEvent event, Emitter<TodoBlocState> emit) {
    final copiedOldTodoList = List.of(state.todoList);
    copiedOldTodoList.removeWhere((element) => element.id == event.removedTodo.id);
    emitNewList(copiedOldTodoList, emit);
  }

  void emitNewList(List<Todo> copiedOldTodoList, Emitter<TodoBlocState> emit) {
    emit(state.copyWith(todoList: copiedOldTodoList));
  }
}