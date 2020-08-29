import 'package:easy_blood/constant.dart';
import 'package:easy_blood/signin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RequestBlood extends StatefulWidget {
  @override
  _RequestBloodState createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  TextEditingController location = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
        home: Scaffold(
            body: Container(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.4,
          ),
          Container(
            height: size.height * 0.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [kGradient1, kGradient2]),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "I need blood .. ",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      FaIcon(FontAwesomeIcons.sadCry)
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Form(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: size.height * 0.07,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(32),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            spreadRadius: 3,
                                            blurRadius: 9)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                        hintText: 'Location',
                                      ),
                                      controller: location,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: size.height * 0.07,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(32),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            spreadRadius: 3,
                                            blurRadius: 9)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                        hintText: 'Blood Group',
                                      ),
                                      controller: location,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: size.height * 0.07,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(32),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            spreadRadius: 3,
                                            blurRadius: 9)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                        hintText: 'Reason',
                                      ),
                                      controller: location,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height*0.05,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kPrimaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 7,
                                    spreadRadius: 3,
                                    color: Colors.black.withOpacity(0.25)
                                  )
                                ]
                              ),
                              child: FlatButton(
                                onPressed: (){

                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: FaIcon(FontAwesomeIcons.search
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }
}