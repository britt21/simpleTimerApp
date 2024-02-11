import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_timer_app/utils/drawables/svg.dart';

import '../../utils/colors/Color.dart';
import '../../utils/drawables/images.dart';
import '../widgets/time_widget.dart';

class TaskDetail extends StatefulWidget {
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {

  PageController _pageController = PageController();
  int _currentPageIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              drkblu, // Dark Blue at the top
              litblu, // Light Blue at the bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    SvgPicture.asset(etback),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              "Get to know Apexer - Ivan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17),
                            ),
                          ),
                        ],
                      ),

                    ),
                    Row(
                      children: [
                        Container(
                          height: 15,
                            width: 15,
                            child: Image.asset(editet))

                      ],
                    )
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton("Favorites", 0),
                  _buildTabButton("Odoo", 1),

                ],
              ),
              SizedBox(height: 10,),

              // Adjust spacing between the title and the indicators
              _currentPageIndex == 0
                  ? SizedBox(child: Stack(children:[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 15,top: 1),
                  child: Divider(height: 2,color: Colors.grey,),
                ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0),
                      child: _buildTabIndicator(),
                    ),

              ]

              ))
                  : _currentPageIndex == 1
                  ? SizedBox(child: Stack(children:[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 15,top: 1),
                  child: Divider(height: 2,color: Colors.grey,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90.0),
                  child: _buildTabIndicator(),
                ),

              ]

              )): _buildTabIndicatorblack(),


              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: littimebg),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Monday", style: TextStyle(color: Colors.white, fontSize: 12,),),
                        Text("17.07.2023", style: TextStyle(color: Colors.white, fontSize: 13,fontWeight: FontWeight.bold),),
                        Text("Start Time 10:00", style: TextStyle(color: Colors.white, fontSize: 11,)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("08:08:20", style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:10,right: 8.0),
                                  child: SvgPicture.asset(stop),
                                ),
                                SvgPicture.asset(etpause),

                              ],
                            ),
                          ],
                        ),
                         Padding(
                           padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                           child: Divider(height: 0.1,color: Colors.indigo.shade200,),
                         ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Description", style: TextStyle(color: Colors.white, fontSize: 12,)),
                            SvgPicture.asset(editbg)
                          ],
                        ),
                        Text("Sync with Client, communicate, work on the new design with designer, new tasks preparation call with the front end",
                            style: TextStyle(color: Colors.white, fontSize: 12,)),

                      ],
                    ),
                  ),


                  // Other properties of your container
                ),
                
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text("Completed Records",style: TextStyle(color: Colors.white, fontSize: 12)),
                  )
                ],
              ),
              completedhistory(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                color: _currentPageIndex == index ? Colors.white : Colors.white,fontWeight: FontWeight.bold
            ),
          ),

          SizedBox(height: 3),
          // Adjust spacing between the title and the indicators

        ],
      ),
    );
  }

  Widget _buildTabIndicator() {
    return SizedBox(
      height: 3, // Define a height for the SizedBox
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: (_currentPageIndex * (MediaQuery.of(context).size.width / 3)),
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 3,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildTabIndicatorblack() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: (_currentPageIndex * (MediaQuery.of(context).size.width / 3)),
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 3,
      ),
    );
  }



}