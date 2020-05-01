import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  double height;
  DateTime now;

  MyAppBar({Key key, this.height, this.now})
      : super(key: key); //Taking height and the time right now as arguments

  String WeekDay() {
    //Function to find the day of the week using the weekday element in DateTime class
    int a = now.weekday;
    switch (a) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
    }
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      //So that the widget covers the whole screen width
      children: <Widget>[
        Card(
            color: Colors.white.withOpacity(0.7),
            elevation: 8.0,
            child: Column(
                //Column contains the Name of the app,the icon in one row and the date and day in another row
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white70.withOpacity(0.4),
                        //Reducing opacity

                        border: Border.all(
                          width: 1.5,
                          color: Colors.teal[400].withOpacity(0.4),
                        )),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 1.0, 1.0, 1.0),
                          child: Row(
                            //This row includes the app icon and the Name of  the app
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: //Using Circle Avatar for viewing the widget
                                    AssetImage(
                                        'assets/secretary.jpg'), //App Icon
                                backgroundColor: Colors.blueAccent[330],
                                radius: 30.0, //Size of the icon
                              ),
                              SizedBox(
                                //To separate the app name and the icon
                                width: 20.0,
                              ),
                              Text(
                                'The Secretary', //App Name
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Courgette',
                                  fontSize: 38.0,
                                  fontStyle: FontStyle.italic,
                                  //Fonts sed from Google Font
                                  color: Colors.teal[400],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          //To separate the two rows
                          height: 14.0,
                        ),
                        Row(
                          children: <Widget>[
                            //This row include the date and the day of the week
                            Text(
                              '${now.day}/${now.month}/${now.year} ',
                              // date in dd/mm/yyyy format
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 28.0,
                                  color: Colors.teal[400].withOpacity(0.7),
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Cardo'),
                            ),
                            SizedBox(
                              width: 80.0, //To separate the day and the date
                            ),
                            Text(
                              WeekDay(),
                              //WeekDay function called to return the day of the week
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 32.0,
                                  color: Colors.teal[400].withOpacity(0.7),
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Cardo'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ])),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height); //Used by the appbar for height
}
