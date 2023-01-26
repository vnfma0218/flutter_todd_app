import 'package:flutter/material.dart';
import './screens/complete_screen.dart';
import 'package:todo_app/screens/progress_list_screen.dart';
import './screens/todo_list_screen.dart';
import './model/todo.dart';

// https://dribbble.com/shots/16746779-Todoist-for-Android/attachments/11793617?mode=media
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // routes: {
      //   '/': (context) => const MyHomePage(title: 'title'),
      //   CompleteScreen.routeName: (context) =>  CompleteScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> _todoList = [];

  late TextEditingController _controller;

  List<Todo> get inProgressTodos {
    return _todoList.where((element) => element.isProgress).toList();
  }

  List<Todo> get todos {
    return _todoList.where((element) => element.isProgress == false).toList();
  }

  List<Todo> get doneTodos {
    return _todoList.where((element) => element.isDone).toList();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSubmitTodo(value) {
    setState(() {
      var todoItem =
          Todo(id: DateTime.now().toString(), text: value, isDone: false);
      _todoList.add(todoItem);
      _controller.clear();
    });
  }

  void checkTodo(String id) {
    var foundTodo =
        _todoList[_todoList.indexWhere((element) => element.id == id)];
    setState(() {
      foundTodo.isDone = !foundTodo.isDone;
    });
  }

  void deleteTodo(String id) {
    setState(() {
      _todoList.removeWhere((element) => element.id == id);
    });
  }

  void moveProgress(String id) {
    var foundTodo =
        _todoList[_todoList.indexWhere((element) => element.id == id)];
    setState(() {
      foundTodo.isProgress = true;
    });
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CompleteScreen(doneTodos)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 25,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Pitch Video',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _controller,
                onSubmitted: onSubmitTodo,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'To do'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'To do',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _todoList.isNotEmpty
                  ? TodoListScreen(
                      todos,
                      checkTodo,
                      deleteTodo,
                      moveProgress,
                    )
                  : Container(),
              const Text(
                'In progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ProgressListScreen(inProgressTodos, checkTodo, deleteTodo)
            ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Done',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
