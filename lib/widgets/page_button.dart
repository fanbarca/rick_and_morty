import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final bool isActive;

  const PageButton({
    Key key,
    this.label,
    this.onTap,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 35,
          backgroundColor:
              isActive ? Theme.of(context).primaryColor : Colors.grey.shade300,
          child: Text(
            label,
            style: TextStyle(
              color: !isActive
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).canvasColor,
              fontSize: 25,
              // color: isActive,
            ),
          ),
        ),
      ),
    );
  }
}
