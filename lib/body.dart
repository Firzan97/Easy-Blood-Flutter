import 'package:easy_blood/constant/constant.dart';
import 'package:easy_blood/component/continueButton.dart';
import 'package:easy_blood/splash_content.dart';
import 'package:easy_blood/welcome/welcome.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int current=0;
  List<Map<String,String>> splashData = [
    {
      "text": "Welcome to Easy Blood. Let's save peoples live!",
      "images": "assets/images/doctorWelcome.png"
    },
    {
      "text": "Discover nearby blood donors and stay updated on their recent and urgent request",
      "images": "assets/images/locationSearch.png"
    },
    {
      "text": "Request blood from a community or any available donors in Malaysia",
      "images": "assets/images/community.png"
    },
    {
      "text": "Enable notifications to receive the latest request needing your blood type",
      "images": "assets/images/notificationBlood.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height*0.1,),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value){
                    setState(() {
                      current = value;
                    });
                  },
                    itemCount: splashData.length,
                    itemBuilder: (context,index)=> SplashContent(
                    image: splashData[index]['images'],
                    text: splashData[index]['text']
                ))
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              splashData.length, (index) => buildDot(index))),
                      Spacer(flex: 3,),
                      continueButton(text: "continue",press:(){Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Welcome()),
                      );})
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
                    margin: EdgeInsets.only(right: 5),
                    height: 6,
                    width: current == index ? 20 : 6,
                    decoration: BoxDecoration(
                      color: current == index ?  kPrimaryColor : Color(0xFFD8D8D8),
                      borderRadius: BorderRadius.circular(3)
                    ),
                  );
  }
}



