import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  static const routeName = '/addscreen';
  final String title;
  final String description;

  AddScreen({this.title = "", this.description = ""});

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
    print(widget.title);
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
}
