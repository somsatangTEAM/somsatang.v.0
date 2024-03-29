import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test2/provider/page_notifier.dart';

class CheckYourEmail extends Page {
  static final pageName = "CheckYourEmail";

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return CheckYourEmailWidget();
      },
    );
  }
}

class CheckYourEmailWidget extends StatefulWidget {
  CheckYourEmailWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<CheckYourEmailWidget> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _emailverified=false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.lightBlueAccent,
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    '솜사탕',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text('이메일 인증',style: TextStyle(fontSize: 35),),
                  SizedBox(
                    height: 40,
                  ),
                  _sendVerification(),
                  SizedBox(
                    height: 40,
                  ),
                  _signout(),
                  SizedBox(
                    height: 40,
                  ),
                  _emailverified?_emailVerified(context):Container(height: 50,),
                   Center(
                     child: SizedBox(width: 300,height: 300,
                     child: ExtendedImage.asset(
                                'assets/솜사탕_2.png'),
                     ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sendVerification() {
    return FlatButton(
      onPressed: () async {
        FirebaseAuth.instance.currentUser!.sendEmailVerification(); //확인이메일보내기
        SnackBar snackbar = SnackBar(content: Text('보내준 이메일 링크를 확인해주세요'));
        _scaffoldKey.currentState!.showSnackBar(snackbar); //snackbar  보여주기
        _emailverified=true;
        setState(() {

        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(16),
      color: Colors.white54,
      textColor: Colors.black87,
      child: Text(
        "이메일 인증을 해주세요",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _emailVerified(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        Provider.of<PageNotifier>(context, listen: false).refresh();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(16),
      color: Colors.white54,
      textColor: Colors.black87,
      child: Text(
        "이메일 인증 버튼입니다",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _signout() {
    return FlatButton(
      onPressed: () async {
        FirebaseAuth.instance.signOut();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(16),
      color: Colors.white54,
      textColor: Colors.black87,
      child: Text(
        "다른 게정으로 로그인할게요",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
