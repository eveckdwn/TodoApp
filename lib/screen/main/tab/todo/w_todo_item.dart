import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/memory/vo_todo.dart';
import 'w_todo_status.dart';

class TodoItem extends ConsumerWidget {
  final Todo todo;

  const TodoItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
    return Dismissible(
      onDismissed: (direction) {
        ref.readTodoHolder.removeTodo(todo);
      },
      background: RoundedContainer(
        color: context.appColors.removeTodoBg,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Width(20),
            Icon(
              EvaIcons.trash2Outline,
              color: Colors.white,
            )
          ],
        ),
      ),
      secondaryBackground:  RoundedContainer(
        color: context.appColors.removeTodoBg,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Width(20),
            Icon(
              EvaIcons.trash2Outline,
              color: Colors.white,
            )
          ],
        ),
      ),
      key: ValueKey(todo.id),
      child: RoundedContainer(
          margin: const EdgeInsets.only(bottom: 6),
          color: context.appColors.itemBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              todo.dueDate.relativeDays.text.make(),
              Row(
                children: [
                  TodoStatusWidget(todo),
                  Expanded(child: todo.title.text.size(20).medium.make()),
                  IconButton(
                    onPressed: () async {
                      ref.readTodoHolder.editTodo(todo);
                    },
                    icon: const Icon(EvaIcons.editOutline),
                  )
                ],
              )
            ],
          )).pOnly(top: 15, bottom: 10, right: 5),
    );
  }
}
