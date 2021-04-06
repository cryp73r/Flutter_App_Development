import 'package:flutter/material.dart';
import 'package:todo/models/todo_item.dart';
import 'package:todo/utils/database_client.dart';

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
    
    ToDoItem toDoItem = ToDoItem(text, DateTime.now().toIso8601String());
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
                      onLongPress: () => debugPrint(""),
                      trailing: Listener(
                        key: Key(_itemList[index].itemName),
                        child: Icon(Icons.remove_circle, color: Colors.redAccent,),
                        onPointerDown: (pointerEvent) => debugPrint(""),
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
      print("DB Items: ${toDoItem.itemName}");
    });
  }
}
