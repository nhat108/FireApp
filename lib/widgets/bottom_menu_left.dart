import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuLeft extends StatefulWidget {
  final FirebaseUser user;
  final Function logOut;
  MenuLeft({this.user,this.logOut});

  @override
  State<StatefulWidget> createState() => MenuLeftState();
}

class MenuLeftState extends State<MenuLeft> {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getUserWidget(
              photoUrl: widget.user.photoUrl,
              name: widget.user.displayName,
              email: widget.user.email),
          InkWell(
            onTap: () {},
            child: Container(
              height: 60,
              margin: EdgeInsets.only(left: 10),
              alignment: AlignmentDirectional.centerStart,
              width: 1000,
              child: Text(
                'Feedback',
              ),
            ),
          ),
          SizedBox(
            height: 0.5,
            child: Container(color: Colors.grey),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 60,
              margin: EdgeInsets.only(left: 10),
              alignment: AlignmentDirectional.centerStart,
              width: 1000,
              child: Text(
                'Raiting',
              ),
            ),
          ),
           SizedBox(
            height: 0.5,
            child: Container(color: Colors.grey),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 60,
              margin: EdgeInsets.only(left: 10),
              alignment: AlignmentDirectional.centerStart,
              width: 1000,
              child: Text(
                'Support me',
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget getUserWidget(
    {
    @required String photoUrl,
    @required String name,
    @required String email}) {
  return Container(
    margin: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(photoUrl),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 14),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ExpansionTile(
                title: Text(
                  email,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700]
                  ),
                ),
                children: <Widget>[
                  OutlineButton(
                    onPressed: () {
                        widget.logOut();
                    },
                    child: Text('Log out'),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

}

