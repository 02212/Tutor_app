import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_tut/pages/video_info.dart';
import 'package:video_tut/services/auth_services.dart';
import '../shared/colors.dart' as color;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List info = [];
  _initData() {
    DefaultAssetBundle.of(context).loadString("json/info.json").then((value) {
      info = json.decode(value);
    });
  }

  AuthServices authServices = AuthServices();
  @override
  void initState() {
    super.initState();
    _initData();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.AppColor.homePageBackground,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 70,
            left: 30,
            right: 30,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Tutorials',
                    style: TextStyle(
                      fontSize: 30,
                      color: color.AppColor.homePageTitle,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: color.AppColor.homePageIcons,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.calendar_today_outlined,
                      size: 20, color: color.AppColor.homePageIcons),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: color.AppColor.homePageIcons,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Your Programme',
                    style: TextStyle(
                      fontSize: 20,
                      color: color.AppColor.homePageSubtitle,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 20,
                      color: color.AppColor.homePageDetail,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => VideoInfo());
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: color.AppColor.homePageIcons,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      color.AppColor.gradientFirst.withOpacity(0.8),
                      color.AppColor.gradientSecond.withOpacity(.9),
                    ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(100),
                        topRight: Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          blurRadius: 10,
                          color: color.AppColor.gradientSecond.withOpacity(0.2))
                    ]),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 25, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Next Lesson',
                            style: TextStyle(
                              fontSize: 16,
                              color: color.AppColor.homePageContainerTextSmall,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(child: Container()),
                          Icon(
                            Icons.timer,
                            size: 20,
                            color: color.AppColor.homePageContainerTextSmall,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '30 min',
                            style: TextStyle(
                              fontSize: 13,
                              color: color.AppColor.homePageContainerTextSmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Physical Science',
                        style: TextStyle(
                          fontSize: 25,
                          color: color.AppColor.homePageContainerTextSmall,
                        ),
                      ),
                      Text(
                        'Grade 12 (Matric)',
                        style: TextStyle(
                          fontSize: 25,
                          color: color.AppColor.homePageContainerTextSmall,
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            boxShadow: [
                              BoxShadow(
                                color: color.AppColor.gradientFirst,
                                blurRadius: 10,
                                offset: Offset(2, 4),
                              )
                            ]),
                        child: Icon(
                          Icons.play_circle_fill,
                          size: 50,
                          color: color.AppColor.homePageContainerTextSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 30),
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage('img/study_card.jpg'),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 40,
                                offset: Offset(-5, -8),
                                color: color.AppColor.gradientSecond
                                    .withOpacity(0.3))
                          ]),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                        right: 180,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage('img/study.png'),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 180,
                                offset: Offset(-8, -10),
                                color: color.AppColor.gradientSecond
                                    .withOpacity(0.2))
                          ]),
                    ),
                    Container(
                        width: double.maxFinite,
                        height: 100,
                        margin: const EdgeInsets.only(left: 150, top: 50),
                        child: Column(
                          children: [
                            Text(
                              'Your doing great',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: color.AppColor.homePageDetail),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Keep it up\n',
                                  style: TextStyle(
                                      color: color.AppColor.homePagePlanColor,
                                      fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: 'Stick To our plan',
                                    )
                                  ]),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Subjects/Modules',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: color.AppColor.homePageTitle),
                  )
                ],
              ),
              Expanded(
                  child: OverflowBox(
                maxWidth: MediaQuery.of(context).size.width,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      itemCount: (info.length.toDouble() / 2).toInt(),
                      itemBuilder: (_, i) {
                        int a = 2 * i;
                        int b = 2 * i + 1;
                        return Row(
                          children: [
                            Container(
                                height: 170,
                                width:
                                    (MediaQuery.of(context).size.width - 90) /
                                        2,
                                margin: EdgeInsets.only(
                                    left: 30, bottom: 15, top: 15),
                                padding: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: AssetImage(info[a]['img']),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        offset: Offset(5, 5),
                                        color: color.AppColor.gradientSecond
                                            .withOpacity(0.1),
                                      ),
                                      BoxShadow(
                                        blurRadius: 3,
                                        offset: Offset(-5, -5),
                                        color: color.AppColor.gradientSecond
                                            .withOpacity(0.1),
                                      )
                                    ]),
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(info[a]['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                color.AppColor.homePageDetail)),
                                  ),
                                )),
                            Container(
                                height: 170,
                                width:
                                    (MediaQuery.of(context).size.width - 90) /
                                        2,
                                margin: EdgeInsets.only(
                                    left: 30, bottom: 15, top: 15),
                                padding: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: AssetImage(info[b]['img'])),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        offset: Offset(5, 5),
                                        color: color.AppColor.gradientSecond
                                            .withOpacity(0.1),
                                      ),
                                      BoxShadow(
                                        blurRadius: 3,
                                        offset: Offset(-5, -5),
                                        color: color.AppColor.gradientSecond
                                            .withOpacity(0.1),
                                      )
                                    ]),
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(info[b]['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                color.AppColor.homePageDetail)),
                                  ),
                                ))
                          ],
                        );
                      }),
                ),
              ))
            ],
          ),
        ));
  }
}
