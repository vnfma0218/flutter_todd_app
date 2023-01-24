import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class ProgressListScreen extends StatelessWidget {
  final List<Todo> progressList;
  final Function checkTodo;
  final Function deleteTodo;

  const ProgressListScreen(this.progressList, this.checkTodo, this.deleteTodo);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: progressList.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            // height: 50,
            child: Column(
              children: [
                TodoItem(
                  progressList[index].id,
                  progressList[index].text,
                  progressList[index].isDone,
                  progressList[index].isProgress,
                  checkTodo,
                  deleteTodo,
                  () {},
                ),
                const Divider(
                  color: Colors.black54,
                  thickness: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
