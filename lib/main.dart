import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'appbar.dart';
import 'todo.dart';
import 'body.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path_provider
      .getApplicationDocumentsDirectory(); //Adding a path provider
  Hive.init(directory.path); //Initializing hive
  Hive.registerAdapter(TodoAdapter()); // Registering the Tod type Adapter
//  print("Opening directory");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: Hive.openBox('todo'),
          //Opening the box todo where the data will be stored
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) if (snapshot
                .hasError)
              return Text(
                  snapshot.error.toString()); //Printing the error, if any
            else
              return SafeArea(child: Secretary()); //Else starting the screen
            else
              return Scaffold(
                body: SpinKitRotatingCircle(
                    color: Colors.white,
                    size:
                        50.0), //During the loading time, it will use a  Spinkit loader to fill the scaffold screen
              );
          },
        ));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose(); //Closing the Hive
  }
}

class Secretary extends StatefulWidget {
  @override
  _SecretaryState createState() => _SecretaryState();
}

class _SecretaryState extends State<Secretary> {
  final TextEditingController _controller =
      TextEditingController(); //Declaring the controller for the adding text field

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/assistant.jpg', //Adding a background image to the app
              ),
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.modulate),
              //the color filter is used to modify the visibility

              fit: BoxFit.fill //to make the image fit the whole screen
              )),
      child: Scaffold(
        //Adding transparency so that the background image is visible
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          height: 130.0,
          now: DateTime
              .now(), //Using a custom widget for the appbar and passing the height of the appbar we need and the time as parameters
        ),
        body: buildList(), //user defined widget
        floatingActionButton: FloatingActionButton(
          //Button used to add the data
          backgroundColor: Colors.white70.withOpacity(0.6),
          onPressed: () {
            //Displays a dialogue box
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    //Uses an alert dialog
                    elevation: 16.0,
                    backgroundColor: Colors.white12.withOpacity(0.7),
                    //Reducing opacity
                    title: Text(
                      "Add TODO",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.teal[400].withOpacity(0.7),
                          //Title of the dialogue box
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Cardo'),
                    ),

                    //                   Taking the todo as input here

                    content: TextField(
                      style: TextStyle(
                        decorationColor: Colors.white12.withOpacity(0.9),
                        //Adding Style to the text field
                        fontFamily: 'Cardo',
                        fontSize: 25.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter here",
                          labelText: 'Enter a todo to add'),
                      controller:
                          _controller, //this controller has been declared above
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'Add',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              //After pressing the button "Add" the data will be added to the list
                              fontSize: 28.0,
                              color: Colors.pinkAccent.withOpacity(0.7),
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Cardo'),
                        ),
                        onPressed: () {
                          final Todo entry = Todo(
                              task: _controller
                                  .text); //Creating a class instance to store the entered data
                          //To add the data into the database we se a user defined function add_todo which takes the text entered as input

//                          print("Adding the entry");
                          add_todo(Todo(task: _controller.text));
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                });
          },
          child: Icon(
            //Icon for the floating action button
            Icons.add,
            color: Colors.teal[400],
          ),
        ),
      ),
    );
  }

  void add_todo(Todo entry) {
    print(entry.title); // function to add the data tp the database
    final element = Hive.box("todo");
//    print("Added item to the list");
    element.add(entry);
  }
}
