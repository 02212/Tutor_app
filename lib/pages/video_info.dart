import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List info = [];
  _initData() {
    DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      info = json.decode(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.AppColor.gradientFirst.withOpacity(0.9),
            color.AppColor.gradientSecond,
          ],
          begin: const FractionalOffset(0.0, 0.4),
          end: Alignment.topRight,
        ),
      ),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: color.AppColor.secondPageIconColor,
                    ),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.info_outline,
                    color: color.AppColor.secondPageIconColor,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Phyical Science',
                style: TextStyle(
                  fontSize: 25,
                  color: color.AppColor.secondPageTitleColor,
                ),
              ),
              Text(
                'Grade 12 (Matric)',
                style: TextStyle(
                  fontSize: 25,
                  color: color.AppColor.secondPageTitleColor,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            color.AppColor.secondPageContainerGradient1stColor,
                            color.AppColor.secondPageContainerGradient2ndColor
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        )),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer,
                            size: 20,
                            color: color.AppColor.secondPageIconColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '30 mins',
                            style: TextStyle(
                                fontSize: 16,
                                color: color.AppColor.secondPageIconColor),
                          )
                        ]),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 220,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            color.AppColor.secondPageContainerGradient1stColor,
                            color.AppColor.secondPageContainerGradient2ndColor
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        )),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.work,
                            size: 20,
                            color: color.AppColor.secondPageIconColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Newton's Law of motion",
                            style: TextStyle(
                                fontSize: 16,
                                color: color.AppColor.secondPageIconColor),
                          )
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Newton first law of motion',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Icon(
                        Icons.loop,
                        size: 30,
                        color: color.AppColor.loopColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('2 Topics',
                          style: TextStyle(
                              fontSize: 15, color: color.AppColor.setsColor))
                    ],
                  ),
                  SizedBox(width: 20),
                ],
              )
            ],
          ),
        ))
      ]),
    ));
  }
}
