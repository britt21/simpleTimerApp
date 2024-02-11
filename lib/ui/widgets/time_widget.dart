import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/colors/Color.dart';
import '../../utils/drawables/svg.dart';

Widget timewidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
    child: Container(
      height: 120.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: littimebg, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Row(
                children: [SvgPicture.asset(orangeline)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: SvgPicture.asset(startic),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "iOS app deployment\nwith odd",
                            style: TextStyle(
                                color: white, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(workic),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "SO056 - Booqio V2",
                            style: TextStyle(color: white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(timeic),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "Deadline 07/20/2023",
                          style: TextStyle(color: white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "00:30",
                    style: TextStyle(color: Colors.black),
                  ),
                  SvgPicture.asset(pause)
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget completedhistory(BuildContext context,bool expand) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
    child: Container(
      decoration: BoxDecoration(
          color: littimebg, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12.0,
          left: 15,
          right: 15
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Column(
                        children: [
                          SvgPicture.asset(done),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sunday",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "16.06.2023",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),

                          Text("Start Time 10:00",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              )),
                        ],
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 35,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), color: timerBg3),
                        child: Center(child: Text("8:30",style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,fontWeight: FontWeight.bold,
                        ))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(child: completedhistoryDetail(context),visible: expand,)
          ],
        ),
      ),
    ),
  );
}

Widget completedhistoryDetail(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: littimebg, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Divider(
                height: 0.1,
                color: Colors.indigo.shade200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Description",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                  SvgPicture.asset(editbg)
                ],
              ),
            ),
            Text(
                "Sync with Client, communicate, work on the new design with designer, new tasks preparation call with the front end",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                )),
          ],
        ),
      ),
    ),
  );
}
