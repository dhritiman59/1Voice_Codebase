import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Constants/text_string.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkThroughPage extends StatefulWidget {
  const WalkThroughPage({Key key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<WalkThroughPage> {
  bool inticator1 = false, inticator2 = true, inticator3 = true;
  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: SafeArea(
                  child: PageView(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (int num) {
                      setState(() {
                        if (num == 0) {
                          inticator1 = false;
                          inticator2 = true;
                          inticator3 = true;
                        } else if (num == 1) {
                          inticator1 = true;
                          inticator2 = false;
                          inticator3 = true;
                        }
                        if (num == 2) {
                          inticator1 = true;
                          inticator2 = true;
                          inticator3 = false;
                          /*Timer(Duration(seconds: 1), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ClinxLoginPage()));

                              });*/
                        }
                      });
                    },
                    children: <Widget>[
                      SafeArea(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/howitwork2.png",
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                'How it works',
                                textAlign: TextAlign.center,
                                style: Styles.textHeadAddCommentBlue,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/images/walkthroughdivider.png",
                                  height: 5,
                                  width: 35,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const Text(
                              'Register Account',
                              textAlign: TextAlign.center,
                              style: Styles.textWalkthroughNameBlue25,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                              child: Text(
                                TextString.walkThroughTitle1,
                                style: Styles.textNormalLightDarkGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SafeArea(
                          child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/howitwork1.png",
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.50,
                            fit: BoxFit.fill,
                          ),
                          const Text(
                            'How it works',
                            textAlign: TextAlign.center,
                            style: Styles.textHeadAddCommentBlue,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/walkthroughdivider.png",
                                height: 5,
                                width: 35,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Text(
                            'Log a Case',
                            textAlign: TextAlign.center,
                            style: Styles.textWalkthroughNameBlue25,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: Text(
                              TextString.walkThroughTitle2,
                              style: Styles.textNormalLightDarkGray,
                            ),
                          ),
                        ],
                      )),
                      SafeArea(
                        child: Column(
                          children: [
                            SizedBox(
                              width: width,
                              height: height * 0.45,
                              child: Image.asset(
                                'assets/images/getStarted.png',
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.only(
                                          left: 30,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: CustColors.LightRose,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                            top: 15,
                                          ),
                                          child: Text(
                                            "Get Started",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: CustColors.DarkBlue,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: const BoxDecoration(
                                              color: CustColors.DarkBlue,
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(5.0),
                                                topRight: Radius.circular(5.0),
                                              )),
                                          child: Center(
                                              child: Image.asset(
                                            'assets/images/arrow.png',
                                            width: 20,
                                            height: 20,
                                          )),
                                        ),
                                        onTap: () {
                                          setIswalked();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInActivity(
                                                frompage: "0",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 80, right: 80, bottom: 30),
                              child: Center(
                                child: Text(
                                  TextString.walkThroughTitle3,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: CustColors.Grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                alignment: Alignment.center,
                child: SafeArea(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(
                        flex: inticator3 ? 30 : 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            color: inticator1 ? Colors.grey : Colors.blueGrey,
                            shape: BoxShape.circle),
                        alignment: Alignment.center,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            color: inticator2 ? Colors.grey : Colors.blueGrey,
                            shape: BoxShape.circle),
                        alignment: Alignment.center,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: inticator3 ? Colors.grey : Colors.blueGrey,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                      ),
                      const Spacer(
                        flex: 20,
                      ),
                      kIsWeb
                          ? inticator3
                              ? MaterialButton(
                                  onPressed: () {
                                    if (_controller.page == 0) {
                                      _controller.animateToPage(
                                        1,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                      setState(() {
                                        inticator1 = true;
                                        inticator2 = false;
                                        inticator3 = true;
                                      });
                                    } else if (_controller.page == 1) {
                                      _controller.animateToPage(
                                        2,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                      setState(() {
                                        inticator1 = true;
                                        inticator2 = true;
                                        inticator3 = false;
                                      });
                                    }
                                  },
                                  child: const Text("Next"),
                                  color: Colors.purple,
                                  textColor: Colors.white,
                                )
                              : const SizedBox.shrink()
                          : null,
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setIswalked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefKey.isWalked, true);
  }
}
