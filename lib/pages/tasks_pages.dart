import 'package:flutter/material.dart';
import 'package:todo/components/task_card.dart';
import 'package:todo/database.dart';

import '../models/task.dart';

const String kTasksKey = 'tasks';
List<Task> tasks = [];
final DatabaseHelper database = DatabaseHelper();

class TasksPage extends StatefulWidget {
  static String routeName = "/tasks";

  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  void _loadTasks() async {
    final databaseTasks = await database.getTasks();

    databaseTasks.forEach((element) {
      setState(() {
        tasks.add(element);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Image.asset(
            "assets/images/logo.png",
            width: 80,
            height: 80,
          ),
          const Text("Aqua Todo"),
        ]),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return TaskCardWidget(
            title: tasks[index].title,
            id: tasks[index].id,
            isDone: tasks[index].isDone,
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTask,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTask(String taskName) async {
    final newTaskId = await database.getLastId();
    final newTask = Task(title: taskName, isDone: false, id: newTaskId + 1);

    await database.addTask(newTask);

    setState(() {
      tasks.add(newTask);
    });
  }

  void _showAddTask() {
    TextEditingController nameController = TextEditingController();

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(50),
            height: 250,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                const Text("Add Task",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Enter task name..",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () {
                    _addTask(nameController.text);
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                )
              ],
            ),
          );
        });
  }
}
