import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/db/database_model.dart';
import 'package:todo/providers/note_operation.dart';
import 'package:todo/screens/add_screen.dart';

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
            color: Colors.white,
          ),
          backgroundColor: Colors.orangeAccent,
          onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Create New Todo'),
                    content: Text(''),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(AddScreen.routeName);
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  );
                },
              )),
      appBar: AppBar(
        title: Text('ToDo'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );
            }, //_saveForm,
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer<NoteOperation>(
        builder: (context, data, child) {
          return data.getNotes.isEmpty
              ? Center(
                  child: Text(
                    'No Todo found. Add Todo by clicking plus icon.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: data.getNotes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: NoteCard(data.getNotes[index]),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddScreen(
                                  id: data.getNotes[index].id!,
                                  title: data.getNotes[index].title!,
                                  description:
                                      data.getNotes[index].description!,
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
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Text(
              note.description!,
              style: TextStyle(fontSize: 17),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: Icon(Icons.clear),
        )
      ];

  @override
  Widget buildResults(BuildContext context) => Center();

  @override
  Widget buildSuggestions(BuildContext context) {
    var loadedTodos =
        Provider.of<NoteOperation>(context).getNotes.where((searchResult) {
      final result = searchResult.title!.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: loadedTodos.length,
      itemBuilder: (ctx, index) {
        final loadedTodo = loadedTodos[index];

        return ListTile(
          title: Text(loadedTodo.title!),
          onTap: () {
            query = loadedTodo.title!;
            showResults(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddScreen(
                  id: loadedTodo.id!,
                  title: loadedTodo.title!,
                  description: loadedTodo.description!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
