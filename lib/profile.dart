import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:easy_blood/edit_profile.dart';
import 'package:easy_blood/model/donation.dart';
import 'package:easy_blood/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/component/curvedBackground.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/home.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/event.dart';
import 'package:easy_blood/model/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<List<Requestor>> _futureRequest;
  Future<List<Donation>> _futureDonation;
  Future<List<Event>> _futureEvent;


  var user;

  void getUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = jsonDecode(localStorage.getString("user"));

    });
    print(user['_id']);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    _futureRequest = fetchRequest();
    _futureDonation = fetchDonation();
    _futureEvent = fetchEvent();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return  user==null ? LoadingScreen() : AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(theme: ThemeData(fontFamily: "Muli"),
            home: Scaffold(
              body: Container(
                color: Colors.grey.withOpacity(0.1),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height * 1,
                      child: Stack(
                        children: <Widget>[
                          ClipPath(
                            clipper: MyClipper2(),
                            child: Container(
                              height: size.height * 0.42,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [kGradient2, kGradient1]),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 12,
                                        spreadRadius: 3,
                                        color: Colors.black.withOpacity(0.9)
                                    )
                                  ]),
                            ),
                          ),
                          Opacity(
                            opacity: 0.9,
                            child: Container(
                              height: size.height * 1,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [kGradient1, kGradient2]),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                          );
                                        },
                                        icon: Icon(Icons.arrow_back,
                                          color: Colors.black,),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.settings, color: Colors.black,),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfile()),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Container(
                                      height: 100,
                                      child: Stack(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: user['imageURL'] ==
                                                            null
                                                            ? NetworkImage(
                                                            'https://easy-blood.s3-ap-southeast-1.amazonaws.com/loadingProfileImage.jpg')
                                                            : NetworkImage(
                                                            user['imageURL'])
                                                    )
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.05,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Text("Firzan Azrai",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                          fontWeight: FontWeight
                                                              .bold
                                                      )),
                                                  SizedBox(height: size.height *
                                                      0.01,),
                                                  Text("Joined 3 days ago",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5)
                                                    ),),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.location_on),
                                              Text("Tumpat, Kelantan")
                                            ],
                                          ),
                                        ),
                                        Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(20),
                                                color: kPrimaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 12
                                                  )
                                                ]
                                            ),
                                            child: FlatButton(
                                              onPressed: () {

                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(20)
                                              ),
                                              child: Text("AB+"),
                                            )),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [BoxShadow(
                                              blurRadius: 9,
                                              spreadRadius: 3,
                                              color: Colors.black.withOpacity(
                                                  0.1)
                                          )
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              10)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("4"),
                                                  Text("Blood donated")
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text("4"),
                                                Text("Blood Requested")
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text("Status"),
                                                Text("Eligible to donate")
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.045,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: size.width * 1,

                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.2),
                                                blurRadius: 9,
                                                spreadRadius: 3
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              20)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        width: size.width * 0.4,
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                right: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                        0.1),
                                                                    width: 1.0))
                                                        ),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(Icons
                                                                .verified_user),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    "Username"),
                                                                Text(
                                                                    user["username"]),
                                                                SizedBox(
                                                                  height: size
                                                                      .height *
                                                                      0.02,),

                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(Icons
                                                                .supervised_user_circle),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                                Text("Gender"),
                                                                Text(
                                                                    user["username"]),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ), Container(
                                              width: size.width * 1,
                                              decoration: BoxDecoration(
                                                  border: Border.symmetric(
                                                      vertical: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          width: 1.0))
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(Icons.email),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Text("Email"),
                                                      Text(
                                                          "FirzanAzrai97@gmail.com"),
                                                      SizedBox(
                                                        height: size.height *
                                                            0.02,),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 1,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          width: 1.0))
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(Icons.person),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,

                                                    children: <Widget>[
                                                      Text("Age"),
                                                      Text("23"),
                                                      SizedBox(
                                                        height: size.height *
                                                            0.02,),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 1,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          width: 1.0))
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(Icons.phone),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        Text("Mobile Number"),
                                                        Text("019-2351520"),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.02,),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 1,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          width: 1.0))
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(Icons.brush),
                                                        Text("Height"),
                                                        SizedBox(
                                                          width: size.width *
                                                              0.52,),
                                                        Text("170 CM")

                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: size.height *
                                                          0.02,),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 1,
                                              decoration: BoxDecoration(

                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(Icons.line_weight),
                                                        Text("Weight"),
                                                        SizedBox(
                                                          width: size.width *
                                                              0.54,),
                                                        Text("60 KG"),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: size.height *
                                                          0.02,),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DraggableScrollableSheet(
                              initialChildSize: 0.05,
                              minChildSize: 0.05,
                              maxChildSize: 0.8,
                              builder: (BuildContext c, s) {
                                return Container(
                                  height: size.height * 0.2,
                                  width: size.width * 1,
                                  decoration: BoxDecoration(
                                      color: kGradient1.withOpacity(0.3),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(
                                                0.1),
                                            blurRadius: 7,
                                            spreadRadius: 4
                                        )
                                      ]),
                                  child: SingleChildScrollView(
                                    controller: s,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: size.height * 0.007),
                                        Container(
                                          height: 30,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(20),
                                              color: Colors.black
                                          ),
                                          child: Center(
                                            child: Text("Your Activities",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Muli",
                                                  color: Colors.white
                                              ),),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(19.0),
                                          child: Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  width: size.width * 1,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                0.1),
                                                            spreadRadius: 3,
                                                            blurRadius: 12
                                                        )
                                                      ]
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: size.height *
                                                            0.03,),
                                                      FutureBuilder(
                                                          future: _futureEvent,
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot.data ==
                                                                null) {
                                                              return Container(
                                                                child: Center(
                                                                  child: LoadingScreen(),
                                                                ),
                                                              );
                                                            }
                                                            return Container(
                                                              height: size
                                                                  .height * 0.4,
                                                              child: ListView
                                                                  .builder(
                                                                  itemCount: snapshot
                                                                      .data
                                                                      .length,
                                                                  itemBuilder: (
                                                                      BuildContext context,
                                                                      int index) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          15.0),
                                                                      child: Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            height: 50,
                                                                            width: 60,
                                                                            decoration: BoxDecoration(
                                                                              shape: BoxShape
                                                                                  .rectangle,
                                                                            ),
                                                                            child: ClipRRect(
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    5),
                                                                                child: Image
                                                                                    .asset(
                                                                                  "assets/images/lari2.jpg",
                                                                                  fit: BoxFit
                                                                                      .cover,)),
                                                                          ),
                                                                          SizedBox(
                                                                            width: size
                                                                                .width *
                                                                                0.09,),
                                                                          Column(
                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                .start,
                                                                            children: <
                                                                                Widget>[
                                                                              Text(
                                                                                  "6 hours ago"),
                                                                              Row(
                                                                                children: <
                                                                                    Widget>[
                                                                                  Container(
                                                                                    child: Text(
                                                                                        "Syazwan Asraf"),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: size
                                                                                        .width *
                                                                                        0.08,),
                                                                                  Container(
                                                                                    child: Row(
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Row(
                                                                                          children: <
                                                                                              Widget>[
                                                                                            Icon(
                                                                                                Icons
                                                                                                    .thumb_up),
                                                                                            Text(
                                                                                                "1")
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: size
                                                                                              .width *
                                                                                              0.05,),
                                                                                        Row(
                                                                                          children: <
                                                                                              Widget>[
                                                                                            Icon(
                                                                                                Icons
                                                                                                    .comment),
                                                                                            Text(
                                                                                                "1")
                                                                                          ],
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }
                                                              ),
                                                            );
                                                          }
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      color: kGradient2
                                                  ),
                                                  child: Center(
                                                    child: Text("Life Saved",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w700,
                                                          fontFamily: "Muli",
                                                          color: Colors.white
                                                      ),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(19.0),
                                          child: Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  width: size.width * 1,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                0.1),
                                                            spreadRadius: 3,
                                                            blurRadius: 12
                                                        )
                                                      ]
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: size.height *
                                                            0.03,),
                                                      FutureBuilder(
                                                          future: _futureRequest,
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot.data ==
                                                                null) {
                                                              return Container(
                                                                child: Center(
                                                                  child: LoadingScreen(),
                                                                ),
                                                              );
                                                            }
                                                            return Container(
                                                              height: size
                                                                  .height * 0.4,
                                                              child: ListView
                                                                  .builder(
                                                                  itemCount: snapshot
                                                                      .data
                                                                      .length,
                                                                  itemBuilder: (
                                                                      BuildContext context,
                                                                      int index) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          15.0),
                                                                      child: Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            height: 50,
                                                                            width: 60,
                                                                            decoration: BoxDecoration(
                                                                              shape: BoxShape
                                                                                  .rectangle,
                                                                            ),
                                                                            child: ClipRRect(
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    5),
                                                                                child: Image
                                                                                    .asset(
                                                                                  "assets/images/lari2.jpg",
                                                                                  fit: BoxFit
                                                                                      .cover,)),
                                                                          ),
                                                                          SizedBox(
                                                                            width: size
                                                                                .width *
                                                                                0.09,),
                                                                          Column(
                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                .start,
                                                                            children: <
                                                                                Widget>[
                                                                              Text(
                                                                                  "6 hours ago"),
                                                                              Row(
                                                                                children: <
                                                                                    Widget>[
                                                                                  Container(
                                                                                    child: Text(
                                                                                        "Syazwan Asraf"),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: size
                                                                                        .width *
                                                                                        0.08,),
                                                                                  Container(
                                                                                    child: Row(
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Row(
                                                                                          children: <
                                                                                              Widget>[
                                                                                            Icon(
                                                                                                Icons
                                                                                                    .thumb_up),
                                                                                            Text(
                                                                                                "1")
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: size
                                                                                              .width *
                                                                                              0.05,),
                                                                                        Row(
                                                                                          children: <
                                                                                              Widget>[
                                                                                            Icon(
                                                                                                Icons
                                                                                                    .comment),
                                                                                            Text(
                                                                                                "1")
                                                                                          ],
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }
                                                              ),
                                                            );
                                                          }
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      color: kGradient2
                                                  ),
                                                  child: Center(
                                                    child: Text("Your Requests",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w700,
                                                          fontFamily: "Muli",
                                                          color: Colors.white
                                                      ),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(19.0),
                                          child: Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  width: size.width * 1,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                0.1),
                                                            spreadRadius: 3,
                                                            blurRadius: 12
                                                        )
                                                      ]
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: size.height *
                                                            0.03,),
                                                      FutureBuilder(
                                                          future: _futureDonation,
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot.data ==
                                                                null) {
                                                              return Container(
                                                                child: Center(
                                                                  child: LoadingScreen(),
                                                                ),
                                                              );
                                                            }
                                                            return Container(
                                                              height: size
                                                                  .height * 0.4,
                                                              child: ListView
                                                                  .builder(
                                                                  itemCount: snapshot
                                                                      .data
                                                                      .length,
                                                                  itemBuilder: (
                                                                      BuildContext context,
                                                                      int index) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          15.0),
                                                                      child: Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            height: 50,
                                                                            width: 60,
                                                                            decoration: BoxDecoration(
                                                                              shape: BoxShape
                                                                                  .rectangle,
                                                                            ),
                                                                            child: ClipRRect(
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    5),
                                                                                child: Image
                                                                                    .asset(
                                                                                  "assets/images/lari2.jpg",
                                                                                  fit: BoxFit
                                                                                      .cover,)),
                                                                          ),
                                                                          SizedBox(
                                                                            width: size
                                                                                .width *
                                                                                0.09,),
                                                                          Column(
                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                .start,
                                                                            children: <
                                                                                Widget>[
                                                                              Text(
                                                                                  "6 hours ago"),
                                                                              Row(
                                                                                children: <
                                                                                    Widget>[
                                                                                  Container(
                                                                                    child: Text(
                                                                                        "Syazwan Asraf"),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: size
                                                                                        .width *
                                                                                        0.08,),
                                                                                  Container(
                                                                                    child: Row(
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Row(
                                                                                          children: <
                                                                                              Widget>[
                                                                                            Icon(
                                                                                                Icons
                                                                                                    .thumb_up),
                                                                                            Text(
                                                                                                "1")
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: size
                                                                                              .width *
                                                                                              0.05,),
                                                                                        Row(
                                                                                          children: <
                                                                                              Widget>[
                                                                                            Icon(
                                                                                                Icons
                                                                                                    .comment),
                                                                                            Text(
                                                                                                "1")
                                                                                          ],
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }
                                                              ),
                                                            );
                                                          }
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      color: kGradient2
                                                  ),
                                                  child: Center(
                                                    child: Text("Event Added",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w700,
                                                          fontFamily: "Muli",
                                                          color: Colors.white
                                                      ),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }

  Future<List<Requestor>> fetchRequest() async {

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("user/${user['_id']}/request");
    var bodys = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Requestor> requests = [];
      var count = 0;
      for (Map u in bodys) {
        count++;
        print(count);
        print(u);
        Requestor event = Requestor.fromJson(u);
        print('dapat');
        requests.add(event);
      }

      return requests;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Event>> fetchEvent() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("${user['_id']}/event");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Event> events = [];
      for (Map u in body) {
        Event event = Event.fromJson(u);
        events.add(event);
      }

      return events;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Donation>> fetchDonation() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString("user"));
    var res = await Api().getData("${user['_id']}/donation");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      List<Donation> donations = [];
      for (Map u in body) {
        Donation donation = Donation.fromJson(u);
        donations.add(donation);
      }

      return donations;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
