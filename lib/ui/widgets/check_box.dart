
import 'package:flutter/material.dart';
import 'package:simple_timer_app/utils/colors/Color.dart';


class MyCheckbox extends StatefulWidget {
  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 1.0, color: Colors.black),
          color: isChecked ? Colors.blue : Colors.transparent,
        ),
        child: isChecked
            ? Icon(
          Icons.check,
          color: Colors.white,
          size: 20.0,
        )
            : null,
      ),
    );
  }
}


class ChipGroupOne extends StatefulWidget {
  @override
  _ChipGroupOneState createState() => _ChipGroupOneState();
}

class _ChipGroupOneState extends State<ChipGroupOne> {
  List<String> chipTitles = ['Document', 'Glass', 'Liquid', 'Food'];
  List<bool> isSelected = List.generate(4, (index) => false);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(chipTitles.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FilterChip(
              label: Text(
                chipTitles[index],
                style: TextStyle(color: isSelected[index] ? deepblu : Colors.black, fontWeight: FontWeight.w300),
              ),
              selected: isSelected[index],
              onSelected: (bool selected) {
                setState(() {
                  isSelected[index] = selected;
                });
              },
              backgroundColor: isSelected[index] ? deepblu : Colors.white,
              selectedColor: deepblu,
              checkmarkColor: Colors.white,
              showCheckmark: isSelected[index],
            ),
          );
        }),
      ),
    );
  }
}



class ChipGroupTwo extends StatefulWidget {

  @override
  _ChipGroupTwoState createState() => _ChipGroupTwoState();
}

class _ChipGroupTwoState extends State<ChipGroupTwo> {
  List<String> chipTitles = ['Make this Favorite'];
  List<bool> isSelected = List.generate(1, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(chipTitles.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FilterChip(
              label: Text(
                chipTitles[index],
                style: TextStyle(color: isSelected[index] ? Colors.white : Colors.black, fontWeight: FontWeight.w300),
              ),
              selected: isSelected[index],
              onSelected: (bool selected) {
                setState(() {
                  isSelected[index] = selected;
                });
              },
              backgroundColor: isSelected[index] ? deepblu : Colors.white,
              selectedColor: deepblu,
              checkmarkColor: Colors.white,
              showCheckmark: isSelected[index],
            ),
          );
        }),
      ),
    );
  }
}
