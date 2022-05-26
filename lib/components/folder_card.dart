import 'package:flutter/material.dart';

class FolderCardWidget extends StatefulWidget {
  final String title;
  final String description;

  const FolderCardWidget({
    super.key,
    this.title = "",
    this.description = "",
  });

  @override
  State<FolderCardWidget> createState() => _FolderCardWidgetState();
}

class _FolderCardWidgetState extends State<FolderCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title == "" ? "(Unnamed Folder)" : widget.title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            ),
            const SizedBox(height: 15),
            Text(
              widget.description,
              style: const TextStyle(height: 1.5, fontSize: 16),
            ),
          ]),
    );
  }
}
