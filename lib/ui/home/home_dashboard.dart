import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_timer_app/data/todo.dart';
import 'package:simple_timer_app/state/todo_bloc.dart';
import 'package:simple_timer_app/state/todo_state.dart';
import 'package:simple_timer_app/state/todp_event.dart';
import 'package:simple_timer_app/ui/home/create_timer.dart';
import 'package:simple_timer_app/ui/home/task_details.dart';
import 'package:simple_timer_app/ui/widgets/time_widget.dart';
import 'package:simple_timer_app/utils/colors/Color.dart';
import 'package:flutter/services.dart';
import 'package:simple_timer_app/utils/drawables/svg.dart';
import 'package:simple_timer_app/utils/navigation/navigation.dart';
import '../../utils/drawables/images.dart';

import 'package:flutter/material.dart';

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with TickerProviderStateMixin {
  PageController _pageController = PageController();
  int _currentPageIndex = 0;
  late AnimationController animationController;

  String get countText {
    Duration count = animationController.duration! * animationController.value;
    return '${(count.inHours % 60).toString()}:${(count.inMinutes % 60).toString().padLeft(2, "0")}:${(count.inSeconds % 60).toString().padLeft(2, "0")}';
  }

  @override
  void initState() {
    super.initState();
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
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Timesheets",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateTimer(
                                    description: '',
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(addtodo),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTabButton("Favorites", 0),
                          _buildTabButton("Odoo", 1),
                          _buildTabButton("Local", 2),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                                padding: const EdgeInsets.only(left: 40.0),
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
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: _buildTabIndicator(),
                                  ),
                                ]))
                              : _currentPageIndex == 2
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
                                        padding:
                                            const EdgeInsets.only(left: 1.0),
                                        child: _buildTabIndicator(),
                                      ),
                                    ]))
                                  : _buildTabIndicatorblack(),
                    ],
                  ),
                  // Divider(thickness: 1,color: Colors.indigo[200],),

                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                      children: [
                        _emptyFavPage("No favorited timers yet",
                            "You can mark a timer as favorite either on\nthe timer creation page or within an existing\ntimer"),
                        _withDataOdooPage(),
                        _emptyLocalPage("You don’t have any local timesheets",
                            "Create a timer to to begin tracking time"),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(time_sheet),
                        SvgPicture.asset(projects),
                        Container(
                            height: 50,
                            width: 50,
                            child: Image.asset(dsettings))
                      ],
                    ),
                  )
                ],
              ),
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

  Widget _emptyOdooPage(String mainText, String subText) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 160,
              width: 160,
              child: SvgPicture.asset(odologo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              mainText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              subText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateTimer(
                            description: '',
                          )));
                },
                child: SvgPicture.asset(getstbtn)),
          )),
        ],
      ),
    );
  }

  Widget _emptyLocalPage(String mainText, String subText) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 160,
              width: 160,
              child: SvgPicture.asset(dtime),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              mainText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              subText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: GestureDetector(
                onTap: () {}, child: SvgPicture.asset(getstbtn)),
          )),
        ],
      ),
    );
  }

  Widget _emptyFavPage(String mainText, String subText) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 160,
              width: 160,
              child: SvgPicture.asset(starlogo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              mainText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              subText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: SvgPicture.asset(getstbtn),
          )),
        ],
      ),
    );
  }

  Widget _withDataOdooPage() {
    return Column(children: [
      BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        final completedTodos =
            state.todos.where((todo) => todo.isCompleted == false).toList();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 0, left: 15),
                    child:completedTodos.length != 0 ? Text(
                      "You have ${completedTodos.length} Timers",
                      style: TextStyle(color: white, fontWeight: FontWeight.w500),
                    ) : Text("") ,
                  ),
                ],
              ),
            ),

            Container(
              height: 450,
              child: completedTodos.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        final todo = completedTodos[index];
                        print("ALLTOTO ${completedTodos[index].description}");
                        print("ISFAVCHECKD ${completedTodos[index].isFavorite}");



                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TaskDetails(
                                  description: "${todo.description}",
                                  index: index,
                                  currentTime: countText,
                                ),
                              ));
                            },
                            child: AnimatedBuilder(
                                animation: animationController,
                                builder: (context, child) => timewidget(
                                    context, todo.description, countText,completedTodos[index].isFavorite)));
                      },
                      itemCount: completedTodos.length,
                    )
                  : _emptyOdooPage("You don’t have any completed timesheets",
                      "Create new timesheets"),
            ),
          ],
        );
      })
    ]);
  }

  void addTodo(Todo todo) {
    context.read<TodoBloc>().add(AddTodo(todo));
  }
}
