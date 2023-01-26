import 'package:flutter/material.dart';
import '../model/todo.dart';

class CompleteScreen extends StatelessWidget {
  static const routeName = '/complete';

  const CompleteScreen(this.doneTodos);
  final List<Todo> doneTodos;

  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('complete page'),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, i) {
            return Text(doneTodos[i].text);
          },
          itemCount: doneTodos.length,
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
          currentIndex: 1,
          selectedItemColor: Colors.amber[800],
          onTap: (index) => _onItemTapped(index, context),
        ),
      ),
    );
  }
}
