import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_timer_app/data/todo.dart';
import 'package:simple_timer_app/ui/home/create_timer.dart';
import 'package:simple_timer_app/ui/home/edit_timer.dart';
import 'package:simple_timer_app/utils/drawables/svg.dart';

import '../../state/todo_bloc.dart';
import '../../state/todo_state.dart';
import '../../state/todp_event.dart';
import '../../utils/colors/Color.dart';
import '../../utils/drawables/images.dart';
import '../widgets/time_widget.dart';

class TaskDetails extends StatefulWidget {
  final String description;
  final int index;
  final String currentTime;

  @override
  _TaskDetailsState createState() => _TaskDetailsState();

  const TaskDetails(
      {required this.description,
      required this.index,
      required this.currentTime});
}

class _TaskDetailsState extends State<TaskDetails>
    with TickerProviderStateMixin {
  PageController _pageController = PageController();
  int _currentPageIndex = 0;

  late AnimationController animationController;

  String get countText {
    Duration count = animationController.duration! * animationController.value;
    return '${(count.inHours % 60).toString()}:${(count.inMinutes % 60).toString().padLeft(2, "0")}:${(count.inSeconds % 60).toString().padLeft(2, "0")}';
  }

  late bool isPaused;

  void togglePause() {
    print("dpause");
    setState(() {
      if (isPaused) {
        animationController.reverse(from: animationController.value);
      } else {
        animationController.stop();
      }
      isPaused = !isPaused;
    });
  }

  @override
  void initState() {
    super.initState();
    isPaused = false;
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5000));

    animationController.reverse(
        from: animationController.value == 0 ? 1.0 : animationController.value);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(etback)),
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
                            height: 15, width: 15, child: Image.asset(editet))
                      ],
                    )
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton("Timesheet", 0),
                  _buildTabButton("Details", 1),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              // Adjust spacing between the title and the indicators
              _currentPageIndex == 0
                  ? SizedBox(
                      child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 15, top: 1),
                        child: Divider(
                          height: 2,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0),
                        child: _buildTabIndicator(),
                      ),
                    ]))
                  : _currentPageIndex == 1
                      ? SizedBox(
                          child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 15, top: 1),
                            child: Divider(
                              height: 2,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 90.0),
                            child: _buildTabIndicator(),
                          ),
                        ]))
                      : _buildTabIndicatorblack(),

              Expanded(
                  child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: [_timeSheet(widget.description), _taskDetail()],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeSheet(String title) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: littimebg),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Monday",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "17.07.2023",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) => Text(
                          "${countText}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, right: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                final todoBloc =
                                    BlocProvider.of<TodoBloc>(context);
                                todoBloc.add(EditTodo(
                                    widget.index,
                                    Todo(
                                        description: widget.description,
                                        isCompleted: true, isFavorite: false)));
                                print("STOPPED");
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(stop),
                            ),
                          ),
                          isPaused
                              ? GestureDetector(
                                  onTap: () {
                                    togglePause();
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Image.asset(playic)),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    togglePause();
                                  },
                                  child: SvgPicture.asset(etpause),
                                ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Divider(
                      height: 0.1,
                      color: Colors.indigo.shade200,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Description",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditTimer(
                                      description: widget.description,
                                      index: widget.index,
                                    )));
                          },
                          child: SvgPicture.asset(editbg))
                    ],
                  ),
                  Text("${widget.description}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                ],
              ),
            ),

            // Other properties of your container
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10),
              child: Text("Completed Records",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            )
          ],
        ),
        Expanded(
          child: Container(child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              final completedTodos = state.todos
                  .where((todo) => todo.isCompleted == true)
                  .toList();

              return ListView.builder(
                itemBuilder: (context, index) => completedhistory(
                    this.context, true, completedTodos[index].description),
                itemCount: completedTodos.length,
              );
            },
          )),
        )
      ],
    );
  }

  Widget _taskDetail() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: littimebg),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            height: 25, child: SvgPicture.asset(orangeline)),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Apexive: Content Planning",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("Deadline ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "10/11/2023",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Assigned to",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            )),
                      ],
                    ),
                    Text("Ivan Zhuikov",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ],
                ),
              ),

              // Other properties of your container
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: littimebg),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "${widget.description}",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),

            // Other properties of your container
          ),
        ],
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
                color: _currentPageIndex == index ? Colors.white : Colors.white,
                fontWeight: FontWeight.bold),
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
