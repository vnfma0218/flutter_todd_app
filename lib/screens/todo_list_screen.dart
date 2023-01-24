import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class TodoListScreen extends StatelessWidget {
  final List<Todo> todoList;
  final Function checkTodo;
  final Function deleteTodo;
  final Function moveProgress;

  const TodoListScreen(
    this.todoList,
    this.checkTodo,
    this.deleteTodo,
    this.moveProgress,
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: todoList.isEmpty
          ? const Text('할일을 입력해주세요')
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  // height: 50,
                  child: Column(
                    children: [
                      TodoItem(
                        todoList[index].id,
                        todoList[index].text,
                        todoList[index].isDone,
                        todoList[index].isProgress,
                        checkTodo,
                        deleteTodo,
                        moveProgress,
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
