import 'package:flutter/material.dart';

enum MoreOptions {
  Progress,
  Delete,
}

class TodoItem extends StatelessWidget {
  final String id;
  final String text;
  final bool isDone;
  final bool isProgress;
  final Function checkTodo;
  final Function deleteTodo;
  Function? moveProgress;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  TodoItem(
    this.id,
    this.text,
    this.isDone,
    this.isProgress,
    this.checkTodo,
    this.deleteTodo,
    this.moveProgress,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          child: Row(children: [
            isProgress
                ? Checkbox(
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    shape: const CircleBorder(),
                    value: isDone ? true : false,
                    onChanged: ((_) => {
                          checkTodo(id),
                        }),
                  )
                : Container(),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ]),
        ),
        PopupMenuButton(
          onSelected: (value) {
            if (value == MoreOptions.Delete) {
              deleteTodo(id);
            } else if (moveProgress != null) {
              moveProgress!(id);
            }
          },
          itemBuilder: (_) {
            return [
              const PopupMenuItem(
                value: MoreOptions.Progress,
                child: Text('Move Progress'),
              ),
              const PopupMenuItem(
                value: MoreOptions.Delete,
                child: Text('Delete'),
              )
            ];
          },
          icon: const Icon(Icons.more_vert),
        )
      ]),
    );
  }
}
