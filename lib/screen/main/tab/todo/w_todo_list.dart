import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'w_todo_item.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoDataProvider);
    return todoList.isEmpty
        ? '할 일을 작성해보세요.'.text.size(30).makeCentered()
        : Column(
      children: todoList.map((e) => TodoItem(e)).toList(),
    );
  }
}
