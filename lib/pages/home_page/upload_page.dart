import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test2/constants/common_size.dart';
import 'package:test2/provider/page_notifier.dart';

class UploadPage extends Page {
  static const pageName = 'UploadPage';//value key 지정해줌

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) => const UploadPageWidget()); //authwidget으로 가는 route생성
  }
}

class UploadPageWidget extends StatefulWidget {

  const UploadPageWidget({Key? key}) : super(key: key);

  @override
  _UploadPageWidgetState createState() => _UploadPageWidgetState();
}

class _UploadPageWidgetState extends State<UploadPageWidget> {
 bool _secretSelected=false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

@override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }
  var _divider = Divider(
    height: 1,
    thickness: 1,
    color: Colors.grey[400],
    indent: common_padding,
    endIndent: common_padding,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size _size = MediaQuery
            .of(context)
            .size;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyanAccent,
            elevation: 2,
            bottom: PreferredSize(preferredSize: Size(_size.width, 2),
              child: Container(),),
            leading: TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.black54, //클릭했을때 색깔 나오도록
                  backgroundColor: Theme
                      .of(context)
                      .appBarTheme
                      .backgroundColor),
              child: Text(
                '뒤로',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2,
              ),
              onPressed: () {
                Provider.of<PageNotifier>(context, listen: false)
                    .goToMain(); //뒤로가기 버튼 만들기
              },
            ),
            title: Text(
              '솜털처럼 포근하게 고민을 들어줄게요',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.black54, //클릭했을때 색깔 나오도록
                    backgroundColor: Theme
                        .of(context)
                        .appBarTheme
                        .backgroundColor),
                child: Text(
                  '완료',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: ListView(
            children: [
              ExtendedImage.asset(
                  'assets/솜사탕_3.png',width: 100,height: 100,),
              _divider,
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: common_padding),
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      hintText: '글 제목',
                      border: UnderlineInputBorder(
                          borderSide: BorderSide.none)),
                ),
              ),
              _divider,
              ListTile(
                onTap: () {
                  //context.beamToNamed(
                  //        '/$LOCATION_INPUT/$LOCATION_CATEGORY_INPUT'); //beamer이용 category로 이동
                },
                dense: true,
                title: Text('CATEGORY'),
                trailing: Icon(Icons.navigate_next),
              ),
              //dense는 listtile이 압축되있는지 말해줌, listtile로 쉽게 디자인 만들수 있음
              _divider,
              Padding(
                padding: const EdgeInsets.only(
                    right: common_small_padding),
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _secretSelected = !_secretSelected;
                    });
                  },
                  icon: Icon(
                    _secretSelected ? Icons.check_circle : Icons
                        .check_circle_outline,
                    color: _secretSelected ? Theme
                        .of(context)
                        .primaryColor : Colors.black54,
                  ),
                  label: Text(
                    '비밀글쓰기(300사탕 이상인 사람만 댓글을 달 수 있어요!)',
                    style: TextStyle(color: _secretSelected ? Theme
                        .of(context)
                        .primaryColor : Colors.black54),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      primary: Colors.black), //primary는 클릭할때 색깔이 나오게 하는 것
                ),
              ),
          _divider,
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: common_padding),
            child: TextFormField(
              controller: _detailController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              //enter가 입력완료가 아니라 한줄 띄기로 입력됨
              decoration: InputDecoration(
                  hintText: '올릴 게시글 내용을 작성해주세요.',
                  border: UnderlineInputBorder(
                      borderSide: BorderSide.none)),
            ),
          ),
          ],
        ),);
      },
    );
  }
}
