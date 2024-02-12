import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_timer_app/ui/widgets/snackBar.dart';
import 'package:simple_timer_app/utils/drawables/svg.dart';

import '../../data/todo.dart';
import '../../state/todo_bloc.dart';
import '../../state/todp_event.dart';
import '../../utils/colors/Color.dart';
import '../widgets/check_box.dart';

class CreateTimer extends StatefulWidget {
  final String description;

  @override
  _CreateTimerState createState() => _CreateTimerState();

  const CreateTimer({
    required this.description,
  });
}

class _CreateTimerState extends State<CreateTimer> {
  List<String> projectitems = ["Project", "Task"];
  List<String> task = [
    "Have a Meeting with Ceo",
    "Daily Scrum",
    "Code Review with Dev"
  ];

  String? selecteditem;

  String? selectedtask;
  late bool shouldshowfav;
  late bool makeFav;

  TextEditingController descriptiontext = TextEditingController();

  late bool isfav;

  @override
  void initState() {
    descriptiontext.text = widget.description;

    setState(() {
      isfav = false;
      shouldshowfav = false;
      makeFav = false;
    });
    super.initState();
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
                              "Create Timer",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: littimebg),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: drkblu,
                            // Set dropdown view color to transparent

                            hint: Text(
                              "Project",
                              style: TextStyle(color: Colors.white),
                            ),
                            value: selecteditem,
                            icon: SvgPicture.asset(downarrow),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            onChanged: (dvalue) {
                              setState(() {
                                selecteditem = dvalue;
                              });
                            },
                            items: projectitems.map((menuItem) {
                              return DropdownMenuItem<String>(
                                value: menuItem,
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      // Set background color to transparent
                                      child: Text(
                                        menuItem,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: littimebg),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: drkblu,
                            // Set dropdown view color to transparent

                            hint: Text(
                              "Project",
                              style: TextStyle(color: Colors.white),
                            ),
                            value: selectedtask,
                            icon: SvgPicture.asset(downarrow),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            onChanged: (dvalue) {
                              setState(() {
                                selectedtask = dvalue;
                              });
                            },
                            items: task.map((menuItem) {
                              return DropdownMenuItem<String>(
                                value: menuItem,
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      // Set background color to transparent
                                      child: Text(
                                        menuItem,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 2,
                            color: littimebg), // Same border as dropdown
                      ),
                      child: TextFormField(
                        controller: descriptiontext,
                        style: TextStyle(color: Colors.white),
                        // Set text color to white
                        decoration: InputDecoration(
                          hintText: "Description",
                          // Set hint text
                          hintStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                          // Set hint text color to white
                          border: InputBorder.none, // Remove border
                        ),
                      ),
                    ))
                  ])),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      shouldshowfav == false
                          ? shouldshowfav = true
                          : shouldshowfav = false;
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(downarrow),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Make Favorite",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: shouldshowfav,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          print('Chip clicked');
                          // Add any actions you want to perform when the chip is clicked
                        },
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  makeFav = !makeFav;
                                });
                              },
                              child: AnimatedPadding(
                                padding: EdgeInsets.only(left: 20),
                                duration: Duration(milliseconds: 400),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24.0,
                                      height: 24.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                            width: 1.0, color: Colors.white),
                                        color: makeFav
                                            ? litblu
                                            : Colors.transparent,
                                      ),
                                      child: makeFav
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 20.0,
                                            )
                                          : null,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Mark as favorite",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                        onTap: () {

                          if (descriptiontext.text.isNotEmpty) {
                            Navigator.pop(context);
                            final todoBloc = BlocProvider.of<TodoBloc>(context);
                            todoBloc.add(AddTodo(Todo(
                                description: "${descriptiontext.text}",
                                isCompleted: false,
                                isFavorite: makeFav)));
                          } else {
                            showMyCustomSnackBar(context,"Your Task Description must not be empty");
                          }
                        },
                        child: Container(child: SvgPicture.asset(createbtn))),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
