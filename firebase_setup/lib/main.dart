import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_setup/model/board.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Board',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Board> boardMessages = [];
  Board board;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();

    board = Board("", "");
    databaseReference = database.reference().child("community-board");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  } // int _counter = 0;

  // void _incrementCounter() {
  //   database.reference().child("message").set({
  //     "firstName": "Priyanshu",
  //     "lastName": "Singh",
  //     "age": 20
  //   });
  //   setState(() {
  //     database.reference().child("message").once().then((DataSnapshot snapshot) {
  //       Map<dynamic, dynamic> data = snapshot.value;
  //
  //       print("Values from db: ${data.values}");
  //       print("Values from db: ${data.keys}");
  //       print("Values from db: ${snapshot.value}");
  //     });
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 0,
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    ListTile(
                      leading: Icon(Icons.subject),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => board.subject = val,
                        validator: (val) => val=="" ? val : null,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.message),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => board.body = val,
                        validator: (val) => val=="" ? val : null,
                      ),
                    ),
                  //  Send or Post Button
                    TextButton(onPressed: () {
                      handleSubmit();
                    },
                      child: Text("Post"),
                      style: TextButton.styleFrom(primary: Colors.black, backgroundColor: Colors.redAccent),
                    )
                  ],
                ),
              )),
          Flexible(
              child: FirebaseAnimatedList(
                query: databaseReference,
                itemBuilder: (_, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                      title: Text(boardMessages[index].subject),
                      subtitle: Text(boardMessages[index].body),
                    ),
                  );
                },
              ),
          ),
        ],
      ),
    );
  }

  void _onEntryAdded(Event event) {
    setState(() {
      boardMessages.add((Board.fromSnapshot(event.snapshot)));
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
    //  Save form data to the database
      databaseReference.push().set(board.toJson());
    }
  }

  void _onEntryChanged(Event event) {
    var oldEntry = boardMessages.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      boardMessages[boardMessages.indexOf(oldEntry)] = Board.fromSnapshot(event.snapshot);
    });
  }
}
