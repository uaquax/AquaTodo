import 'package:flutter/material.dart';
import 'package:todo/pages/tasks_pages.dart';

class TaskCardWidget extends StatefulWidget {
  String title;
  final int id;
  bool isDone;

  TaskCardWidget(
      {super.key, required this.id, required this.title, required this.isDone});

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

              final taskId =
                  tasks.indexWhere((element) => element.id == widget.id);
              tasks[taskId].isDone = widget.isDone;
              database.updateTask(tasks[taskId]);
            });
          },
        ),
        Text(
          widget.title == "" ? "(Unnamed Task)" : widget.title,
          style: TextStyle(
              fontSize: 22.0,
              decoration: widget.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
      ]),
    );
  }
}
