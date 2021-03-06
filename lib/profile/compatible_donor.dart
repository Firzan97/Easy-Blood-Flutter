import 'dart:ui';

import 'package:easy_blood/model/request.dart';
import 'package:flutter/material.dart';
import 'package:easy_blood/constant/constant.dart';
import 'package:image/image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:easy_blood/model/user.dart';
import 'package:easy_blood/api/api.dart';
import 'package:easy_blood/loadingScreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_blood/profile/profile.dart';
import 'package:geolocator/geolocator.dart';
import 'package:easy_blood/chat/message_screen.dart';


class CompatibleDonor extends StatefulWidget {
  final String bloodType;
  final String requestId;
  final String userId;

  const CompatibleDonor({Key key, this.bloodType,this.requestId,this.userId}) : super(key: key);
  @override
  _CompatibleDonorState createState() => _CompatibleDonorState();
}

class _CompatibleDonorState extends State<CompatibleDonor> {
  var currentUser;
  List<double> listDistance=[];

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Compatible Donor"),
        centerTitle: true,
        backgroundColor:kPrimaryColor.withOpacity(0.8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height*1,
              width: size.width*1,

              child: FutureBuilder(
                future: findDonor(),
    builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
              child: Center(
                child: LoadingScreen(),
              ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder:
                (BuildContext context, int index) {


              return Padding(
                padding: const EdgeInsets.fromLTRB( 8.0,20.0,8.0,0.0),
                child: Container(
                    height: size.height*0.26,
                    width: size.width*1,

                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            blurRadius: 9,
                                            spreadRadius: 1
                                          )
                                        ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB( 10.0,20.0,10.0,0.0),
                    child: Column(
                      children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                      snapshot.data[index].imageURL
                                  )
                                )
                              ),
                            ),
                            SizedBox(width: size.width*0.03,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data[index].username,style: TextStyle(
                                    fontSize: size.height*0.022,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Muli"
                                ),),
                                Text(snapshot.data[index].bloodtype,style: TextStyle(
                                    fontSize: size.height*0.016,
                                    fontFamily: "Muli"
                                ),)
                              ],
                            ),
                          ],
                        ),

                          Column(
                            children: [
                              Container(
                                height: size.height*0.045,
                                  width: size.width*0.30,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor
                                  ),
                                  child: FlatButton(child: Text("Received Blood From this user",textAlign:TextAlign.center,style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height*0.015,
                                    fontFamily: "Muli"
                                  ),),
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      width: 390,
                                      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                                      headerAnimationLoop: false,
                                      dialogType: DialogType.NO_HEADER,

                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Blood Donor Confirmation',
                                      desc: 'Are you confirm that this donor have donate blood for you?',
                                      btnCancelOnPress: () {
                                        Navigator.of(context, rootNavigator: true).pop();
                                        //Will not exit the App
//                                        Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: (context) => CompatibleDonor(bloodType: widget.bloodType,requestId: widget.requestId,)),
//                                        );
                                      },
                                      btnOkOnPress: () {
                                        Navigator.of(context, rootNavigator: true).pop();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Profile()),
                                        );
                                        //Will not exit the App
                                        receivedDonation(widget.requestId,snapshot.data[index].id);
                                        getQue(snapshot.data[index].notificationToken,snapshot.data[index].username);
//                                    deleteRequest(widget.requestId);

                                      },
                                    )..show();
                                  },)),
                              SizedBox(height: size.height*0.02,),
                              Container(
                                  height: size.height*0.045,
                                  width: size.width*0.30,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor
                                  ),
                                  child: FlatButton(child: Text("Chat User",textAlign:TextAlign.center,style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.height*0.015,
                                      fontFamily: "Muli"
                                  ),),
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MessageScreen(user: snapshot.data[index])),
                                      );
                                    },)),
                            ],
                          )
                      ],),
                        SizedBox(height: size.height*0.05,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: size.height*0.037,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.nature_people_outlined,size: 15,color: kPrimaryColor,),
                                    Text("Gender: ${snapshot.data[index].gender}",style: TextStyle(
                                        fontSize: size.height*0.015,
                                      color:kPrimaryColor,
                                      fontWeight: FontWeight.w900
                                    )),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(


                                  color:text,
                                borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                            Container(
                              height: size.height*0.037,

                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.phone,size: 15,),
                                    Text("${snapshot.data[index].phoneNumber}",style: TextStyle(
                                      fontSize: size.height*0.015,
                                      color: Colors.black,
                                        fontWeight: FontWeight.w900,

                                    ),),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                            ),
                            Container(
                              height: size.height*0.037,

                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.add_location,size: 15,color: kPrimaryColor),
                                    Text("${listDistance[index].toString()} KM",style: TextStyle(
                                        fontSize: size.height*0.015,
                                        color:kPrimaryColor,
                                      fontWeight: FontWeight.w900
                                    ))
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                color:text,


                              ),
                            )

                          ],
                        )
                      ],
                    ),
                  )
                ),
              );
          },
        );
    }

    ),
            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Container(
//                height: size.height*0.3,
//                decoration: BoxDecoration(
//                  color: kPrimaryColor,
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.black.withOpacity(0.1),
//                      spreadRadius: 6,
//                      blurRadius: 8
//                    )
//                  ]
//                ),
//              ),
//            )
          ],
        ),
      ),
    );
  }
  Future<void> fetchBloodDonatedCount(donorId) async {
    int count=0;
    var data;
    var res = await Api().getData("user/${donorId}/request");
    var bodys = json.decode(res.body);

    if (res.statusCode == 200) {
      for (Map u in bodys) {

        Requestor req = Requestor.fromJson(u);
        if(req.donor_id==donorId) {
            count++;

        }
      }
      print(count);

      if(count==1){
        data={
          "achievement_id": "5fd180b744710ef17fc8c6cd"
        };

        var res = await Api().postData(data,"userAchievement/${donorId}");

      }
      else if(count==3){
        data={
          "achievement_id": "5fd1814c44710ef17fc8c6ce"
        };
        var res = await Api().postData(data,"userAchievement/${donorId}");
      }
      else if(count==10){
        data={
          "achievement_id": "5fd1817f44710ef17fc8c6cf"
        };
        var res = await Api().postData(data,"userAchievement/${donorId}");
      }
      else if(count==15){
        data={
          "achievement_id": "5fd1819a44710ef17fc8c6d0"
        };
        var res = await Api().postData(data,"userAchievement/${donorId}");
      }
      else if(count==30){
        data={
          "achievement_id": "5fd181bd44710ef17fc8c6d1"
        };
        var res = await Api().postData(data,"userAchievement/${donorId}");
      }

      if(res.statusCode==200){
        print("babiaaaaaaaaaaaaaaaaaa");

      }
    } else {
      throw Exception('Failed to load album');
    }
  }
