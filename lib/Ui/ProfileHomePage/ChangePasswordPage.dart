import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bring2book/Ui/ProfileHomePage/ProfileDetailsBloc.dart';

class ChangePasswordPage extends StatefulWidget {

  ChangePasswordPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {


  bool visible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ProfileDetailsBloc _profileDetailsBloc = ProfileDetailsBloc();

  String email_id;


  TextEditingController oldPassword = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController confrmNewPassword = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileDetailsBloc.getUserDetails();

    listen();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(0),
            child:
            Stack(
              children: [
                ListView(
                    children: <Widget>[
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/forgotbgnew.png",
                            width: double.infinity,
                            height:  MediaQuery.of(context).size.height * 0.19,
                            gaplessPlayback: true,
                            fit: BoxFit.fill,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0, top: 30),
                              child: Image.asset(
                                "assets/images/back_arrow.png",
                                width: 20,
                                height: 20,
                                gaplessPlayback: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        ],
                      ),

                      Container(
                        height:MediaQuery.of(context).size.height * 0.60 ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:EdgeInsets.fromLTRB(30,30,30,0),
                              child:Text(
                                "Change Password",
                                style: Styles.textHeadNormalBlue,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                              child: Text(
                                "Lorem Ipsum is simply dummy text.",
                                style: Styles.textNormalLightDarkGray,
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: TextFieldWidgetForgot(
                                textInputType: TextInputType.visiblePassword,
                                controller: oldPassword,
                                obscureText: true,
                                height: 50,
                                width: double.infinity,
                                backgroundColor: CustColors.LightRose,
                                alignment: TextAlign.start,
                                hintText: "Old Password",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextFieldWidgetForgot(
                                textInputType: TextInputType.visiblePassword,
                                controller: newPassword,
                                obscureText: true,
                                height: 50,
                                width: double.infinity,
                                backgroundColor: CustColors.LightRose,
                                alignment: TextAlign.start,
                                hintText: "New Password",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextFieldWidgetForgot(
                                textInputType: TextInputType.visiblePassword,
                                controller: confrmNewPassword,
                                height: 50,
                                obscureText: true,
                                width: double.infinity,
                                backgroundColor: CustColors.LightRose,
                                alignment: TextAlign.start,
                                hintText: "Confirm Password",
                              ),
                            ),

                          ],
                        ),
                      ),



                      Padding(
                        padding:EdgeInsets.fromLTRB(10,0,10,0),
                        child:Container(
                          height:MediaQuery.of(context).size.height * 0.15,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SubmitFlatButtonWidget(
                              height: 50,
                              width: double.infinity,
                              backgroundColor: CustColors.DarkBlue,
                              buttonText: "Reset Password",
                              buttonTextColor: Colors.white,
                              onpressed: () {

                                print(oldPassword.text);
                                print(newPassword.text);
                                print(confrmNewPassword.text);

                                  if(oldPassword.text.isEmpty || oldPassword.text == '')
                                  {
                                  toastMsg("Enter Old Password");
                                  }
                                  else if(newPassword.text.isEmpty || newPassword.text == '')
                                  {
                                  toastMsg("Enter New Password");
                                  }
                                  else if(confrmNewPassword.text.isEmpty || confrmNewPassword.text == '')
                                  {
                                  toastMsg("Enter Confirm Password");
                                  }
                                  else if(!validateStructure(newPassword.text))
                                    {
                                      toastMsg("Passwords must contain at least six characters and 1 special Character, including uppercase, lowercase letters and numbers.");
                                    }
                                  else if(newPassword.text.compareTo(confrmNewPassword.text) != 0)
                                  {
                                    toastMsg("New Password And Confirm Password Should be same");
                                  }
                                  else
                                  {
                                    setState(() {
                                      visible=true;
                                    });
                                    _profileDetailsBloc.performChangePassword(email_id,oldPassword.text, newPassword.text);
                                  }




                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,70,0,0),
                  child: Visibility(
                      visible: visible,
                      child: Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 50, bottom: 30),
                            child: CircularProgressIndicator(
                              valueColor:new AlwaysStoppedAnimation<Color>(CustColors.DarkBlue),
                            )
                        ),
                      )
                  ),
                ),
              ],

            )
        )
    );

  }

  void listen() {
    _profileDetailsBloc.getUserDetailsStream.listen((data) {
      if ((data.status == "success")) {
        print("${data.status}");
        setState(() {
          email_id = data.data.emailId.toString();
          visible = false;
        });

      }
      else if ((data.status == "error")) {
        setState(() {
          visible = false;
        });
      }


    });

    _profileDetailsBloc.changePasswordStream.listen((data) {
      if ((data.status == "success")) {
        print("${data.status}");
        toastMsg('Updated Sucessfully');
        oldPassword.text='';
        newPassword.text='';
        confrmNewPassword.text='';
        setState(() {

          visible = false;
        });

      }
      else if ((data.status == "error")) {
        setState(() {
          visible = false;
        });
        toastMsg(data.message);
      }

    });

  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));
  }


  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

}