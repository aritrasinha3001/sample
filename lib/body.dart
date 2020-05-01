import 'package:flutter/material.dart';
import 'todo.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Widget buildList() {
  //controller used for update text field
  final TextEditingController controller = TextEditingController();
  final elements = Hive.box('todo');

  return ValueListenableBuilder(
      //Creating a value Listenable builder function to show the change of state on the screen
      valueListenable: Hive.box('todo').listenable(),
      builder: (context, Box todo, _) {
//        print("Adding item to the list view"); 
// ListView  function to show all the data
        return ListView.builder(
            //Using the no. of data elements in the box as the limit
            itemCount: elements.length,
            itemBuilder: (context, index) {
              //Using the index of the data elements to retrieve the data
              final entry = elements.getAt(
                  index); 
              //Using a container to show the data, ListTile also could have been used here
              return Container(
                margin: EdgeInsets.all(4.0),
                width: 50.0,
                height: 170.0,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                //Adding a Card to display the data
                child: Card(
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    side: BorderSide(
                      width:2.0,
                          color: Colors.white70.withOpacity(0.5)
                    )
                  ),

                    color: Colors.white70.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          entry.title, // Displaying the data
                          style: TextStyle(
                            fontFamily: 'Cardo',
                            fontSize: 25.0,
                            //Fonts downloaded from Google fonts
                            fontStyle: FontStyle.italic,
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                        Row(
                          //This row includes the buttons which provide the option to delete and update data
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              //Update Button
                              onPressed: () {
                                showDialog(
                                    //Dialog here uses the entered data to overwrite the existing value of data
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        elevation: 16.0,
                                        backgroundColor:
                                            Colors.white12.withOpacity(0.7),
                                        title: Text(
                                          "Add TODO",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 28.0,
                                              color: Colors.teal[400]
                                                  .withOpacity(0.7),
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Cardo'),
                                        ),

//                   Taking the todo as input here

                                        content: TextField(
                                          style: TextStyle(
                                            decorationColor:
                                                Colors.white12.withOpacity(0.9),
                                            fontFamily: 'Cardo',
                                            fontSize: 25.0,
                                            fontStyle: FontStyle.italic,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: InputDecoration(
                                              //Adding style to the text field
                                              border: InputBorder.none,
                                              hintText: "Enter here",
                                              labelText: 'Enter a todo to add'),
                                          controller:
                                              controller, //this controller has been declared above
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'Update',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 28.0,
                                                  color: Colors.pinkAccent
                                                      .withOpacity(0.7),
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Cardo'),
                                            ),
                                            onPressed: () {
                                              final Todo entry =
                                                  Todo(task: controller.text);
                                              final elements = Hive.box('todo');
//                                              print("Updating the entry");
                                              //Overwriting the data at the current index
                                              //Overwriting the data at the current index
                                              elements.putAt(index, entry);
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                //Refresh icon is added
                                Icons.refresh,
                                color: Colors.teal[400],
                                size: 40.0,
                              ),
                              iconSize: 40.0,
                            ),
                            SizedBox(
                              //To separate the buttons
                              width: 40.0,
                            ),
                            IconButton(
                              //Delete button
                              iconSize: 40.0,
                              icon: Icon(
                                Icons.delete,
                                color: Colors.teal[400],
                                size: 40.0,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      //Alert dialog is used to confirm the decision of deletion
                                      return AlertDialog(
                                        backgroundColor:
                                            Colors.white70.withOpacity(0.7),
                                        elevation: 16.0,
                                        title: Text(
                                          "Delete TODO",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 28.0,
                                              color: Colors.teal[400]
                                                  .withOpacity(0.7),
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Cardo'),
                                        ),
                                        //Message to be displayed
                                        content: Text(
                                          "Are you sure you want to delete the TODO?",
                                          style: TextStyle(
                                            fontFamily: 'Cardo',
                                            fontSize: 30.0,
                                            //Fonts downloaded from Google fonts
                                            fontStyle: FontStyle.italic,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            //On pressing this the deletion won't take place
                                            child: Text(
                                              "Cancel",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 28.0,
                                                  color: Colors.teal[400]
                                                      .withOpacity(0.7),
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Cardo'),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); //Doing nothing but coming out of the dialog box
                                            },
                                          ),
                                          FlatButton(
                                            //This will delete the data
                                            child: Text(
                                              "Delete",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 28.0,
                                                  color: Colors.teal[400]
                                                      .withOpacity(0.7),
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily: 'Cardo'),
                                            ),
                                            onPressed: () {
                                              final elements = Hive.box('todo');
                                              //Deleting the data at the current index
                                              elements.deleteAt(index);
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                            )
                          ],
                        ),
                      ],
                    )),
              );
            });
      });
}
