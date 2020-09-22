import 'dart:convert';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:easy_blood/request/blood_request.dart';
import 'package:flutter/cupertino.dart';
import 'file:///C:/Users/Firza/AndroidStudioProjects/easy_blood/lib/service/geolocation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RequestBlood extends StatefulWidget {
  @override
  _RequestBloodState createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  TextEditingController location = new TextEditingController();
  TextEditingController bloodGroup = new TextEditingController();
  TextEditingController reason = new TextEditingController();

  List<Marker> allMarkers = [];
  final locaterService = GeolocationService();
  var currentPosition;

  GoogleMapController _controller;
  GoogleMapController _controller2;
  bool isMapCreated = false;
  var pr;
  changeMapMode() {
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller2.setMapStyle(mapStyle);
  }

  @override
  void initState() {
    super.initState();
    locaterService.getPosition().then((value) => {
          setState(() {
            currentPosition = value;
          })
        });
    currentPosition = locaterService.getPosition();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Loading....',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: LoadingScreen(),
        elevation: 20.0,
        insetAnimCurve: Curves.elasticOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400,fontFamily: "Muli"),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600, fontFamily: "Muli")
    );
    if (isMapCreated) {
      changeMapMode();
    }
    return  Scaffold(
            body: (currentPosition != null)
                ? Container(
                    child:Stack(
                      children: <Widget>[
                        Container(
                          height: size.height * 1,
                          child: GoogleMap(
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(40, -74),
                                zoom: 14.4746,
                              ),
                              zoomControlsEnabled: true,
                              markers: Set.from(
                                (allMarkers),
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller = controller;
                                _controller2 = controller;
                                changeMapMode();
//                                isMapCreated = true;
////                                changeMapMode();
                              }),
                        ),
                        Positioned(
                          right: 0,
                          top: size.height*0.45,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Container(
                              height: size.height*0.05,
                              width: size.width*0.1,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white.withOpacity(0.1),
                                        spreadRadius: 3,
                                        blurRadius: 9
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all((Radius.circular(10)))
                              ),
                              child: Icon(
                                FontAwesomeIcons.mapMarker,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: size.height*0.45,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Container(
                              height: size.height*0.05,
                              width: size.width*0.1,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 9
                                  )
                                ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all((Radius.circular(10)))
                              ),
                              child: Icon(
                                FontAwesomeIcons.locationArrow,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        )
                        ,
                        Positioned(
                          top:
                              size.height*0.55,
                          child: Container(
                            width: size.width*1,
                            height: size.height * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xffffbcaf),
                                    kGradient2.withOpacity(0.7)
                                  ]),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Request Blood",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                    fontFamily: "Muli"),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: size.height * 0.07,
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(0.1),
                                                            spreadRadius: 3,
                                                            blurRadius: 9)
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: TextFormField(
                                                      cursorColor: Colors.black,
                                                      decoration: InputDecoration(
                                                        icon: Icon(
                                                          Icons.location_on,
                                                          color: Colors.redAccent,
                                                        ),
                                                        border: InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.only(
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
                                        DropdownSearch<String>(
                                          mode: Mode.BOTTOM_SHEET,
                                          maxHeight: 260,
                                          items: ["A", "AB", "B", 'O'],
                                          hint: "Blood Group",
                                          autoFocusSearchBox: true,
                                          showClearButton: true,
                                          onChanged: print,
                                          selectedItem: "A",
                                          showSearchBox: false,
                                          searchBoxDecoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                                            labelText: "Search a country",
                                          ),
                                          popupTitle: Container(
                                            width: size.width*0.3,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'BLOOD GROUP',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          popupShape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(24),
                                              topRight: Radius.circular(24),
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
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(0.1),
                                                            spreadRadius: 3,
                                                            blurRadius: 9)
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: TextFormField(
                                                      cursorColor: Colors.black,
                                                      decoration: InputDecoration(
                                                        icon: FaIcon(
                                                        FontAwesomeIcons.tint,
                                                          color: Colors.redAccent,                                                      ),
                                                        border: InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                bottom: 11,
                                                                top: 11,
                                                                right: 15),
                                                        hintText: 'Blood Group',
                                                      ),
                                                      controller: bloodGroup,
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
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(0.1),
                                                            spreadRadius: 3,
                                                            blurRadius: 9)
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: TextFormField(
                                                      cursorColor: Colors.black,
                                                      decoration: InputDecoration(
                                                        icon: Icon(
                                                          Icons.description,
                                                          color: Colors.redAccent,
                                                        ),
                                                        border: InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                bottom: 11,
                                                                top: 11,
                                                                right: 15),
                                                        hintText: 'Reason',
                                                      ),
                                                      controller: reason,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: kPrimaryColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 7,
                                                        spreadRadius: 3,
                                                        color: Colors.black
                                                            .withOpacity(0.25))
                                                  ]),
                                              child: FlatButton(
                                                onPressed: () {
                                                  pr.show();
                                                  addEvent();
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: FaIcon(
                                                    FontAwesomeIcons.search),
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
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Center(child: Text("We dont have your location")),
                  ));
  }

  Future<void> addEvent() async {
//    if (_formKey.currentState.validate()) {
//    } else {
//      print("Could added. Wrong input ");
//    }
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = localStorage.getString("user");
    var user = jsonDecode(userjson);
    var data = {
      "location": location.text,
      "bloodType": bloodGroup.text,
      "reason": reason.text,
      "user_id": user["_id"],
    };

    var res = await Api().postData(data, "request");
    print(res.statusCode);
    if (res.statusCode == 200) {
      pr.hide();
      eventInfoDialog(context);
    }
  }

  Future<bool> eventInfoDialog(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                "Request has been made. Please wait a minute for the system to find suitable donors"),
            content: Text("Thank you :D"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BloodRequest()));
                },
              )
            ],
          );
        });
  }
}
