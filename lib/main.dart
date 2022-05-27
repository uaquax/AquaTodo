import 'package:flutter/material.dart';
import 'package:todo/pages/tasks_pages.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo",
      color: Colors.grey,
      theme: ThemeData.dark(),
      home: TasksPage(),
      routes: {
        TasksPage.routeName: (context) => TasksPage(),
      },
    );
  }
}
