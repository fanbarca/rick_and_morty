import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(0.5),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: ListWheelScrollView.useDelegate(
        diameterRatio: 1.5,
        clipBehavior: Clip.none,
        renderChildrenOutsideViewport: true,
        perspective: 0.001,
        itemExtent: 100,
        childDelegate: ListWheelChildBuilderDelegate(builder: (context, index) {
          return Card(
              child: ListTile(
            title: Text('Text $index'),
          ));
        }),
      ),

//          SafeArea(
//            child: SingleChildScrollView(
//              scrollDirection: Axis.vertical,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  SearchField(),
//                  SingleChildScrollView(
//                    scrollDirection: Axis.horizontal,
//                    child: Padding(
//                      padding: EdgeInsets.symmetric(horizontal: 15.0),
//                      child: Row(
//                        children: <Widget>[
//                          CategoryButton(
//                            title: 'Category',
//                            icon: Icons.theaters,
//                          )
//                        ],
//                      ),
//                    ),
//                  ),
//
//                ],
//              ),
//            ),
//          ),
    );
  }
}
