import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuRight extends StatefulWidget {
  final Function deleteAllDones;
  final Function deleteAll;
  MenuRight({this.deleteAllDones,this.deleteAll});
  @override
  State<StatefulWidget> createState() => MenuRightState();
}

class MenuRightState extends State<MenuRight> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.only(top: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            child: Text(
              'Sort by',
              style: TextStyle(
                  color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 25),
                      child: Row(
                        
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Oldest'),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(Icons.done))
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      // print('object');
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Newest'),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(Icons.done))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.5,
            child: Container(
              color: Colors.grey,
            ),
          ),
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                widget.deleteAll();
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                width: 1000,
                height: 50,
                // padding: EdgeInsets.only(left: 15),
                child: Text('Delete all tasks'),
              ),
            ),
          ),
          SizedBox(
            height: 0.5,
            child: Container(
              color: Colors.grey,
            ),
          ),
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: ()  {
               widget.deleteAllDones();
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                width: 1000,
                height: 50,
                child: Text('Delete all done tasks'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
