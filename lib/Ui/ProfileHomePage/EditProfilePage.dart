import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Models/CountryListModel/CountryListModel.dart';
import 'package:bring2book/Models/StateListModel/StateListModel.dart';
import 'package:bring2book/Ui/AddCase/AddCaseBloc.dart';
import 'package:bring2book/Ui/LandingPage/MainLandingPage.dart';
import 'package:bring2book/Ui/ProfileHomePage/ProfileDetailsBloc.dart';
import 'package:bring2book/Ui/base/CustomRadioWidget.dart';
import 'package:bring2book/Ui/base/DateFormatter.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../Constants/colorConstants.dart';
import '../base/baseWidgets.dart';
import 'package:country_list_pick/country_list_pick.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileDetailsBloc _profileDetailsBloc = ProfileDetailsBloc();
  final AddCaseBloc _addCaseBloc = AddCaseBloc();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool visible = true;

  File _img;
  final List<String> _uploadFilePathList = [];

  bool enableEmail = true;

  TextEditingController profileName = TextEditingController();
  TextEditingController profileEmailId = TextEditingController();
  TextEditingController profilePhone = TextEditingController();
  String userProfilePic = '';
  TextEditingController profileDOB = TextEditingController();
  DateFormat dateFormatterMonDay = DateFormat("dd/MM/yyyy");
  String monDaystring;
  TextEditingController aliasName = TextEditingController();
  TextEditingController aboutMe = TextEditingController();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController countrySelection = TextEditingController();
  //TextEditingController countrySelection1 = new TextEditingController();
  TextEditingController countryCase = TextEditingController();
  TextEditingController stateCase = TextEditingController();

  TextEditingController profileCountry = TextEditingController();

  String countryId;

  String countryCodeIntialValue = '+91';
  String countryName = '';

  bool visibility = false;
  bool isLoadingCountry = false;
  bool isLoadingState = false;
  // Group Value for Radio Button.
  int id = 1;
  String radioButtonItem = 'Male';
  bool checkBoxAliasValue = false;
  var dob, gender;

  StateSetter mycountry1, mystate1;
  @override
  void initState() {
    super.initState();

    _profileDetailsBloc.getUserDetails();
    listenApi();

    _addCaseBloc.CountryListAPI(page: "0", searchTitle: '');
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
                          height: MediaQuery.of(context).size.height * 0.20,
                          gaplessPlayback: true,
                          fit: BoxFit.fill,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 30),
                                child: Image.asset(
                                  "assets/images/back_arrow.png",
                                  width: 20,
                                  height: 17,
                                  gaplessPlayback: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 30.0, top: 30),
                              child: Text("Edit Profile",
                                  style: TextStyle(
                                    color: CustColors.DarkBlue,
                                    fontSize: 18.0,
                                    fontFamily: 'Formular',
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            width: 130.0,
                            height: 130.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: _img == null
                                  ? Container(
                                      child: userProfilePic != null ||
                                              userProfilePic != ''
                                          ? CachedNetworkImage(
                                              imageUrl: userProfilePic,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: 120.0,
                                                height: 120.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              //placeholder: (context, url) => ProgressBarLightRose(),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.white,
                                              child: ClipOval(
                                                child: Image.asset(
                                                  'assets/images/dummy_image_user.png',
                                                ),
                                              )))
                                  : SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: FileImage(_img),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          const Expanded(
                                              flex: 5,
                                              child: Text("Select Image Type")),
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.clear,
                                                color: Colors.black87,
                                                size: 24,
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              child: Image.asset(
                                                  'assets/images/profilecameranew.png',
                                                  width: 70,
                                                  height: 70),
                                              onTap: () async {
                                                Navigator.pop(context);
                                                var image = await ImagePicker()
                                                    .pickImage(
                                                        source:
                                                            ImageSource.camera,
                                                        imageQuality: 70);

                                                print(image.path);
                                                setState(() {
                                                  _uploadFilePathList.insert(
                                                      0, image.path.toString());
                                                });

                                                if (image != null) {
                                                  setState(() {
                                                    _img = File(image.path);
                                                    visible = true;
                                                  });

                                                  ///call api

                                                  _profileDetailsBloc
                                                      .profileImageUploadApi(
                                                          _uploadFilePathList);
                                                }
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              child: Image.asset(
                                                  'assets/images/profileimagenew.png',
                                                  width: 70,
                                                  height: 70),
                                              onTap: () async {
                                                Navigator.pop(context);
                                                var image = await ImagePicker()
                                                    .pickImage(
                                                        source:
                                                            ImageSource.gallery,
                                                        imageQuality: 70);
                                                setState(() {
                                                  _uploadFilePathList.insert(
                                                      0, image.path.toString());
                                                });

                                                if (image != null) {
                                                  setState(() {
                                                    _img = File(image.path);
                                                    visible = true;
                                                  });

                                                  ///call api

                                                  _profileDetailsBloc
                                                      .profileImageUploadApi(
                                                          _uploadFilePathList);
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });

                              /*showDialog(
                                  context: context,
                                  child: new AlertDialog(
                                    title: Row(
                                      children: [
                                        Expanded(
                                            flex: 5,
                                            child:
                                                new Text("Select Image Type")),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.clear,
                                              color: Colors.black87,
                                              size: 24,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            child: Image.asset(
                                                'assets/images/profilecameranew.png',
                                                width: 70,
                                                height: 70),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              var image =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.camera,
                                                      imageQuality: 70);

                                              print(image.path);
                                              setState(() {
                                                _uploadFilePathList.insert(
                                                    0, image.path.toString());
                                              });

                                              if (image != null) {
                                                setState(() {
                                                  _img = image;
                                                  visible = true;
                                                });

                                                ///call api

                                                _profileDetailsBloc
                                                    .profileImageUploadApi(
                                                        _uploadFilePathList);
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            child: Image.asset(
                                                'assets/images/profileimagenew.png',
                                                width: 70,
                                                height: 70),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              var image =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                      imageQuality: 70);
                                              setState(() {
                                                _uploadFilePathList.insert(
                                                    0, image.path.toString());
                                              });

                                              if (image != null) {
                                                setState(() {
                                                  _img = image;
                                                  visible = true;
                                                });

                                                ///call api

                                                _profileDetailsBloc
                                                    .profileImageUploadApi(
                                                        _uploadFilePathList);
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ));*/
                            },
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFfeb0ac).withOpacity(0.4),
                                  shape: BoxShape.circle,
                                ),
                                width: 130.0,
                                height: 130.0,
                                child: Center(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/images/editnew.png',
                                          height: 30,
                                          width: 30,
                                        ))),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFieldWidgetSignUpMandatory(
                        controller: firstName,
                        textInputType: TextInputType.text,
                        height: 50,
                        width: double.infinity,
                        backgroundColor: CustColors.LightRose,
                        alignment: TextAlign.start,
                        hintText: "First Name",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFieldWidgetSignUpMandatory(
                        controller: lastName,
                        textInputType: TextInputType.text,
                        height: 50,
                        width: double.infinity,
                        backgroundColor: CustColors.LightRose,
                        alignment: TextAlign.start,
                        hintText: "Last Name",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFieldWidgetSignUpMandatory(
                        controller: aliasName,
                        textInputType: TextInputType.text,
                        height: 50,
                        width: double.infinity,
                        backgroundColor: CustColors.LightRose,
                        alignment: TextAlign.start,
                        hintText: "Alias Name",
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Checkbox(
                            value: checkBoxAliasValue,
                            onChanged: (bool value) {
                              print(value);
                              setState(() {
                                checkBoxAliasValue = value;
                              });
                            },
                            activeColor: CustColors.Radio,
                          ),
                        ),
                        const Text(
                          'Use Alias name instead of name ',
                          style: TextStyle(
                              fontSize: 17.0, color: CustColors.DarkBlue),
                        )
                      ],
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
                                        controller: aboutMe,
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
                    GestureDetector(
                      onTap: () {
                        toastMsg("Email_id Can't be Edit");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            TextFieldWidgetProfileEmailMandatory(
                              controller: profileEmailId,
                              textInputType: TextInputType.emailAddress,
                              height: 50,
                              maxLines: 1,
                              enabled: false,
                              width: double.infinity,
                              backgroundColor: CustColors.LightRose,
                              alignment: TextAlign.start,
                              hintText: "Email ID",
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showCountryDialog();
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: SizedBox(
                          height: 50,
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
                                child: TextField(
                                  controller: countryCase,
                                  textAlign: TextAlign.left,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Select your Country',
                                    hintStyle: const TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(16),
                                    fillColor: CustColors.LightRose,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      //visible: CountryCase.text==''||CountryCase.text.isEmpty?false:true,
                      child: InkWell(
                        onTap: () {
                          showStateDialog();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: SizedBox(
                            height: 45,
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
                                  child: TextField(
                                    controller: stateCase,
                                    textAlign: TextAlign.left,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: 'Select your State',
                                      hintStyle: const TextStyle(fontSize: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(16),
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(0),
                            child: Column(children: <Widget>[
                              CountryListPick(
                                appBar: AppBar(
                                  backgroundColor: CustColors.DarkBlueLight,
                                  title: const Text('Select Country'),
                                ),
                                pickerBuilder:
                                    (context, CountryCode countryCode) {
                                  //countrySelection.text=countryCode.dialCode.toString();
                                  return Container(
                                    height: 50,
                                    color: CustColors.LightRose,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          /*Container(
                                                padding: EdgeInsets.only(left: 5, right: 0, top: 0),
                                                height:30,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    boxShadow: [BoxShadow(color: CustColors.LightRose)]
                                                ),
                                                child: Image.asset(
                                                  countryCode.flagUri,
                                                  package: 'country_list_pick',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),*/
                                          Stack(
                                            children: [
                                              /* Padding(
                                                    padding: const EdgeInsets.fromLTRB(5,0,5,10),
                                                    child: Text('Phone Code',
                                                    ),
                                                  ),*/
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child:
                                                    TextFieldWidgetProfileEmail1(
                                                  controller: countrySelection,
                                                  textInputType:
                                                      TextInputType.text,
                                                  height: 50,
                                                  enabled: false,
                                                  maxLines: 1,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      131,
                                                  labelText:
                                                      countryCode.dialCode,
                                                  backgroundColor:
                                                      CustColors.LightRose,
                                                  alignment: TextAlign.start,
                                                  hintText: "Select Country",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },

                                // To disable option set to false
                                theme: CountryTheme(
                                  isShowFlag: true,
                                  isShowTitle: true,
                                  isShowCode: true,
                                  isDownIcon: true,
                                  showEnglishName: true,
                                ),
                                // Set default value
                                initialSelection: countryCodeIntialValue,
                                onChanged: (CountryCode code) {
                                  setState(() {
                                    countrySelection.text =
                                        code.dialCode.toString();
                                  });
                                  print(code.name);
                                  print(code.code);
                                  print(code.dialCode);
                                  print(code.flagUri);
                                },
                              ),
                            ])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFieldWidgetSignUpMandatory(
                        controller: profilePhone,
                        textInputType: TextInputType.phone,
                        height: 50,
                        width: double.infinity,
                        backgroundColor: CustColors.LightRose,
                        alignment: TextAlign.start,
                        hintText: "Phone Number",
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              color: CustColors.DarkBlue,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomRadioWidget(
                            value: 1,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Male';
                                id = 1;
                              });
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Male',
                            style: TextStyle(
                                fontSize: 17.0, color: CustColors.Grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: CustomRadioWidget(
                            value: 2,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Female';
                                id = 2;
                              });
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Female',
                            style: TextStyle(
                                fontSize: 17.0, color: CustColors.Grey),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFieldWidgetMandatoryDOB(
                        inputFormatterRules: [
                          LengthLimitingTextInputFormatter(8),
                          DateFormatter()
                        ],
                        backgroundColor: CustColors.LightRose,
                        height: 50,
                        hintText: 'Date of Birth',
                        maxLines: 1,
                        autofocus: false,
                        textInputType: TextInputType.number,
                        alignment: TextAlign.start,
                        enabled: true,
                        controller: profileDOB,
                        // focusNode: null,
                        onSubmitted: null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SubmitFlatButtonWidget(
                          height: 50,
                          width: double.infinity,
                          backgroundColor: CustColors.DarkBlue,
                          buttonText: "Submit",
                          buttonTextColor: Colors.white,
                          onpressed: () {
                            if (firstName.text.isEmpty ||
                                firstName.text == '') {
                              toastMsg("Enter FirstName");
                            } else if (lastName.text.isEmpty ||
                                lastName.text == '') {
                              toastMsg("Enter LastName");
                            } else if (aliasName.text.isEmpty ||
                                aliasName.text == '') {
                              toastMsg("Enter Alias Name");
                            } else if (countryCase.text.isEmpty ||
                                countryCase.text == '') {
                              toastMsg("Select Country");
                            } else if (stateCase.text.isEmpty ||
                                stateCase.text == '') {
                              toastMsg("Select State");
                            } else if (profilePhone.text.isEmpty ||
                                profilePhone.text == '') {
                              toastMsg("Enter Phone Number");
                            } else if (aboutMe.text.isEmpty ||
                                aboutMe.text == '') {
                              toastMsg("Enter About Yourself");
                            } else if (profileDOB.text.isEmpty ||
                                profileDOB.text == '') {
                              toastMsg("Enter Date of Birth");
                            } else if (!regExp
                                .hasMatch(profileDOB.text.toString())) {
                              toastMsg("Invalid Date Of Birth");
                            } else if (ageCalculate(
                                    profileDOB.text.toString()) <
                                15) {
                              toastMsg("Minimum Age limit 16");
                            } else {
                              setState(() {
                                visible = true;
                              });
                              _profileDetailsBloc.performEditProfile(
                                  countryCase.text,
                                  stateCase.text,
                                  countrySelection.text,
                                  firstName.text,
                                  lastName.text,
                                  profileName.text,
                                  radioButtonItem,
                                  profileDOB.text,
                                  profilePhone.text,
                                  aliasName.text.toString(),
                                  checkBoxAliasValue,
                                  aboutMe.text.toString());
                            }

                            print(radioButtonItem);
                            print(profileName.text);

                            print(profilePhone.text);
                            print(profileDOB.text);

                            // setState(() {
                            //   visible = true;
                            // });
                          },
                        ),
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

  Widget ProgressBarLightRose() {
    return const SizedBox(
      height: 60.0,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(CustColors.Radio),
      )),
    );
  }

  void listenApi() {
    _profileDetailsBloc.getUserDetailsStream.listen((data) {
      if ((data.status == "success")) {
        print(">>>>>>>>> ${data.status}");
        if (data.data.userProfile.isNotEmpty) {
          if (data.data.userProfile[0].profilePic != null) {
            userProfilePic = data.data.userProfile[0].profilePic;
          } else {
            userProfilePic = "";
          }
        } else {
          userProfilePic = '';
        }

        if (data.data.phone == null || data.data.phone == "null") {
          profilePhone.text = '';
        } else {
          profilePhone.text = data.data.phone;
        }

        if (data.data.userProfile.isNotEmpty) {
          if (data.data.userProfile[0].aboutMe == null ||
              data.data.userProfile[0].aboutMe == "null") {
            aboutMe.text = '';
          } else {
            aboutMe.text = data.data.userProfile[0].aboutMe;
          }

          if (data.data.userProfile[0].aliasName == null ||
              data.data.userProfile[0].aliasName == "null") {
            aliasName.text = '';
          } else {
            aliasName.text = data.data.userProfile[0].aliasName;
          }

          if (data.data.userProfile[0].aliasFlag == 1) {
            checkBoxAliasValue = true;
          } else {
            checkBoxAliasValue = false;
          }

          if (data.data.userProfile[0].country == null ||
              data.data.userProfile[0].country == "null") {
            countryCase.text = '';
          } else {
            countryCase.text = '${data.data.userProfile[0].country}';
          }

          if (data.data.userProfile[0].state == null ||
              data.data.userProfile[0].state == "null") {
            stateCase.text = '';
          } else {
            stateCase.text = '${data.data.userProfile[0].state}';
          }

          if (data.data.firstName == null || data.data.firstName == "null") {
            if (data.data.userProfile[0].displayName == null ||
                data.data.displayName == "null") {
              firstName.text = '';
            } else {
              String fullName = data.data.userProfile[0].displayName;
              var names = fullName.split(' ');
              String firstName1 = names[0];
              String lastName1 = fullName.substring(names[0].length);
              print(firstName1);
              print(lastName1);
              firstName.text = firstName1;
            }
          } else {
            firstName.text = '${data.data.firstName}';
          }

          if (data.data.lastName == null || data.data.lastName == "null") {
            if (data.data.userProfile[0].displayName == null ||
                data.data.displayName == "null") {
              lastName.text = '';
            } else {
              String fullName = data.data.userProfile[0].displayName;
              var names = fullName.split(' ');
              String firstName1 = names[0];
              String lastName1 = fullName.substring(names[0].length);
              print(firstName1);
              print(lastName1);
              lastName.text = lastName1;
            }
          } else {
            lastName.text = '${data.data.lastName}';
          }

          if (data.data.countryCode.toString() == null ||
              data.data.countryCode.toString() == "null" ||
              data.data.countryCode.toString() == "") {
            print("mmmmmmmm");
            countryCodeIntialValue = '+91';
            countrySelection.text = '+91';
          } else {
            print("kkkkkkkkkkk");
            setState(() {
              countryCodeIntialValue =
                  '+${data.data.countryCode.toString().trim()}';
              countrySelection.text =
                  '+${data.data.countryCode.toString().trim()}';
            });
            print(countrySelection.text);
          }

          profileName.text = data.data.displayName;
          dob = data.data.userProfile[0].dob;
          gender = data.data.userProfile[0].gender;
        } else {
          if (data.data.firstName == null || data.data.firstName == "null") {
            firstName.text = '';
          } else {
            firstName.text = '${data.data.firstName}';
          }

          if (data.data.lastName == null || data.data.lastName == "null") {
            lastName.text = '';
          } else {
            lastName.text = '${data.data.lastName}';
          }

          if (data.data.countryCode.toString() == null ||
              data.data.countryCode.toString() == "null" ||
              data.data.countryCode.toString() == "") {
            print("ggggggg");
            countryCodeIntialValue = '+91';
          } else {
            print("ffffffff");
            countryCodeIntialValue = '+${data.data.countryCode.toString()}';
          }

          /* if (data.data.userProfile[0].country.toString() == null ||
              data.data.userProfile[0].country.toString() == "null" ||
              data.data.userProfile[0].country.toString() == "") {
            print("ggggggg");
            countryCodeIntialValue = '';
          } else {
            print("ffffffff");
            setState(() {
              countryCase.text = '${data.data.userProfile[0].country.toString()}';
            });
            //countryCodeIntialValue = '+${data.data.userProfile[0].country.toString()}';
          }*/

          //print(data.data.userProfile[0].country);

          profileName.text = data.data.username;
          aliasName.text = '';
          aboutMe.text = '';
          profileDOB.text = '';
          dob = '';
          gender = '';
          checkBoxAliasValue = false;
        }

        profileEmailId.text = data.data.emailId;
        profileDOB.text = dob == 'null' || dob == '' ? '' : dob;

        setState(() {
          radioButtonItem =
              (gender == 'Male' || gender == '' ? 'Male' : 'Female');
          id = radioButtonItem == 'Male' ? 1 : 2;
          visible = false;
        });
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
          _img = null;
        });
        toastMsg(data.message);
      }
    });

    _profileDetailsBloc.profileImageStream.listen((data) {
      if ((data.status == "success")) {
        print(data.status);
        toastMsg(data.message);
        setState(() {
          visible = false;
        });
        Future.delayed(const Duration(seconds: 1)).then((_) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainLandingPage(frompage: "3")),
              ModalRoute.withName("/MainLandingPage"));
        });
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
        });
        toastMsg(data.message);
      }
    });

    _profileDetailsBloc.editProfileStream.listen((data) {
      if ((data.status == "success")) {
        print(data.status);
        toastMsg(data.message);
        setState(() {
          visible = false;
        });
        Future.delayed(const Duration(seconds: 1)).then((_) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainLandingPage(frompage: "3")),
              ModalRoute.withName("/MainLandingPage"));
        });
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
        });
        toastMsg(data.message);
      }
    });

    _addCaseBloc.countryListStream.listen((data) {
      if ((data.status == "success")) {
        print(" ${data.status.toString()}countryListStream");
        mycountry1(() {
          isLoadingCountry = false;
        });
        print(" ${data.status}");
      } else if ((data.status == "error")) {
        print(" ${data.status.toString()}countryListStream");
        mycountry1(() {
          isLoadingCountry = false;
        });
        print(data.status);
      }
    });
    _addCaseBloc.stateListStream.listen((data) {
      if ((data.status == "success")) {
        mystate1(() {
          isLoadingState = false;
        });
        print(" ${data.status}");
      } else if ((data.status == "error")) {
        mystate1(() {
          isLoadingState = false;
        });
        print(data.status);
      }
    });
  }

  RegExp regExp = RegExp(
    r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$",
    caseSensitive: true,
    multiLine: false,
  );

//method to calculate age on Today (in years)
  int ageCalculate(String input) {
    if (regExp.hasMatch(input)) {
      DateTime _dateTime = DateTime(
        int.parse(input.substring(6)),
        int.parse(input.substring(3, 5)),
        int.parse(input.substring(0, 2)),
      );
      return DateTime.fromMillisecondsSinceEpoch(
                  DateTime.now().difference(_dateTime).inMilliseconds)
              .year -
          1970;
    } else {
      return -1;
    }
  }

  Widget showCountryDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Select Country"),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter mycountry) {
              mycountry1 = mycountry;
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: CustColors.LightRose,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                width: double.infinity,
                                child: TextFormField(
                                  onChanged: (text) {
                                    _addCaseBloc.CountryListAPI(
                                        page: '0', searchTitle: text);
                                  },
                                  textAlign: TextAlign.left,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search",
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                                child: Image.asset(
                                    'assets/images/rosesearch.png',
                                    width: 20,
                                    height: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: StreamBuilder(
                          stream: _addCaseBloc.countryListStream,
                          builder: (context,
                              AsyncSnapshot<CountryListModel> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.connectionState ==
                                    ConnectionState.none) {
                              return Center(child: ProgressBarLightRose());
                            } else if (snapshot.hasData ||
                                snapshot.data.data.data.isNotEmpty) {
                              if (snapshot.data.status == 'error') {
                                return noDataFound();
                              } else if (snapshot.data.data.data.isEmpty) {
                                return noDataFound();
                              }
                            } else {
                              return Center(child: ProgressBarDarkBlue());
                            }
                            return NotificationListener(
                              // ignore: missing_return
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!_addCaseBloc.paginationLoading &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  // start loading data
                                  if (snapshot.data.data.currentPage <
                                      snapshot.data.data.totalPages) {
                                    final page =
                                        snapshot.data.data.currentPage + 1;
                                    mycountry1(() {
                                      isLoadingCountry = true;
                                    });
                                    _addCaseBloc.CountryListAPI(
                                        page: page.toString(), searchTitle: '');
                                  }
                                }
                              },

                              child: ListView.builder(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.data.data.length,
                                itemBuilder: (context, index) {
                                  /*if ((index+1) == snapshot.data.data.data.length ) {//pagination loader
                                                              return Container(
                                                                padding: EdgeInsets.only(bottom: 10),
                                                                child: snapshot.data.data.currentPage +1 < snapshot.data.data.totalPages
                                                                    ? Center(child: ProgressBarDarkBlue(),) :  Container(),
                                                              );
                                                            }*/

                                  return ListTile(
                                    onTap: () {
                                      /// Navigate To CaseDetails
                                      countryId = snapshot
                                          .data.data.data[index].id
                                          .toString();
                                      var name =
                                          snapshot.data.data.data[index].name;
                                      print(countryId);
                                      print(name);
                                      _addCaseBloc.StateListAPI(
                                          page: "0",
                                          searchTitle: '',
                                          countryId: countryId.toString());
                                      setState(() {
                                        stateCase.text = '';
                                        countryCase.text = name;
                                      });

                                      Navigator.pop(context);
                                    },
                                    title: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: AutoSizeText(
                                                snapshot
                                                    .data.data.data[index].name,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                                minFontSize: 10,
                                                stepGranularity: 1,
                                                maxLines: 4,
                                                textAlign: TextAlign.justify,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 3, 5, 3),
                                            child: Divider(
                                              height: 1,
                                              color: Colors.white54,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // onTap: () =>pubDetails(snapshot.data.data[index]),
                                  );
                                },
                              ),
                            );
                          }),
                    ),
                    isLoadingCountry
                        ? Center(
                            child: ProgressBarLightRose(),
                          )
                        : Container(),
                  ],
                ),
              );
            }),
          );
        });
  }

  Widget showStateDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Select State"),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter mystate) {
              mystate1 = mystate;
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: CustColors.LightRose,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                width: double.infinity,
                                child: TextFormField(
                                  onChanged: (text) {
                                    _addCaseBloc.StateListAPI(
                                        page: "0",
                                        searchTitle: text,
                                        countryId: countryId);
                                  },
                                  textAlign: TextAlign.left,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search",
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                width: double.infinity,
                                child: Image.asset(
                                    'assets/images/rosesearch.png',
                                    width: 20,
                                    height: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: StreamBuilder(
                          stream: _addCaseBloc.stateListStream,
                          builder: (context,
                              AsyncSnapshot<StateListModel> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.connectionState ==
                                    ConnectionState.none) {
                              return Center(child: ProgressBarLightRose());
                            } else if (snapshot.hasData ||
                                snapshot.data.data.data.isNotEmpty) {
                              if (snapshot.data.status == 'error') {
                                return noDataFound();
                              } else if (snapshot.data.data.data.isEmpty) {
                                return noDataFound();
                              }
                            } else {
                              return Center(child: ProgressBarDarkBlue());
                            }
                            return NotificationListener(
                              // ignore: missing_return
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!_addCaseBloc.paginationLoading &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  // start loading data
                                  if (snapshot.data.data.currentPage <
                                      snapshot.data.data.totalPages) {
                                    final page =
                                        snapshot.data.data.currentPage + 1;
                                    mystate1(() {
                                      //isLoadingState = true;
                                    });
                                    _addCaseBloc.StateListAPI(
                                        page: page.toString(),
                                        searchTitle: '',
                                        countryId: countryId);
                                  }
                                }
                              },

                              child: ListView.builder(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.data.data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      /// Navigate To CaseDetails
                                      var countryId = snapshot
                                          .data.data.data[index].countryId;
                                      var name =
                                          snapshot.data.data.data[index].name;
                                      print(countryId);
                                      print(name);
                                      stateCase.text = name;
                                      Navigator.pop(context);
                                    },
                                    title: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: AutoSizeText(
                                                snapshot
                                                    .data.data.data[index].name,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                                minFontSize: 10,
                                                stepGranularity: 1,
                                                maxLines: 4,
                                                textAlign: TextAlign.justify,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 3, 5, 3),
                                            child: Divider(
                                              height: 1,
                                              color: Colors.white54,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // onTap: () =>pubDetails(snapshot.data.data[index]),
                                  );
                                },
                              ),
                            );
                          }),
                    ),
                    /*isLoadingState
                            ? Center(child: ProgressBarLightRose(),)
                            : Container(),*/
                  ],
                ),
              );
            }),
          );
        });
  }

  Widget noDataFound() {
    return SingleChildScrollView(
      child: Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/caseimagedummy.png',
                    width: 250, height: 250),
                const Text('No Data Found',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                        color: Colors.blueGrey))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
