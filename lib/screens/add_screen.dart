import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_operation.dart';

class AddScreen extends StatefulWidget {
  static const routeName = '/addscreen';

  final int? id;
  final String title;
  final String description;

  AddScreen({this.id = -1, this.title = "", this.description = ""});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late TextEditingController _titleController =
      TextEditingController(text: widget.title);

  late TextEditingController _descriptionController =
      TextEditingController(text: widget.description);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String titleText;
    String descriptionText;

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text('ToDo'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              _saveTodo();
            }, //_saveForm,
            icon: Icon(Icons.check),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                  child: Text('Delete'),
                  onTap: () {
                    Provider.of<NoteOperation>(context, listen: false)
                        .deleteNote(widget.id!);
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Title',
                hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textInputAction: TextInputAction.next,
              controller: _titleController,
              onChanged: (value) {
                titleText = value;
              },
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Description..',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _descriptionController,
                onChanged: (value) {
                  descriptionText = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveTodo() {
    if (!_titleController.text.isEmpty ||
        !_descriptionController.text.isEmpty) {
      if (widget.id != -1) {
        print(widget.id);
        Provider.of<NoteOperation>(context, listen: false).updateNote(
            widget.id!, _titleController.text, _descriptionController.text);
      } else if (widget.id == -1) {
        print("test");
        Provider.of<NoteOperation>(context, listen: false)
            .addNewNote(_titleController.text, _descriptionController.text);
      }
    } else {
      //snackbar;
    }
  }
}
