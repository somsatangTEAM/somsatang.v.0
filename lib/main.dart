import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test2/pages/home_page/upload_page.dart';
import 'package:test2/pages/login_page/auth_page.dart';
import 'package:test2/pages/login_page/check_your_email.dart';
import 'package:test2/pages/my_home.dart';
import 'package:test2/pages/start_page.dart';
import 'package:test2/provider/page_notifier.dart';





void main() {
  runApp(App());
}

class App extends StatelessWidget { //firebase를 받아오는지 확인 이용하려면 필수
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {

        if(snapshot.hasError){
          return Container(child: Center(child: Text("Something went wrong, please try again later!"),),);
        }
        if(snapshot.connectionState==ConnectionState.done){
          return MyApp();
        }

        return CircularProgressIndicator();
      }
    );
  }
}



class MyApp extends StatelessWidget {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=>PageNotifier())], //pagenotifier의 기본값 currentpage=MyHomePage.pagename
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.lightBlue,fontFamily: 'NanumAJumMaJaYu',),
        title: 'Flutter Demo',
        home:  Consumer<PageNotifier>(
          builder: (context,pageNotifier,child){
            return Navigator(
              pages: [MaterialPage( //page들을 쌓을 수 있는데 가장 아래 페이지가 눈에 보여지게 됨
                  key: ValueKey(MyHomePage.pageName), //valuekey를 넣어줘야 함
                  child: MyHomePage()),//pages는 Page를 줘야해서 materialpage로 묶어줌
                if(pageNotifier.currentPage==UploadPage.pageName)UploadPage(),
                if(pageNotifier.currentPage==StartPage.pageName)StartPage(),
                if(pageNotifier.currentPage==CheckYourEmail.pageName) CheckYourEmail(),
              ],
              onPopPage: (route, result){ //route는 현재 페이지에서 전 페이지로 가는 과정, result는 이 페이지에서 결과값을 받아 전페이지로 줄때
                if(!route.didPop(result)){ //전 페이지로 가는게 다 끝났는지 안끝났는지 물어보는 것
                  return false;
                }
                return true;
              },);
          },
        ),
      ),
    );
  }
}