Future<void> receivedDonation(requestId,donorId) async{
    var data = {
      "requestId": requestId,
      "donorId": donorId
    };
    print(data);
  var res = await Api().updateData(data,"request/donor");
  print(res.statusCode);
  if(res.statusCode==200){
    print("Yess berjaya sudahh");
    fetchBloodDonatedCount(donorId);
  }

}

 Future<void> getCurrentUser() async{
   SharedPreferences localStorage = await SharedPreferences.getInstance();
   setState(() {
      currentUser =jsonDecode(localStorage.getString("user"));
      print(currentUser);
   });
 }

  Future getQue(token,username) async {
    print("sasasasasa"+ token + username);
    if(token!=null){
      //call php file
      var data={
        "token": token,
        "userName": username,
      };print(token);
      var res = await Api().postData(data,"confirmDonationNotification");
//        return json.decode(res.body);
    }
    else{
      print("Token is null");
    }
  }

  Future<void> deleteRequest(id)async{
    var res = await Api().deleteData("request/${id}");
    if(res.statusCode==200){
      print("Request have been deleted");
    }

  }

  Future<List<User>> findDonor() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userjson = localStorage.getString("user");
    var res = await Api().getData("${widget.bloodType}/findDonor");
    var body = json.decode(res.body);
     print(body);
    if (res.statusCode == 200) {
      List<User> users = [];
      for (var u in body) {
        print("heloooo");
        User user = User.fromJson(u);
        if(user.id!=currentUser["_id"]) {
//        print(double.parse(currentUser['latitude']));
//        print(double.parse(currentUser['longitude']));
//        print(user.latitude);
//        print(user.longitude.runtimeType);
        var distanceInMeters = await Geolocator().distanceBetween(double.parse(currentUser['latitude']),double.parse(currentUser['longitude']),user.latitude, user.longitude);
        print(distanceInMeters);
//        print(user.username);
                              listDistance.add(distanceInMeters/1000);
          users.add(user);

        }
      }
      return users;
    } else {
      throw Exception('Failed to load album');
    }
  }

}
