import 'package:flutter/material.dart';

import 'package:todoaeth/note_list.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItem();
        },
        child: Icon(Icons.add, color: Colors.purple.shade200, size: 35),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.purple.shade200],
                    begin: Alignment.topRight,
                    end: Alignment.centerRight)),
            child: Image.network(
                height: 100,
                'https://icon-library.com/images/todo-icon/todo-icon-17.jpg'),
            width: double.infinity,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: Note.list.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete),
                    ),
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      setState(() {
                        Note.list.removeAt(index);
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      color: Colors.blueAccent.shade100,
                      child: ListTile(
                        title: Text(Note.list[index]['title'] as String),
                        subtitle: Text(Note.list[index]['note']),
                        onTap: (() {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                children: [
                                  TextField(
                                    onChanged: ((value) {
                                      setState(() {});
                                    }),
                                  ),
                                  TextField(),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      child: Text('save'))
                                ],
                              );
                            },
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addItem() {
    showDialog(
      context: context,
      builder: (context) {
        final title = TextEditingController();
        final note = TextEditingController();
        return AlertDialog(
          title: Text('Add Notes'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.blue[100]),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: note,
                decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.blue[100]),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  Note.list.add({'title': title.text, 'note': note.text});
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void editItem(context, index) {
    String updatedItem = 'Updated Item';
    showDialog(
      context: context,
      builder: (context) {
        final textFieldController =
            TextEditingController(text: Note.list[index]);
        return AlertDialog(
          title: Text('Edit Item'),
          content: TextField(
            controller: textFieldController,
            decoration: InputDecoration(hintText: 'Item Name'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  Note.list[index] = textFieldController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
