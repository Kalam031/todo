import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/note_operation.dart';
import '../models/note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.lightBlue,
        ),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text('ToDo'),
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<NoteOperation>(
        builder: (context, data, child) {
          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              return NoteCard(data.getNotes[index]);
            },
          );
        },
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final Note note;
  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            note.description!,
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}
