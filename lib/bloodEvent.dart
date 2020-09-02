import 'dart:convert';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/bloodEventDetail.dart';
import 'package:easy_blood/constant.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/button_round.dart';
import 'component/input_date.dart';
import 'component/input_round.dart';
import 'dart:convert' show JSON;

import 'component/input_time.dart';

class BloodEvent extends StatefulWidget {
  BloodEvent({Key key}) : super(key: key);

  @override
  _BloodEventState createState() => _BloodEventState();
}

class _BloodEventState extends State<BloodEvent> {
  Future<List<Event>> futureEvent;

  @override
  void initState() {
    super.initState();
    futureEvent = fetchEvent();
  }

  TextEditingController eventName = new TextEditingController();
  TextEditingController eventLocation = new TextEditingController();
  TextEditingController eventTime = new TextEditingController();
  TextEditingController eventDate = new TextEditingController();
  TextEditingController eventOrganizer = new TextEditingController();
  TextEditingController eventPhoneNumber = new TextEditingController();
   var dateStart,dateEnd,timeStart,timeEnd;
  bool _isLoading = false;
  String error = "";
  final _formKey = GlobalKey<FormState>();
  static final Keys1 = GlobalKey();
  static final Keys2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
            home: Scaffold(
                body: Container(
                    width: size.width * 1,
                    height: size.height * 1,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: FutureBuilder(
                            future: fetchEvent(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                    child: LoadingScreen(),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BloodEventDetail(
                                                          event: snapshot
                                                              .data[index])),
                                            );
                                          });
                                        },
                                        child: ListTile(
                                          leading: Image.asset(
                                              "assets/images/dermadarah1.jpg"),
                                          title:
                                              Text(snapshot.data[index].name),
                                          isThreeLine: true,
                                          subtitle: Text(
                                              snapshot.data[index].location),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );

                              // By default, show a loading spinner.
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 10,
                          right: 10,
                          child: Container(
                            width: size.width * 0.9,
                            height: size.height * 0.075,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Color(0xffffbcaf).withOpacity(0.5)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 5,
                          right: 5,
                          child: Container(
                            width: size.width * 0.9,
                            height: size.height * 0.065,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Color(0xffffbcaf).withOpacity(0.9)),
                          ),
                        ),
                        DraggableScrollableSheet(
                            initialChildSize: 0.05,
                            minChildSize: 0.05,
                            maxChildSize: 0.7,
                            builder: (BuildContext c, s) {
                              return Container(
                                width: size.width * 1,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xffffbcaf),
                                          kGradient2.withOpacity(0.7)
                                        ]),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: SingleChildScrollView(
                                  controller: s,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Center(child: Text("ADD EVENT")),
                                          Container(
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Container(
                                                        height: 40,
                                                        width: size.width * 0.27,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(left: 6),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons.camera,
                                                                size: 30.0,
                                                              ),
                                                              Text(
                                                                "Upload",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17.0),
                                                              )
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                  InputRound(
                                                    controller: eventName,
                                                    deco: InputDecoration(
                                                      hintText: "Event Name",
                                                      border: InputBorder.none,
                                                      icon: Icon(
                                                        Icons.event_available,
                                                        color: kThirdColor,
                                                      ),
                                                    ),
                                                    validator: (value) => (value
                                                            .isEmpty)
                                                        ? 'Please enter some text'
                                                        : null,
                                                  ),
                                                  InputRound(
                                                    controller: eventLocation,
                                                    deco: InputDecoration(
                                                      hintText: "Location",
                                                      border: InputBorder.none,
                                                      icon: Icon(
                                                        Icons.location_on,
                                                        color: kThirdColor,
                                                      ),
                                                    ),
                                                    validator: (value) => (value
                                                            .isEmpty)
                                                        ? 'Please enter some text'
                                                        : null,
                                                  ),
                                                  InputRound(
                                                    controller: eventOrganizer,
                                                    deco: InputDecoration(
                                                      hintText: "Organizer",
                                                      border: InputBorder.none,
                                                      icon: Icon(
                                                        Icons.event_available,
                                                        color: kThirdColor,
                                                      ),
                                                    ),
                                                    validator: (value) => (value
                                                            .isEmpty)
                                                        ? 'Please enter some text'
                                                        : null,
                                                  ),
                                                  InputRound(
                                                    controller: eventPhoneNumber,
                                                    deco: InputDecoration(
                                                      hintText: "Phone Number",
                                                      border: InputBorder.none,
                                                      icon: Icon(
                                                        Icons.event_available,
                                                        color: kThirdColor,
                                                      ),
                                                    ),
                                                    validator: (value) => (value
                                                            .isEmpty)
                                                        ? 'Please enter some text'
                                                        : null,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                    Container(
                                                    width: 150,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(20)
                                                    ),
                                                    child: FlatButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20)
                                                        ),
                                                        onPressed: () {
                                                          DatePicker.showDatePicker(context,
                                                              showTitleActions: true,
                                                              minTime: DateTime(2020, 3, 5),
                                                              maxTime: DateTime(2029, 6, 7),
                                                              theme: DatePickerTheme(
                                                                  headerColor: kPrimaryColor,
                                                                  backgroundColor: kThirdColor,
                                                                  itemStyle: TextStyle(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 18),
                                                                  doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                                                              onChanged: (date) {
                                                                print('change $date in time zone ' +
                                                                    date.timeZoneOffset.inHours.toString());
                                                              }, onConfirm: (date) {
                                                                dateStart = date;
                                                                print('confirm ${date}');
                                                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                                                        },
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.date_range),
                                                            Text(
                                                              'Date Start',
                                                              style: TextStyle(color: Colors.black),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                            Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  onPressed: () {
                                                    DatePicker.showDatePicker(context,
                                                        showTitleActions: true,
                                                        minTime: DateTime(2020, 3, 5),
                                                        maxTime: DateTime(2029, 6, 7),
                                                        theme: DatePickerTheme(
                                                            headerColor: kPrimaryColor,
                                                            backgroundColor: kThirdColor,
                                                            itemStyle: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 18),
                                                            doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                                                        onChanged: (date) {
                                                          print('change $date in time zone ' +
                                                              date.timeZoneOffset.inHours.toString());
                                                        }, onConfirm: (date) {
                                                          dateEnd = date;
                                                          print('confirm ${date}');
                                                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(Icons.date_range),
                                                      Text(
                                                        'Date End',
                                                        style: TextStyle(color: Colors.black),
                                                      ),
                                                    ],
                                                  )),
                                            )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                    Container(
                                                    width: 150,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(20)),
                                                    child: FlatButton(
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                        onPressed: () {

                                                          DatePicker.showTime12hPicker(context,
                                                              theme: DatePickerTheme(
                                                                  headerColor: kGradient1,
                                                                  backgroundColor: Colors.white,
                                                                  itemStyle: TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 18),
                                                                  doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
                                                              showTitleActions: true, onChanged: (time) {
                                                                print('change $time in time zone ' +
                                                                    time.timeZoneOffset.inHours.toString());
                                                              }, onConfirm: (time) {
                                                                timeStart=time;
                                                                print('confirm $time');
                                                              }, currentTime: DateTime.now());
                                                        },
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.timer),
                                                            Text(
                                                              "Time Start",
                                                              style: TextStyle(color: Colors.black),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                            Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20)),
                                              child: FlatButton(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                  onPressed: () {

                                                    DatePicker.showTime12hPicker(context,
                                                        theme: DatePickerTheme(
                                                            headerColor: kGradient1,
                                                            backgroundColor: Colors.white,
                                                            itemStyle: TextStyle(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 18),
                                                            doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
                                                        showTitleActions: true, onChanged: (time) {
                                                          print('change $time in time zone ' +
                                                              time.timeZoneOffset.inHours.toString());
                                                        }, onConfirm: (time) {
                                                          timeEnd=time;
                                                          print('confirm $time');
                                                        }, currentTime: DateTime.now());
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(Icons.timer),
                                                      Text(
                                                        "Time End",
                                                        style: TextStyle(color: Colors.black),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  ButtonRound(
                                                    color: Color(0XFF343a69),
                                                    text: "CONFIRM",
                                                    press: () async {
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        print("Validate");
                                                        addEvent();

                                                      } else {
                                                        error =
                                                            "Could  not sign in. Wrong input ";
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    )))));
  }

  Future<List<Event>> fetchEvent() async {

    var res = await Api().getData("event");
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

  Future<void> addEvent() async {
    if (_formKey.currentState.validate()) {
    } else {
      print("Could added. Wrong input ");
    }
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = localStorage.getString("user");
    var user= jsonDecode(userjson);
    var data={
      "name": eventName.text,
      "location": eventLocation.text,
      "phoneNum": eventPhoneNumber.text,
      "dateStart": dateStart.toString(),
      "dateEnd": dateEnd.toString(),
      "organizer": eventOrganizer.text,
      "timeStart":timeStart.toString(),
      "timeEnd": timeEnd.toString(),
      "imageURL": "assets/images/dermadarah2.jpg",
      "user_id": user["_id"],
    };

    var res = await Api().postData(data, "event");
    print(res.statusCode);
    if(res.statusCode==200){
     if(timeStart is DateTime) print(dateStart);
      eventInfoDialog(context);
    }

    }

//  dynamic myEncode(dynamic item) {
//    if(item is DateTime) {
//      return item.toIso8601String();
//    }
//    return item;
//  }

  Future<bool> eventInfoDialog(context){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Event Added"),
            content: Text("Thank you :D"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                },
              )
            ],
          );
        }
    );
  }
}
