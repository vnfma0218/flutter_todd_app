class Todo {
  final String id;
  final String text;
  bool isDone;
  bool isProgress;

  Todo({
    required this.id,
    required this.text,
    this.isDone = false,
    this.isProgress = false,
  });
}

class TodoList {
  // final List<Todo> _list = [];

  // List<Todo> get todoList {
  //   return [..._list];
  // }

  // void addTodo(Todo todoItem) {
  //   print('todoItem----');
  //   print(todoItem);
  //   _list.add(todoItem);
  //   print(_list);
  // }
}
