import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String msg;
  final String name;
  Header({this.msg, this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
       
        children: <Widget>[
          Text(
            msg+',',
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(fontFamily: 'Lobster Two', fontSize: 30),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Text('hi '+name,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontFamily: 'Lobster Two', fontSize: 18)),
          )
        ],
      ),
    );
  }
}
