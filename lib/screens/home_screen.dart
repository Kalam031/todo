import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/db/database_model.dart';
import 'package:todo/db/database_service.dart';
import 'package:todo/providers/note_operation.dart';
import 'package:todo/screens/add_screen.dart';
import 'package:todo/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<NoteOperation>(context).getNewNote();
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.lightBlue,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed(AddScreen.routeName);
        },
      ),
      appBar: AppBar(
        title: Text('ToDo'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            }, //_saveForm,
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer<NoteOperation>(
        builder: (context, data, child) {
          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: NoteCard(data.getNotes[index]),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddScreen(
                            id: data.getNotes[index].id!,
                            title: data.getNotes[index].title!,
                            description: data.getNotes[index].description!,
                          )));
                },
              );
            },
          );
        },
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final ToDoModel note;
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
