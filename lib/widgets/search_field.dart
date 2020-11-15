import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3), color: Colors.black12, blurRadius: 7.0)
          ],
          borderRadius: BorderRadius.circular(30.0)),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          icon: Icon(Icons.search),
          hintText: 'Search settings',
        ),
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
