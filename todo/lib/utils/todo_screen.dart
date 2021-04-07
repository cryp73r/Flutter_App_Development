import 'package:flutter/material.dart';
import 'package:todo/models/todo_item.dart';
import 'package:todo/utils/database_client.dart';

import 'date_formatter.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  var db = DatabaseHelper();
  final List<ToDoItem> _itemList = <ToDoItem>[];

  @override
  void initState() {
    super.initState();

    _readToDoList();
  }

  void _handleSubmitted(String text) async {
    _textEditingController.clear();
    
    ToDoItem toDoItem = ToDoItem(text, dateFormatted());
    int savedItemId = await db.saveItem(toDoItem);

    ToDoItem addedItem = await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });

    print("Item Saved ID: $savedItemId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                  reverse: false,
                  itemCount: _itemList.length,
                  itemBuilder: (_, int index) {
                  return Card(
                    color: Colors.white10,
                    child: ListTile(
                      title: _itemList[index],
                      onLongPress: () => _updateItem(_itemList[index], index),
                      trailing: Listener(
                        key: Key(_itemList[index].itemName),
                        child: Icon(Icons.remove_circle, color: Colors.redAccent,),
                        onPointerDown: (pointerEvent) =>
                          _deleteToDo(_itemList[index].id, index),
                      ),
                    ),
                  );
                  }),
          ),
          Divider(
            height: 1.0,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Item",
        backgroundColor: Colors.redAccent,
        child: ListTile(
          title: Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
      ),
    );
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: [
          Expanded(child: TextField(
            controller: _textEditingController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Item",
              hintText: "eg. Buy Stuff",
              icon: Icon(Icons.note_add)
            ),
          ))
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              _handleSubmitted(_textEditingController.text);
              _textEditingController.clear();
              Navigator.pop(context);
            },
            child: Text("Save")),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"))
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
  _readToDoList() async {
    List items = await db.getItems();
    items.forEach((item) {
      ToDoItem toDoItem = ToDoItem.map(item);
      setState(() {
        _itemList.add(toDoItem);
      });
      // print("DB Items: ${toDoItem.itemName}");
    });
  }

  _deleteToDo(int id, int index) async {
    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

  _updateItem(ToDoItem item, int index) {
    var alert = AlertDialog(
      title: Text("Update Item"),
      content: Row(
        children: [
          Expanded(
              child: TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Item",
                  hintText: "eg. Buy Stuff",
                  icon: Icon(Icons.update)
                ),
              ))
        ],
      ),
      actions: [
        TextButton(
            onPressed: () async {
              ToDoItem newItemUpdated = ToDoItem.fromMap(
                {"itemName": _textEditingController.text,
                  "dateCreated": dateFormatted(),
                  "id": item.id
                }
              );
              _handleSubmittedUpdate(index, item);
              await db.updateItem(newItemUpdated);
              setState(() {
                _readToDoList();
              });
              Navigator.pop(context);
            },
            child: Text("Update")),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"))
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _handleSubmittedUpdate(int index, ToDoItem item) {
    setState(() {
      _itemList.removeWhere((element) => _itemList[index].itemName == item.itemName);
    });
  }
}
