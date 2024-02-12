import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_timer_app/ui/home/home_dashboard.dart';
import 'package:simple_timer_app/utils/drawables/svg.dart';

import '../../data/todo.dart';
import '../../state/todo_bloc.dart';
import '../../state/todp_event.dart';
import '../../utils/colors/Color.dart';

class EditTimer extends StatefulWidget {
  final String description;
  final int index;

  @override
  _EditTimerState createState() => _EditTimerState();

  const EditTimer({
    required this.description,
    required this.index,
  });
}

class _EditTimerState extends State<EditTimer> {
  List<String> projectitems = ["Project", "Task"];
  String? selecteditem;
  TextEditingController descriptiontext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    descriptiontext.text = widget.description;
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
                              "Edit Timer",
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
                child: Row(
                  children: [
                    SvgPicture.asset(downarrow),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Make Favorite",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
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
                          setState(() {
                            if (descriptiontext.text.isNotEmpty) {
                              final todoBloc =
                                  BlocProvider.of<TodoBloc>(context);
                              todoBloc.add(EditTodo(
                                  widget.index,
                                  Todo(
                                      description: descriptiontext.text,
                                      isCompleted: false, isFavorite: false)));

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomeDashboard()));
                            } else {
                              print("MUST NOT BE EMPTY");
                            }
                          });
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
