
import 'package:fire_task/pages/root_page.dart';
import 'package:fire_task/services/authentication.dart';
import 'package:flutter/material.dart';

void main() => runApp(Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(backgroundColor: Color(0xfffff5eb)),
      home: RootPage(auth: Auth(),),
    
    );
  }
}
