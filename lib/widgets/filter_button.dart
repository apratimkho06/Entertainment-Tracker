import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String filterName;
  final Function onPressed;
  final Color colour;
  final Color textColour;

  FilterButton({this.filterName, this.colour, this.textColour, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: colour,
      textColor: textColour,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(filterName),
    );
  }
}
