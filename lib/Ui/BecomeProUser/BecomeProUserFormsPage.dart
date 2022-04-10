import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';

import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/BecomeProUser/BecomeProUserBloc.dart';
import 'package:bring2book/Ui/LandingPage/MainLandingPage.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:bring2book/Ui/base/CustomDropDown.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BecomeProUserFormsPage extends StatefulWidget {
  int id;
  String radioButtonItem;

  BecomeProUserFormsPage({this.id, this.radioButtonItem});

  @override
  _BecomeProUserFormsPageState createState() => _BecomeProUserFormsPageState();
}

class _BecomeProUserFormsPageState extends State<BecomeProUserFormsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final BecomeProUserBloc _becomeProUserBloc = BecomeProUserBloc();
  final CheckInternet _checkInternet = CheckInternet();

  TextEditingController registerNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController specialization = TextEditingController();
  TextEditingController aboutme = TextEditingController();
  TextEditingController experience = TextEditingController();

  bool visible = false;

  FilePickerResult path;
  String uploadFilepath;
  final List<String> _uploadFilePathList = [];

  String userHead = "Lawyer";
  String currentValue;
  String dropdownValue = 'General Law';
  String dropdownExperienceValue = 'Below 1 Year';

  @override
  void initState() {
    super.initState();

    userHead = widget.radioButtonItem;
    print(userHead);

    listenApi();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: Padding(
              padding: const EdgeInsets.all(0),
              child: Stack(
                children: [
                  ListView(children: <Widget>[
                    Stack(
                      children: [
                        Image.asset(
                          "assets/images/forgotbgnew.png",
                          width: double.infinity,
                          height: 140,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text(
                        widget.radioButtonItem,
                        style: Styles.textHeadNormalBlue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFieldWidgetSignUpMandatory(
                        controller: registerNumber,
                        textInputType: TextInputType.text,
                        height: 50,
                        width: double.infinity,
                        backgroundColor: CustColors.LightRose,
                        alignment: TextAlign.start,
                        hintText: "Register Number",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFieldWidgetSignUpMandatory(
                        controller: city,
                        textInputType: TextInputType.emailAddress,
                        height: 50,
                        width: double.infinity,
                        backgroundColor: CustColors.LightRose,
                        alignment: TextAlign.start,
                        hintText: "City",
                      ),
                    ),
                    userHead == "Lawyer"
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20,
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    color: Colors.red,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: CustColors.LightRose,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: CustomDropdown<String>(
                                        value: dropdownValue,
                                        hint: const Text(
                                          "General Law",
                                          textAlign: TextAlign.start,
                                          style: Styles.homeFilterText,
                                        ),
                                        items: <String>[
                                          'General Law',
                                          'Environment Law',
                                          'Criminal Law',
                                          'Corporate Law',
                                          'Family Law',
                                          'Employment'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Row(
                                              children: <Widget>[
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  value,
                                                  textAlign: TextAlign.end,
                                                  style: Styles.homeFilterText,
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            specialization.text = newValue;
                                            dropdownValue = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFieldWidgetSignUpMandatory(
                              controller: specialization,
                              textInputType: TextInputType.text,
                              height: 50,
                              width: double.infinity,
                              backgroundColor: CustColors.LightRose,
                              alignment: TextAlign.start,
                              hintText: "Specialization",
                            ),
                          ),
                    userHead == "Lawyer"
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20,
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    color: Colors.red,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: CustColors.LightRose,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: CustomDropdown<String>(
                                        value: dropdownExperienceValue,
                                        hint: const Text(
                                          "Below 1 Year",
                                          textAlign: TextAlign.start,
                                          style: Styles.homeFilterText,
                                        ),
                                        items: <String>[
                                          'Below 1 Year',
                                          '1-5 Years',
                                          '16-15 Years',
                                          '15+ Years'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: <Widget>[
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    value,
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        Styles.homeFilterText,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String newValue1) {
                                          setState(() {
                                            experience.text = newValue1;
                                            dropdownExperienceValue = newValue1;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    color: Colors.red,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: TextFieldWidget(
                                    controller: experience,
                                    autofocus: false,
                                    inputFormatterRules: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    textInputType: TextInputType.phone,
                                    height: 50,
                                    width: double.infinity,
                                    backgroundColor: CustColors.LightRose,
                                    alignment: TextAlign.start,
                                    hintText: "Experience",
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.all(0.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 150.0,
                          ),
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: SizedBox(
                                height: 100.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Container(
                                        color: Colors.red,
                                        width: 50,
                                        height: 100,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: TextField(
                                        controller: aboutme,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(300),
                                        ],
                                        maxLines: 300,
                                        decoration: InputDecoration(
                                          hintText: "About me",
                                          hintStyle:
                                              const TextStyle(fontSize: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(16),
                                          fillColor: CustColors.LightRose,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    /*Padding(
                      padding:
                      const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(0.0),
                        child: new ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 150.0,
                          ),
                          child: new Scrollbar(
                            child: new SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: SizedBox(
                                height: 100.0,
                                child: new TextField(
                                  controller: aboutme,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(250),
                                  ],
                                  maxLines: 250,
                                  decoration: new InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: CustColors.TextGray,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: CustColors.TextGray,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    hintText: 'About Me',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),*/

                    Padding(
                      padding:
                          const EdgeInsets.only(left: 24, right: 20, top: 5),
                      child: Container(
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                '  Verification File:',
                                style: Styles.textVerificationFileBlue25,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: Image.asset(
                                    _uploadFilePathList.isEmpty ||
                                            _uploadFilePathList.first == null
                                        ? ''
                                        : 'assets/images/tick_icon1.png',
                                    width: 130,
                                    height: 40),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: Image.asset(
                                  "assets/images/docUploadIcon.png",
                                  width: 60,
                                  height: 60,
                                ),
                                onTap: () {
                                  _openFileExplorer();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: SubmitFlatButtonWidget(
                        height: 50,
                        width: double.infinity,
                        backgroundColor: CustColors.DarkBlue,
                        buttonText: "Submit",
                        buttonTextColor: Colors.white,
                        onpressed: () {
                          if (userHead == "Lawyer") {
                            experience.text = dropdownExperienceValue;
                            specialization.text = dropdownValue;
                            print(experience.text);
                            print(specialization.text);
                          } else {
                            print('experience${experience.text}');
                            print(specialization.text);
                          }

                          print(city.text);
                          print('aboutme${aboutme.text}');
                          print(_uploadFilePathList);
                          setState(() {
                            visible = true;
                          });
                          _checkInternet.check().then((intenet) {
                            if (intenet != null && intenet) {
                              _becomeProUserBloc.initiateProUserValues(
                                  specialization.text,
                                  registerNumber.text,
                                  city.text,
                                  experience.text,
                                  aboutme.text,
                                  widget.radioButtonItem,
                                  _uploadFilePathList);
                            } else {
                              toastMsg('No internet connection');
                            }
                          });
                        },
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                    child: Visibility(
                        visible: visible,
                        child: Center(
                          child: Container(
                              margin:
                                  const EdgeInsets.only(top: 50, bottom: 30),
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CustColors.DarkBlue),
                              )),
                        )),
                  ),
                ],
              )))
    ]);
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ));
  }

  Widget ProgressBarDarkBlue() {
    return const SizedBox(
      height: 60.0,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(CustColors.DarkBlue),
      )),
    );
  }

  void _openFileExplorer() async {
    try {
      path = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
      );

      if (path != null) {
        setState(() {
          _uploadFilePathList.insert(0, path.files[0].path);
        });
      }
    } on PlatformException {}
    if (!mounted) return;
  }

  void listenApi() {
    _becomeProUserBloc.validateProUseStream.listen((data) {
      setState(() {
        visible = false;
      });
      toastMsg(data);
    });

    _becomeProUserBloc.becomeProUserResponse.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visible = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainLandingPage(frompage: "0")),
            ModalRoute.withName("/MainLandingPage"));
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
        });
        String msg = data.message;
        toastMsg(msg);
      }
    });
  }
}
