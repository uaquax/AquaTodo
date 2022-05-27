import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/pages/tasks_pages.dart';

class TaskCardWidget extends StatefulWidget {
  String title;
  final int id;
  bool isDone;
  Function(int index) onDelete;
  Function(String title) onEdit;

  TaskCardWidget(
      {super.key,
      required this.id,
      required this.title,
      required this.isDone,
      required this.onDelete,
      required this.onEdit});

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Checkbox(
          activeColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          value: widget.isDone,
          onChanged: (bool? value) {
            setState(() {
              widget.isDone = value!;

              final taskIndex =
                  tasks.indexWhere((element) => element.id == widget.id);
              tasks[taskIndex].isDone = widget.isDone;
              database.updateTask(tasks[taskIndex]);
            });
          },
        ),
        Expanded(
          child: Text(
            widget.title == "" ? "(Unnamed Task)" : widget.title,
            style: TextStyle(
                fontSize: 22.0,
                decoration: widget.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
        ),
        const Expanded(
          child: SizedBox(
            width: 250,
          ),
        ),
        IconButton(
          onPressed: () {
            _edit(widget.title);
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          onPressed: () {
            final taskIndex =
                tasks.indexWhere((element) => element.id == widget.id);
            database.deleteTask(tasks[taskIndex]);
            widget.onDelete(taskIndex);
          },
          icon: const Icon(Icons.delete),
          color: Colors.red,
        )
      ]),
    );
  }

  void _edit(String taskTitle) {
    TextEditingController nameController = TextEditingController()
      ..text = taskTitle;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(50),
            height: 250,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                const Text("Edit Task",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {
                    database.updateTask(Task(
                        title: nameController.text,
                        isDone: widget.isDone,
                        id: widget.id));
                    widget.onEdit(nameController.text);
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                )
              ],
            ),
          );
        });
  }
}
