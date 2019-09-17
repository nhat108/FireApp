
import 'package:fire_task/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttie/fluttie.dart';


class LogInPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  LogInPage({this.auth, this.onSignedIn});
  @override
  State<StatefulWidget> createState() {
    return _LogInState();
  }
}

class _LogInState extends State<LogInPage> {
  bool _isLoading;
  String userId = '';
  FluttieAnimationController emojiAnimation;
  @override
  void initState() {
    super.initState();
    _isLoading = false;
    prepareAnimation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _showCircularProgress(),
          Builder(
            builder: (context) => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsets.only(top: 50),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'FIRE TASK',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      )),
                  Container(
                    height: 300,
                    width: 300,
                    child: FluttieAnimation(emojiAnimation),
                  ),
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(top: 20),
                    child: FlatButton(
                        color: Colors.grey[200],
                        onPressed: () async {
                          signInWithGoogle();
                          },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(5),
                              width: 30,
                              height: 30,
                              child:
                                  SvgPicture.asset('assets/assets/search.svg'),
                            ),
                            Text('Sign in with Google')
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    userId = await widget.auth.signInWithGoogle();
    setState(() {
      _isLoading = false;
    });
    if (userId.length > 0 && userId != null) {
      widget.onSignedIn();
    }
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0,
      width: 0,
    );
  }

  prepareAnimation() async {
    var instance = Fluttie();
    var emojiComposition = await instance.loadAnimationFromAsset(
      "assets/assets/3151_books.json", //Replace this string with your actual file
    );
   emojiAnimation=await instance.prepareAnimation(emojiComposition,
        repeatCount: const RepeatCount.infinite(),
        repeatMode: RepeatMode.START_OVER);
    setState(() {
    emojiAnimation.start();
      
    });
  }
}
