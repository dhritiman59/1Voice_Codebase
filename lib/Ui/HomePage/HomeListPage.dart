import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/sharedPrefKeys.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Models/AllCaseDetailsModel/AllCaseDetailsModel.dart';
import 'package:bring2book/Ui/AddCase/AddCaseCategoryPage.dart';
import 'package:bring2book/Ui/CardListPage/CardListPage.dart';
import 'package:bring2book/Ui/CaseDetails/CaseDetailsPage.dart';
import 'package:bring2book/Ui/HomePage/HomeListAllCasesBloc.dart';
import 'package:bring2book/Ui/HomePage/HomeListPageBloc.dart';
import 'package:bring2book/Ui/HomePage/CountryStateFilterPage.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:android_intent/android_intent.dart';

import 'package:geolocator/geolocator.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'package:bring2book/Ui/base/CustomDropdownButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeListPage extends StatefulWidget {
  @override
  _HomeListPageState createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //DateTime timeBackPressed = DateTime.now();
  final HomeListAllCasesBloc _homeListAllCasesBloc = HomeListAllCasesBloc();
  HomeListPageBloc bloc = HomeListPageBloc();
  final TextEditingController _searchText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool visible = false;
  final ScrollController _controller = ScrollController();
  bool silverCollapsed = false;
  bool visibleCategoryNames = true;
  double heightofappbar = 180;
  double expandedHeight = 340;
  bool visibleCategoryBar = true;
  bool visibleCategoryTitle = true;
  String categoryfilterString = "";
  String Join = 'Join';
  String Joinicon = 'assets/images/join_grey_icon.png';
  String userDisplayName = '', userProfilePic = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AllCaseDetailsModel allCaseDetailsModel = AllCaseDetailsModel();
  String dropDownSelectedValue = '';
  Item selectedUser;
  List<Item> users = <Item>[
    const Item('Featured'),
    const Item('Newest'),
    const Item('Most Commented'),
    const Item('Most Ranked'),
    const Item('All'),
  ];

  String filterCountry = "";
  String filterState = "";
  bool bannerad;
  String elementRandomFilter = "id";
  bool isLoadingCases = false;

  final Geolocator geolocator = Geolocator();

  Position currentPosition;
  String _currentAddress;
  String currentLat = "";
  String currentState = "";
  String currentLong = "";

  bool visibleError = false;

  Timer timer;

  @override
  void initState() {
    super.initState();

    signIn("chat1voices@gmail.com", "123456");
    getCurrentLocation(LocationAccuracy.low);
    //timer = Timer.periodic(Duration(seconds: 10), (Timer t) => getCurrentLocation(LocationAccuracy.low));

    // showAlert();
    getToken();
    //print('_searchText.text   ${_searchText.text}');
    _homeListAllCasesBloc.getUserDetails();

    _homeListAllCasesBloc.allCaseAPI(page: "0", sortBy: "id");

    _controller.addListener(() {
      if (_controller.offset > _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
        if (!silverCollapsed) {
          // do what ever you want when silver is collapsing !
          print("Collapsinbutton");
          silverCollapsed = true;
          if (_searchText.text != '') {
            setState(() {
              visibleCategoryBar = true;
              visibleCategoryTitle = true;
              visibleCategoryNames = false;
              heightofappbar = 170;
              expandedHeight = 360;
            });
          } else {
            setState(() {
              visibleCategoryNames = false;
              heightofappbar = 140;
            });
          }
        }
      }
      if (_controller.offset <= _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
        if (silverCollapsed) {
          // do what ever you want when silver is expanding !
          print("expandinbutton");
          silverCollapsed = false;

          if (_searchText.text != '') {
            setState(() {
              visibleCategoryBar = false;
              visibleCategoryTitle = false;
              visibleCategoryNames = true;
              heightofappbar = 0;
              expandedHeight = 170;
            });
          } else {
            setState(() {
              visibleCategoryBar = true;
              visibleCategoryTitle = true;
              visibleCategoryNames = true;
              heightofappbar = 180;
              expandedHeight = 340;
            });
          }
        }
      }
    });
    getCurrentLocation(LocationAccuracy.low);
    listenApiCall();
  }

  getCurrentLocation(LocationAccuracy accuracy) async {
    if (currentLong == "" && currentLat == "") {
      _gpsService();
    } else {
      print("currentLatcurrentLatcurrentLatcurrentLatcurrentLat");

      currentLat = '1.352083';
      currentLong = '103.819839';

      print(currentLat);
      print(currentLong);
      print("currentLatcurrentLatcurrentLatcurrentLatcurrentLatcurrentLat");
    }

    final geolocator = GeolocatorPlatform.instance;
    print("666666666666666777777777");

    geolocator
        .getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: accuracy,
      ),
    )
        .then((Position position) {
      print("555555555555555555getCurrentLocation Success");
      setState(() {
        currentPosition = position;
      });

      currentLat = currentPosition.latitude.toString();
      currentLong = currentPosition.longitude.toString();

      _homeListAllCasesBloc.performUpdateLatLng(currentLat, currentLong);

      print(currentLat);
      print(currentLong);
      print("currentLatcurrentLatcurrentLatcurrentLatcurrentLatcurrentLat");
      _homeListAllCasesBloc.performUpdateLatLng(currentLat, currentLong);
      _getAddressFromLatLng();
    }).catchError((e) {
      //locationSink.add(e);
      print("555555555555555555getCurrentLocation Error");
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      // List<Placemark> p = await geolocator.placemarkFromCoordinates(
      //     currentPosition.latitude, currentPosition.longitude);

      // Placemark place = p[0];

      setState(() {
        // _currentAddress =
        // "${place.locality}, ${place.postalCode}, ${place.country}";

        // currentState = place.country;
        // print(place.country);
      });
    } catch (e) {
      print(e);
    }
  }

  /*Show dialog if GPS not enabled and open settings location*/
  Future _checkGps() async {
    if (!(await GeolocatorPlatform.instance.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Can't get current location"),
                content:
                    const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        const AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();

                        //_gpsService();
                      })
                ],
              );
            });
      }
    }
  }

  /*Check if gps service is enabled or not*/
  Future _gpsService() async {
    if (!(await GeolocatorPlatform.instance.isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else {
      return true;
    }
  }

  Future<User> signIn(String email, String password) async {
    try {
      final UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      final User user = authResult.user;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = auth.currentUser;
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Future.delayed(Duration(seconds: 5),() => showAlert(context));
    /*return WillPopScope(
        onWillPop: () async{
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);

          timeBackPressed = DateTime.now();
          if(isExitWarning){
            */ /*final message = 'Press back again to exit';
            Fluttertoast.showToast(msg: message,fontSize: 18);*/ /*
            return false;
          }else{
            ShowPopUpWidget().showPopUp(context);
            //Fluttertoast.cancel();
            return true;
          }
        },
        child: ,
    );*/

    return Stack(children: [
      Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: CustColors.DarkBlue,
                expandedHeight: expandedHeight,
                floating: true,
                pinned: true,
                elevation: 0.0,
                bottom: PreferredSize(
                  // Add this code
                  preferredSize:
                      Size.fromHeight(heightofappbar), // Add this code
                  child: Center(
                    child: Visibility(
                      visible: visibleCategoryBar,
                      child: Container(
                        alignment: Alignment.center,
                        height: heightofappbar,
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 0),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              InkWell(
                                                child: Image.asset(
                                                    'assets/images/humantrafficiking.png',
                                                    width: 50,
                                                    height: 50),
                                                onTap: () {
                                                  setState(() {
                                                    _searchText.text = '';
                                                    visible = true;
                                                    categoryfilterString =
                                                        "Human trafficking";
                                                  });
                                                  if (dropDownSelectedValue ==
                                                      '') {
                                                    _homeListAllCasesBloc
                                                        .allCaseFilterAPI(
                                                            page: "0",
                                                            search:
                                                                categoryfilterString,
                                                            sortBy:
                                                                "commentCount");
                                                  } else {
                                                    _homeListAllCasesBloc
                                                        .allCaseFilterAPI(
                                                            page: "0",
                                                            search:
                                                                categoryfilterString,
                                                            sortBy:
                                                                dropDownSelectedValue);
                                                  }
                                                },
                                              ),
                                              Visibility(
                                                  visible: visibleCategoryNames,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 5),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: AutoSizeText(
                                                        'Human trafficking',
                                                        style: Styles
                                                            .homeCategoryNameswhite,
                                                        minFontSize: 10,
                                                        stepGranularity: 10,
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              InkWell(
                                                child: Image.asset(
                                                    'assets/images/curroption.png',
                                                    width: 50,
                                                    height: 50),
                                                onTap: () {
                                                  setState(() {
                                                    _searchText.text = '';
                                                    visible = true;
                                                    categoryfilterString =
                                                        "Corruption";
                                                  });
                                                  if (dropDownSelectedValue ==
                                                      '') {
                                                    _homeListAllCasesBloc
                                                        .allCaseFilterAPI(
                                                            page: "0",
                                                            search:
                                                                categoryfilterString,
                                                            sortBy:
                                                                "commentCount");
                                                  } else {
                                                    _homeListAllCasesBloc
                                                        .allCaseFilterAPI(
                                                            page: "0",
                                                            search:
                                                                categoryfilterString,
                                                            sortBy:
                                                                dropDownSelectedValue);
                                                  }
                                                },
                                              ),
                                              Visibility(
                                                  visible: visibleCategoryNames,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 5),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: AutoSizeText(
                                                        'Corruption',
                                                        style: Styles
                                                            .homeCategoryNameswhite,
                                                        minFontSize: 10,
                                                        stepGranularity: 10,
                                                        maxLines: 4,
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              InkWell(
                                                child: Image.asset(
                                                    'assets/images/environmentabusing.png',
                                                    width: 50,
                                                    height: 50),
                                                onTap: () {
                                                  setState(() {
                                                    _searchText.text = '';
                                                    visible = true;
                                                    categoryfilterString =
                                                        "Environment abusing";
                                                  });
                                                  if (dropDownSelectedValue ==
                                                      '') {
                                                    _homeListAllCasesBloc
                                                        .allCaseFilterAPI(
                                                            page: "0",
                                                            search:
                                                                categoryfilterString,
                                                            sortBy:
                                                                "commentCount");
                                                  } else {
                                                    _homeListAllCasesBloc
                                                        .allCaseFilterAPI(
                                                            page: "0",
                                                            search:
                                                                categoryfilterString,
                                                            sortBy:
                                                                dropDownSelectedValue);
                                                  }
                                                },
                                              ),
                                              Visibility(
                                                  visible: visibleCategoryNames,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 5),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: AutoSizeText(
                                                        'Environment abusing',
                                                        style: Styles
                                                            .homeCategoryNameswhite,
                                                        minFontSize: 10,
                                                        stepGranularity: 10,
                                                        maxLines: 4,
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              InkWell(
                                                child: Image.asset(
                                                    'assets/images/seeall.png',
                                                    width: 50,
                                                    height: 50),
                                                onTap: () {
                                                  setState(() {
                                                    _searchText.text = '';
                                                    visible = true;
                                                    categoryfilterString =
                                                        "others";
                                                  });
                                                  if (dropDownSelectedValue ==
                                                      '') {
                                                    _homeListAllCasesBloc
                                                        .allCaseFilterAPI(
                                                            page: "0",
                                                            search:
                                                                categoryfilterString,
                                                            sortBy:
                                                                "commentCount");
                                                  } else {
                                                    _homeListAllCasesBloc
                                                        .allCaseFilterAPI(
                                                            page: "0",
                                                            search:
                                                                categoryfilterString,
                                                            sortBy:
                                                                dropDownSelectedValue);
                                                  }
                                                },
                                              ),
                                              Visibility(
                                                  visible: visibleCategoryNames,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 5),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: AutoSizeText(
                                                        'Others',
                                                        style: Styles
                                                            .homeCategoryNameswhite,
                                                        minFontSize: 10,
                                                        stepGranularity: 10,
                                                        maxLines: 4,
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    color: Colors.white,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: CustomDropdownButton(
                                      value: selectedUser,
                                      hint: const Text(
                                        "Select filter",
                                        textAlign: TextAlign.end,
                                        style: Styles.homeFilterText,
                                      ),
                                      items: users.map((Item user) {
                                        return DropdownMenuItem<Item>(
                                          value: user,
                                          child: Row(
                                            children: <Widget>[
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                user.name,
                                                textAlign: TextAlign.end,
                                                style: Styles.homeFilterText,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (Item Value) {
                                        setState(() {
                                          visible = true;
                                          selectedUser = Value;
                                          print("dropDownSelectedValue : " +
                                              dropDownSelectedValue);
                                          print("Value.name : " + Value.name);
                                        });

                                        if (Value.name == "Featured") {
                                          setState(() {
                                            _searchText.text = '';
                                            dropDownSelectedValue =
                                                "featuredFlag";
                                          });
                                          _homeListAllCasesBloc.allCaseSortAPI(
                                              page: "0",
                                              sortBy: "featuredFlag");
                                        } else if (Value.name == "Newest") {
                                          setState(() {
                                            _searchText.text = '';
                                            dropDownSelectedValue = "id";
                                          });
                                          _homeListAllCasesBloc.allCaseSortAPI(
                                              page: "0", sortBy: "id");
                                        } else if (Value.name ==
                                            "Most Commented") {
                                          setState(() {
                                            _searchText.text = '';
                                            dropDownSelectedValue =
                                                "commentCount";
                                          });
                                          _homeListAllCasesBloc.allCaseSortAPI(
                                              page: "0",
                                              sortBy: "commentCount");
                                        } else if (Value.name ==
                                            "Most Ranked") {
                                          setState(() {
                                            _searchText.text = '';
                                            dropDownSelectedValue = "rankCount";
                                          });
                                          _homeListAllCasesBloc.allCaseSortAPI(
                                              page: "0", sortBy: "rankCount");
                                        } else if (Value.name == "All") {
                                          setState(() {
                                            _searchText.text = '';
                                            dropDownSelectedValue = "id";
                                          });
                                          _homeListAllCasesBloc.allCaseAPI(
                                              page: "0", sortBy: "id");
                                          /*_homeListAllCasesBloc.allCaseFilterAPI(
                                              page: "0", sortBy: "rankCount");*/
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ), // Add this code
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Text(""),
                  background: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        Column(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  // Expanded(
                                  //   flex: 1,
                                  //   child:
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: userProfilePic.isNotEmpty
                                        //  userProfilePic != null ||
                                        //         userProfilePic != ''
                                        ? CachedNetworkImage(
                                            imageUrl: userProfilePic,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 40.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        'assets/images/dummy_image_user.png',
                                                      ),
                                                    )),
                                          )
                                        : SizedBox(
                                            width: 40.0,
                                            height: 40.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: displayProfilePicWhite(
                                                  userDisplayName),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  // ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 250.0,
                                          child: Text(
                                            'Hi $userDisplayName',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: Styles.textBoldwhite18,
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              'Let’s start spreading goodness……',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: Styles.textNormalwhite12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        callBackToScreen();
                                      },
                                      child: Image.asset(
                                          'assets/images/globehomepage.png',
                                          width: 33,
                                          height: 33),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CardListPage('', '0', '')));
                                      },
                                      child: Image.asset(
                                          'assets/images/adddonateicon.png',
                                          width: 33,
                                          height: 33),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xff85478a),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 5, 0),
                                        width: double.infinity,
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value.length > 3) {
                                                      setState(() {
                                                        visibleError = false;
                                                      });

                                                      return null;
                                                    }
                                                    if (value.length < 3 &&
                                                        value.isNotEmpty) {
                                                      setState(() {
                                                        visibleError = true;
                                                      });
                                                      return null;
                                                      // return 'Atleast 3 Characters Required';
                                                    } else {
                                                      setState(() {
                                                        visibleError = false;
                                                      });
                                                      return null;
                                                    }
                                                  },
                                                  controller: _searchText,
                                                  textAlign: TextAlign.left,
                                                  autofocus: false,
                                                  focusNode: null,
                                                  style: Styles
                                                      .homeCategoryNameswhite,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Search",
                                                    hintStyle: Styles
                                                        .homeCategoryNameswhite,
                                                    errorStyle: Styles
                                                        .homeCategoryNameswhite,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 11,
                                                            right: 11,
                                                            top: 11,
                                                            bottom: 11),
                                                  ),
                                                  onChanged: (text) {
                                                    if (text.isNotEmpty) {
                                                      setState(() {
                                                        expandedHeight = 170;
                                                        heightofappbar = 0;
                                                        visibleCategoryBar =
                                                            false;
                                                        visibleCategoryTitle =
                                                            false;
                                                      });
                                                    }
                                                    if (text.length >= 3) {
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        setState(() {
                                                          visibleError = false;
                                                        });
                                                      }
                                                      setState(() {
                                                        visible = true;
                                                      });
                                                      _homeListAllCasesBloc
                                                          .allCaseSearchAPI(
                                                              page: "0",
                                                              sortBy:
                                                                  "commentCount",
                                                              searchTitle:
                                                                  text);
                                                    } else if (text.isEmpty) {
                                                      setState(() {
                                                        expandedHeight = 340;
                                                        heightofappbar = 180;
                                                        visibleCategoryBar =
                                                            true;
                                                        visibleCategoryTitle =
                                                            true;
                                                        _homeListAllCasesBloc
                                                            .allCaseAPI(
                                                                page: "0",
                                                                sortBy: "id");
                                                      });
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        if (text.isEmpty) {
                                                          setState(() {
                                                            visibleError =
                                                                false;
                                                          });
                                                          return null;
                                                        }
                                                      }
                                                    } else if (text.length <
                                                            3 &&
                                                        text.isNotEmpty) {
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        setState(() {
                                                          visibleError = true;
                                                        });
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    _searchText.text != ""
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  visibleError = false;
                                                  _searchText.text = "";
                                                  expandedHeight = 340;
                                                  heightofappbar = 180;
                                                  visibleCategoryBar = true;
                                                  visibleCategoryTitle = true;
                                                  _homeListAllCasesBloc
                                                      .allCaseAPI(
                                                          page: "0",
                                                          sortBy: "id");
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    if (_searchText
                                                        .text.isEmpty) {
                                                      setState(() {
                                                        visibleError = false;
                                                      });
                                                      return null;
                                                    }
                                                  }
                                                });
                                              },
                                              child: SizedBox(
                                                width: 35,
                                                child: Image.asset(
                                                    'assets/images/closeSearch.png',
                                                    width: 35,
                                                    height: 35),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: SizedBox(
                                        width: 20,
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
                            visibleError == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: const Text(
                                          "Atleast 3 Characters Required",
                                          textAlign: TextAlign.left,
                                          style: Styles.homeCategoryNameswhite,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Visibility(
                              visible: visibleCategoryTitle,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(1, 15, 0, 5),
                                width: double.infinity,
                                child: Column(
                                  children: const [
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'Category',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: Styles.homeCategoryTitlewhite,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Stack(
            children: [
              Container(
                child: _searchText.text == ''
                    ? Column(
                        children: [
                          Flexible(
                            child: StreamBuilder(
                                stream: _homeListAllCasesBloc
                                    .allCaseDetailsRespStream,
                                builder: (context,
                                    AsyncSnapshot<AllCaseDetailsModel>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.status == 'error') {
                                      return noDataFound();
                                    } else if (snapshot
                                        .data.data.data.isEmpty) {
                                      return noDataFound();
                                    } else {}
                                  } else {
                                    return Center(
                                        child: ProgressBarLightRose());
                                  }
                                  return NotificationListener(
                                    // ignore: missing_return
                                    onNotification:
                                        (ScrollNotification scrollInfo) {
                                      if (!_homeListAllCasesBloc
                                              .paginationLoading &&
                                          scrollInfo.metrics.pixels ==
                                              scrollInfo
                                                  .metrics.maxScrollExtent) {
                                        // start loading data
                                        if (snapshot.data.data.currentPage <
                                            snapshot.data.data.totalPages) {
                                          final page =
                                              snapshot.data.data.currentPage +
                                                  1;
                                          if (filterCountry != "" ||
                                              filterState != "") {
                                            _homeListAllCasesBloc
                                                .CountryFilterAPI(
                                              page: page.toString(),
                                              sortBy: "id",
                                              filterCountry: filterCountry,
                                              filterState: filterState,
                                            );
                                          } else if (categoryfilterString ==
                                                  "" &&
                                              dropDownSelectedValue != '') {
                                            _homeListAllCasesBloc
                                                .allCaseSortAPI(
                                                    page: page.toString(),
                                                    sortBy:
                                                        dropDownSelectedValue);
                                          } else if (categoryfilterString !=
                                                  "" &&
                                              dropDownSelectedValue == '') {
                                            _homeListAllCasesBloc
                                                .allCaseFilterAPI(
                                                    page: page.toString(),
                                                    search: categoryfilterString
                                                        .toString(),
                                                    sortBy: "commentCount");
                                          } else if (categoryfilterString !=
                                                  "" &&
                                              dropDownSelectedValue != '') {
                                            _homeListAllCasesBloc
                                                .allCaseFilterAPI(
                                                    page: page.toString(),
                                                    search: categoryfilterString
                                                        .toString(),
                                                    sortBy:
                                                        dropDownSelectedValue);
                                          } else {
                                            setState(() {
                                              isLoadingCases = true;
                                            });
                                            _homeListAllCasesBloc.allCaseAPI(
                                                page: page.toString(),
                                                sortBy: "id");
                                          }
                                        }
                                      }
                                    },

                                    child: RefreshIndicator(
                                      color: CustColors.DarkBlue,
                                      onRefresh: _pullRefresh,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: false,
                                        itemCount:
                                            snapshot.data.data.data.length,
                                        itemBuilder: (context, index) {
                                          if (snapshot.data.data.data[index]
                                              .caseDocument.isNotEmpty) {
                                            print(snapshot.data.data.data[index]
                                                .caseDocument[0].caseDocument
                                                .toString());
                                          }

                                          if (snapshot.data.data.data[index]
                                              .caseDocument.isNotEmpty) {
                                            print("insideCasedoc");
                                            if (snapshot
                                                        .data
                                                        .data
                                                        .data[index]
                                                        .caseDocument[0]
                                                        .docType ==
                                                    "image/jpeg" ||
                                                snapshot
                                                        .data
                                                        .data
                                                        .data[index]
                                                        .caseDocument[0]
                                                        .docType ==
                                                    "image/jpg" ||
                                                snapshot
                                                        .data
                                                        .data
                                                        .data[index]
                                                        .caseDocument[0]
                                                        .docType ==
                                                    "image/png") {
                                              print("image/jpeg");
                                              snapshot.data.data.data[index]
                                                      .caseNetworkImage =
                                                  snapshot
                                                      .data
                                                      .data
                                                      .data[index]
                                                      .caseDocument[0]
                                                      .caseDocument
                                                      .toString();
                                              snapshot.data.data.data[index]
                                                  .bannerImage = '';
                                              snapshot.data.data.data[index]
                                                  .caseVideoImage = '';
                                            } else if (snapshot
                                                        .data
                                                        .data
                                                        .data[index]
                                                        .caseDocument[0]
                                                        .docType ==
                                                    "video/mp4" ||
                                                snapshot
                                                        .data
                                                        .data
                                                        .data[index]
                                                        .caseDocument[0]
                                                        .docType ==
                                                    "video/mov") {
                                              print("video/mp4");

//...................... video thumbnail code to be placed here.................................................................................

                                              snapshot.data.data.data[index]
                                                      .caseVideoImage =
                                                  snapshot
                                                      .data
                                                      .data
                                                      .data[index]
                                                      .caseDocument[0]
                                                      .caseDocument
                                                      .toString();
                                              snapshot.data.data.data[index]
                                                  .caseNetworkImage = '';

                                              if (snapshot.data.data.data[index]
                                                      .caseCategory
                                                      .toString() ==
                                                  'Human trafficking') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/casedetailsHuman.png';
                                              } else if (snapshot.data.data
                                                      .data[index].caseCategory
                                                      .toString() ==
                                                  'Corruption') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/caseDetailCorruptionBanner.png';
                                              } else if (snapshot.data.data
                                                      .data[index].caseCategory
                                                      .toString() ==
                                                  'Environment abusing') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/caseDetailEvabsu.png';
                                              } else {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/casedetailsHuman.png';
                                              }
                                            } else {
                                              if (snapshot.data.data.data[index]
                                                      .caseCategory
                                                      .toString() ==
                                                  'Human trafficking') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/casedetailsHuman.png';
                                                snapshot.data.data.data[index]
                                                    .caseNetworkImage = "";
                                                snapshot.data.data.data[index]
                                                    .caseVideoImage = "";
                                              } else if (snapshot.data.data
                                                      .data[index].caseCategory
                                                      .toString() ==
                                                  'Corruption') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/caseDetailCorruptionBanner.png';
                                                snapshot.data.data.data[index]
                                                    .caseNetworkImage = "";
                                                snapshot.data.data.data[index]
                                                    .caseVideoImage = "";
                                              } else if (snapshot.data.data
                                                      .data[index].caseCategory
                                                      .toString() ==
                                                  'Environment abusing') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/caseDetailEvabsu.png';
                                                snapshot.data.data.data[index]
                                                    .caseNetworkImage = "";
                                                snapshot.data.data.data[index]
                                                    .caseVideoImage = '';
                                              } else {
                                                snapshot.data.data.data[index]
                                                    .caseNetworkImage = "";
                                                snapshot.data.data.data[index]
                                                    .caseVideoImage = "";
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/casedetailsHuman.png';
                                              }
                                            }
                                          } else {
                                            print("outsideCasedoc");
                                            if (snapshot.data.data.data[index]
                                                    .caseCategory
                                                    .toString() ==
                                                'Human trafficking') {
                                              snapshot.data.data.data[index]
                                                      .bannerImage =
                                                  'assets/images/casedetailsHuman.png';
                                              snapshot.data.data.data[index]
                                                  .caseNetworkImage = "";
                                              snapshot.data.data.data[index]
                                                  .caseVideoImage = "";
                                            } else if (snapshot.data.data
                                                    .data[index].caseCategory
                                                    .toString() ==
                                                'Corruption') {
                                              snapshot.data.data.data[index]
                                                      .bannerImage =
                                                  'assets/images/caseDetailCorruptionBanner.png';
                                              snapshot.data.data.data[index]
                                                  .caseNetworkImage = "";
                                              snapshot.data.data.data[index]
                                                  .caseVideoImage = "";
                                            } else if (snapshot.data.data
                                                    .data[index].caseCategory
                                                    .toString() ==
                                                'Environment abusing') {
                                              snapshot.data.data.data[index]
                                                      .bannerImage =
                                                  'assets/images/caseDetailEvabsu.png';
                                              snapshot.data.data.data[index]
                                                  .caseNetworkImage = "";
                                              snapshot.data.data.data[index]
                                                  .caseVideoImage = "";
                                            } else {
                                              snapshot.data.data.data[index]
                                                  .caseNetworkImage = "";
                                              snapshot.data.data.data[index]
                                                  .caseVideoImage = "";
                                              snapshot.data.data.data[index]
                                                      .bannerImage =
                                                  'assets/images/casedetailsHuman.png';
                                            }
                                          }

                                          if (snapshot.data.data.data[index]
                                              .joinedUser.isEmpty) {
                                            Joinicon =
                                                'assets/images/join_grey_icon.png';
                                            Join = 'join';
                                          } else if (snapshot
                                                  .data
                                                  .data
                                                  .data[index]
                                                  .joinedUser[0]
                                                  .status ==
                                              1) {
                                            Joinicon =
                                                'assets/images/leave_case.png';
                                            Join = 'leave';
                                          } else if (snapshot
                                                  .data
                                                  .data
                                                  .data[index]
                                                  .joinedUser[0]
                                                  .status ==
                                              0) {
                                            Joinicon =
                                                'assets/images/join_grey_icon.png';
                                            Join = 'Join';
                                          }
                                          var timeconvert =
                                              _homeListAllCasesBloc.dateconvert(
                                                  snapshot.data.data.data[index]
                                                      .createdAt
                                                      .toString());

                                          String postedbyName;

                                          if (snapshot.data.data.data[index]
                                                      .userProfile.aliasName !=
                                                  null &&
                                              snapshot.data.data.data[index]
                                                      .userProfile.aliasFlag ==
                                                  1) {
                                            postedbyName = snapshot
                                                .data
                                                .data
                                                .data[index]
                                                .userProfile
                                                .aliasName;
                                          } else {
                                            if (snapshot.data.data.data[index]
                                                    .users ==
                                                null) {
                                              postedbyName = '';
                                            } else {
                                              postedbyName = snapshot.data.data
                                                  .data[index].users.displayName
                                                  .toString();
                                            }
                                          }

                                          return ListTile(
                                            onTap: () {
                                              /// Navigate To CaseDetails
                                              var caseid = snapshot
                                                  .data.data.data[index].id;
                                              var userid = snapshot
                                                  .data.data.data[index].userId;
                                              print("jjjjjjjj");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CaseDetailsPage(
                                                            caseId: caseid
                                                                .toString(),
                                                            userId: userid,
                                                            caseNetworkImage:
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .data[index]
                                                                    .caseNetworkImage,
                                                            bannerImage: snapshot
                                                                .data
                                                                .data
                                                                .data[index]
                                                                .bannerImage,
                                                            caseVideoImage: snapshot
                                                                .data
                                                                .data
                                                                .data[index]
                                                                .caseVideoImage,
                                                          )));
                                            },
                                            title: Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Stack(
                                                      children: [
                                                        /*Container(
                                                      child: snapshot
                                                          .data
                                                          .data
                                                          .data[
                                                      index]
                                                          .bannerImage !=
                                                          ""
                                                          ? Container(
                                                          height: 250,
                                                          width: double
                                                              .infinity,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  5.0),
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color: Colors
                                                                  .transparent),
                                                          child: Image.asset(
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .data[index]
                                                                  .bannerImage,
                                                              fit: BoxFit.cover))

                                                      */ /*Container(
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(5.0),
                                                            child:  Image.asset(snapshot.data.data.data[index].bannerImage,),
                                                        ),
                                                      )*/ /*
                                                          : CachedNetworkImage(
                                                        imageUrl: snapshot
                                                            .data
                                                            .data
                                                            .data[
                                                        index]
                                                            .caseNetworkImage,
                                                        imageBuilder:
                                                            (context,
                                                            imageProvider) =>
                                                            Container(
                                                              height:
                                                              250,
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(5.0),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                image: DecorationImage(
                                                                    image:
                                                                    imageProvider,
                                                                    fit:
                                                                    BoxFit.cover),
                                                              ),
                                                            ),
                                                        //placeholder: (context, url) => ProgressBarLightRose(),
                                                      )),*/
                                                        Container(
                                                            child: snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .bannerImage !=
                                                                    ""
                                                                ? Container(
                                                                    height: 350,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5.0),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        color: Colors
                                                                            .transparent),
                                                                    child: Image
                                                                        .asset(
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .bannerImage,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  )
                                                                : CachedNetworkImage(
                                                                    imageUrl: snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .caseNetworkImage,
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      height:
                                                                          350,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.0),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        image: DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                  )),
                                                        Positioned(
                                                          bottom: 1,
                                                          right: 1,
                                                          left: 1,
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            color:
                                                                Colors.black38,
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    15,
                                                                    5,
                                                                    10,
                                                                    8),
                                                            child: Text(
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .data[index]
                                                                  .caseTitle,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: false,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18.0),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .bottomEnd,
                                                            child: SizedBox(
                                                              width: 20,
                                                              height: 20,
                                                              child: snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .caseTypeFlag ==
                                                                      1
                                                                  ? Container(
                                                                      child: CircleAvatar(
                                                                          radius: 18,
                                                                          backgroundColor: Colors.white,
                                                                          child: ClipOval(
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images/public_icon.png',
                                                                            ),
                                                                          )),
                                                                    )
                                                                  : Container(
                                                                      child: CircleAvatar(
                                                                          radius: 18,
                                                                          backgroundColor: Colors.white,
                                                                          child: ClipOval(
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images/privateIcon.png',
                                                                            ),
                                                                          )),
                                                                    ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .topStart,
                                                          child: SizedBox(
                                                            width: 100,
                                                            height: 100,
                                                            child: snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .featuredFlag ==
                                                                    2
                                                                ? SizedBox(
                                                                    width: 100,
                                                                    height: 100,
                                                                    child:
                                                                        ClipRRect(
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/featured1.png',
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  /*Row(
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width: double.infinity,
                                                          child: Text(
                                                            '${snapshot.data.data.data[index].caseTitle}',
                                                            maxLines: 2,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            softWrap:
                                                            false,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                18.0),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: double.infinity,
                                                          child: Text(
                                                            'Posted by $postedbyName on $timeconvert',
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            softWrap:
                                                            false,
                                                            textAlign:
                                                            TextAlign
                                                                .start,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                                fontSize:
                                                                13.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),*/
                                                  /*Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(10, 10, 10, 10),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: AutoSizeText(
                                                  '${snapshot.data.data.data[index].caseDescription}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 15),
                                                  minFontSize: 15,
                                                  stepGranularity: 1,
                                                  maxLines: 5,
                                                  textAlign:
                                                  TextAlign.justify,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),*/
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: setRow(
                                                      allCaseDetailsModel
                                                          .data.data[index],
                                                      snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .caseNetworkImage,
                                                      snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .bannerImage,
                                                      snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .caseVideoImage,
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 10, 10, 10),
                                                    child: Divider(
                                                      height: 1,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          isLoadingCases
                              ? Center(
                                  child: ProgressBarLightRose(),
                                )
                              : Container(),
                        ],
                      )
                    : Column(
                        children: [
                          Flexible(
                            child: StreamBuilder(
                                stream: _homeListAllCasesBloc
                                    .allCaseSearchDetailsResp,
                                builder: (context,
                                    AsyncSnapshot<AllCaseDetailsModel>
                                        snapshot) {
                                  print(
                                      '_searchText.text   ${_searchText.text}');
                                  if (snapshot.hasData) {
                                    if (snapshot.data.status == 'error') {
                                      return noDataFound();
                                    } else if (snapshot
                                        .data.data.data.isEmpty) {
                                      return noDataFound();
                                    } else {}
                                  } else {
                                    return Center(child: ProgressBarDarkBlue());
                                  }
                                  return NotificationListener(
                                    // ignore: missing_return
                                    onNotification:
                                        (ScrollNotification scrollInfo) {
                                      if (!_homeListAllCasesBloc
                                              .paginationLoading &&
                                          scrollInfo.metrics.pixels ==
                                              scrollInfo
                                                  .metrics.maxScrollExtent) {
                                        // start loading data
                                        if (snapshot.data.data.currentPage <
                                            snapshot.data.data.totalPages) {
                                          final page =
                                              snapshot.data.data.currentPage +
                                                  1;
                                          setState(() {
                                            isLoadingCases = true;
                                          });
                                          _homeListAllCasesBloc
                                              .allCaseSearchAPI(
                                                  page: page.toString(),
                                                  sortBy: "commentCount",
                                                  searchTitle: _searchText.text
                                                      .toString());
                                        }
                                      }
                                    },

                                    child: RefreshIndicator(
                                      color: CustColors.DarkBlue,
                                      onRefresh: _pullRefresh,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: false,
                                        itemCount:
                                            snapshot.data.data.data.length,
                                        itemBuilder: (context, index) {
                                          if (snapshot.data.data.data[index]
                                              .caseDocument.isNotEmpty) {
                                            print("insideCasedoc");
                                            if (snapshot
                                                        .data
                                                        .data
                                                        .data[index]
                                                        .caseDocument[0]
                                                        .docType ==
                                                    "image/jpeg" ||
                                                snapshot
                                                        .data
                                                        .data
                                                        .data[index]
                                                        .caseDocument[0]
                                                        .docType ==
                                                    "image/jpg" ||
                                                snapshot
                                                        .data
                                                        .data
                                                        .data[index]
                                                        .caseDocument[0]
                                                        .docType ==
                                                    "image/png") {
                                              print("image/jpeg");
                                              snapshot.data.data.data[index]
                                                      .caseNetworkImage =
                                                  snapshot
                                                      .data
                                                      .data
                                                      .data[index]
                                                      .caseDocument[0]
                                                      .caseDocument
                                                      .toString();
                                              snapshot.data.data.data[index]
                                                  .bannerImage = '';
                                              snapshot.data.data.data[index]
                                                  .caseVideoImage = '';
                                            } else if (snapshot
                                                        .data
                                                        .data
                                                        .data[index]
                                                        .caseDocument[0]
                                                        .docType ==
                                                    "video/mp4" ||
                                                snapshot
                                                        .data
                                                        .data
                                                        .data[index]
                                                        .caseDocument[0]
                                                        .docType ==
                                                    "video/mov") {
                                              print("video/mp4");
                                              snapshot.data.data.data[index]
                                                      .caseVideoImage =
                                                  snapshot
                                                      .data
                                                      .data
                                                      .data[index]
                                                      .caseDocument[0]
                                                      .caseDocument
                                                      .toString();
                                              snapshot.data.data.data[index]
                                                  .caseNetworkImage = '';

// ............................... thumbnail code here ..........................

                                              if (snapshot.data.data.data[index]
                                                      .caseCategory
                                                      .toString() ==
                                                  'Human trafficking') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/casedetailsHuman.png';
                                              } else if (snapshot.data.data
                                                      .data[index].caseCategory
                                                      .toString() ==
                                                  'Corruption') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/caseDetailCorruptionBanner.png';
                                              } else if (snapshot.data.data
                                                      .data[index].caseCategory
                                                      .toString() ==
                                                  'Environment abusing') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/caseDetailEvabsu.png';
                                              } else {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/casedetailsHuman.png';
                                              }
                                            } else {
                                              if (snapshot.data.data.data[index]
                                                      .caseCategory
                                                      .toString() ==
                                                  'Human trafficking') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/casedetailsHuman.png';
                                                snapshot.data.data.data[index]
                                                    .caseNetworkImage = "";
                                                snapshot.data.data.data[index]
                                                    .caseVideoImage = "";
                                              } else if (snapshot.data.data
                                                      .data[index].caseCategory
                                                      .toString() ==
                                                  'Corruption') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/caseDetailCorruptionBanner.png';
                                                snapshot.data.data.data[index]
                                                    .caseNetworkImage = "";
                                                snapshot.data.data.data[index]
                                                    .caseVideoImage = "";
                                              } else if (snapshot.data.data
                                                      .data[index].caseCategory
                                                      .toString() ==
                                                  'Environment abusing') {
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/caseDetailEvabsu.png';
                                                snapshot.data.data.data[index]
                                                    .caseNetworkImage = "";
                                                snapshot.data.data.data[index]
                                                    .caseVideoImage = '';
                                              } else {
                                                snapshot.data.data.data[index]
                                                    .caseNetworkImage = "";
                                                snapshot.data.data.data[index]
                                                    .caseVideoImage = "";
                                                snapshot.data.data.data[index]
                                                        .bannerImage =
                                                    'assets/images/casedetailsHuman.png';
                                              }
                                            }
                                          } else {
                                            print("outsideCasedoc");
                                            if (snapshot.data.data.data[index]
                                                    .caseCategory
                                                    .toString() ==
                                                'Human trafficking') {
                                              snapshot.data.data.data[index]
                                                      .bannerImage =
                                                  'assets/images/casedetailsHuman.png';
                                              snapshot.data.data.data[index]
                                                  .caseNetworkImage = "";
                                              snapshot.data.data.data[index]
                                                  .caseVideoImage = "";
                                            } else if (snapshot.data.data
                                                    .data[index].caseCategory
                                                    .toString() ==
                                                'Corruption') {
                                              snapshot.data.data.data[index]
                                                      .bannerImage =
                                                  'assets/images/caseDetailCorruptionBanner.png';
                                              snapshot.data.data.data[index]
                                                  .caseNetworkImage = "";
                                              snapshot.data.data.data[index]
                                                  .caseVideoImage = "";
                                            } else if (snapshot.data.data
                                                    .data[index].caseCategory
                                                    .toString() ==
                                                'Environment abusing') {
                                              snapshot.data.data.data[index]
                                                      .bannerImage =
                                                  'assets/images/caseDetailEvabsu.png';
                                              snapshot.data.data.data[index]
                                                  .caseNetworkImage = "";
                                              snapshot.data.data.data[index]
                                                  .caseVideoImage = "";
                                            } else {
                                              snapshot.data.data.data[index]
                                                  .caseNetworkImage = "";
                                              snapshot.data.data.data[index]
                                                  .caseVideoImage = "";
                                              snapshot.data.data.data[index]
                                                      .bannerImage =
                                                  'assets/images/casedetailsHuman.png';
                                            }
                                          }

                                          print(
                                              '_searchText.text   ${_searchText.text}');
                                          if (snapshot.data.data.data[index]
                                              .joinedUser.isEmpty) {
                                            Joinicon =
                                                'assets/images/join_grey_icon.png';
                                            Join = 'join';
                                          } else if (snapshot
                                                  .data
                                                  .data
                                                  .data[index]
                                                  .joinedUser[0]
                                                  .status ==
                                              1) {
                                            Joinicon =
                                                'assets/images/leave_case.png';
                                            Join = 'leave';
                                          } else if (snapshot
                                                  .data
                                                  .data
                                                  .data[index]
                                                  .joinedUser[0]
                                                  .status ==
                                              0) {
                                            Joinicon =
                                                'assets/images/join_grey_icon.png';
                                            Join = 'Join';
                                          }
                                          var timeconvert =
                                              _homeListAllCasesBloc.dateconvert(
                                                  snapshot.data.data.data[index]
                                                      .createdAt
                                                      .toString());

                                          String postedbyName;

                                          if (snapshot.data.data.data[index]
                                                      .userProfile.aliasName !=
                                                  null &&
                                              snapshot.data.data.data[index]
                                                      .userProfile.aliasFlag ==
                                                  1) {
                                            postedbyName = snapshot
                                                .data
                                                .data
                                                .data[index]
                                                .userProfile
                                                .aliasName;
                                          } else {
                                            if (snapshot.data.data.data[index]
                                                    .users ==
                                                null) {
                                              postedbyName = '';
                                            } else {
                                              postedbyName = snapshot.data.data
                                                  .data[index].users.displayName
                                                  .toString();
                                            }
                                          }

                                          return ListTile(
                                            onTap: () {
                                              /// Navigate To CaseDetails
                                              var caseid = snapshot
                                                  .data.data.data[index].id;
                                              var userid = snapshot
                                                  .data.data.data[index].userId;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CaseDetailsPage(
                                                            caseId: caseid
                                                                .toString(),
                                                            userId: userid,
                                                            caseNetworkImage:
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .data[index]
                                                                    .caseNetworkImage,
                                                            bannerImage: snapshot
                                                                .data
                                                                .data
                                                                .data[index]
                                                                .bannerImage,
                                                            caseVideoImage: snapshot
                                                                .data
                                                                .data
                                                                .data[index]
                                                                .caseVideoImage,
                                                          )));
                                            },

                                            title: Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Stack(
                                                      children: [
                                                        /* Container(
                                                              child: snapshot
                                                                  .data
                                                                  .data
                                                                  .data[
                                                              index]
                                                                  .bannerImage !=
                                                                  ""
                                                                  ? Container(
                                                                  height: 250,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          5.0),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      color: Colors
                                                                          .transparent),
                                                                  child: Image.asset(
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .data[index]
                                                                          .bannerImage,
                                                                      fit: BoxFit.cover))

                                                             */ /*Container(
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                    child:  Image.asset(snapshot.data.data.data[index].bannerImage,),
                                                                ),
                                                              )*/ /*
                                                                  : CachedNetworkImage(
                                                                imageUrl: snapshot
                                                                    .data
                                                                    .data
                                                                    .data[
                                                                index]
                                                                    .caseNetworkImage,
                                                                imageBuilder:
                                                                    (context,
                                                                    imageProvider) =>
                                                                    Container(
                                                                      height:
                                                                      250,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius.circular(5.0),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        image: DecorationImage(
                                                                            image:
                                                                            imageProvider,
                                                                            fit:
                                                                            BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                //placeholder: (context, url) => ProgressBarLightRose(),
                                                              )),*/
                                                        Container(
                                                            child: snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .bannerImage !=
                                                                    ""
                                                                ? Container(
                                                                    height: 350,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5.0),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        color: Colors
                                                                            .transparent),
                                                                    child: Image.asset(
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .data[index]
                                                                            .bannerImage,
                                                                        fit: BoxFit.cover))
                                                                : CachedNetworkImage(
                                                                    imageUrl: snapshot.data.data.data[index].caseNetworkImage,
                                                                    imageBuilder: (context, imageProvider) => Container(
                                                                          height:
                                                                              350,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            image:
                                                                                DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                          ),
                                                                        ))),
                                                        Positioned(
                                                          bottom: 1,
                                                          right: 1,
                                                          left: 1,
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            color:
                                                                Colors.black38,
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    15,
                                                                    5,
                                                                    10,
                                                                    8),
                                                            child: Text(
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .data[index]
                                                                  .caseTitle,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: false,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18.0),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .bottomEnd,
                                                            child: SizedBox(
                                                              width: 20,
                                                              height: 20,
                                                              child: snapshot
                                                                          .data
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .caseTypeFlag ==
                                                                      1
                                                                  ? Container(
                                                                      child: CircleAvatar(
                                                                          radius: 18,
                                                                          backgroundColor: Colors.white,
                                                                          child: ClipOval(
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images/public_icon.png',
                                                                            ),
                                                                          )),
                                                                    )
                                                                  : Container(
                                                                      child: CircleAvatar(
                                                                          radius: 18,
                                                                          backgroundColor: Colors.white,
                                                                          child: ClipOval(
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images/privateIcon.png',
                                                                            ),
                                                                          )),
                                                                    ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .topStart,
                                                          child: SizedBox(
                                                            width: 100,
                                                            height: 100,
                                                            child: snapshot
                                                                        .data
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .featuredFlag ==
                                                                    2
                                                                ? SizedBox(
                                                                    width: 100,
                                                                    height: 100,
                                                                    child:
                                                                        ClipRRect(
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/featured1.png',
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  /*Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  width: double.infinity,
                                                                  child: Text(
                                                                    '${snapshot.data.data.data[index].caseTitle}',
                                                                    maxLines: 2,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    softWrap:
                                                                    false,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        18.0),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: double.infinity,
                                                                  child: Text('Posted by $postedbyName  $timeconvert',
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    softWrap: false,
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                        color: Colors.grey,
                                                                        fontWeight: FontWeight.normal,
                                                                        fontSize: 13.0),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),*/
                                                  /*Padding(
                                                      padding:
                                                      EdgeInsets.fromLTRB(
                                                          10, 10, 10, 10),
                                                      child: Align(
                                                        alignment:
                                                        Alignment.centerLeft,
                                                        child: AutoSizeText(
                                                          '${snapshot.data.data.data[index].caseDescription}',
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontSize: 15),
                                                          minFontSize: 15,
                                                          stepGranularity: 1,
                                                          maxLines: 5,
                                                          textAlign:
                                                          TextAlign.justify,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),*/
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: setRow(
                                                      allCaseDetailsModel
                                                          .data.data[index],
                                                      snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .caseNetworkImage,
                                                      snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .bannerImage,
                                                      snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .caseVideoImage,
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 10, 10, 10),
                                                    child: Divider(
                                                      height: 1,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // onTap: () =>pubDetails(snapshot.data.data[index]),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          isLoadingCases
                              ? Center(
                                  child: ProgressBarLightRose(),
                                )
                              : Container(),
                        ],
                      ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  child: SizedBox(
                      width: 110,
                      height: 110,
                      child: Image.asset('assets/images/add_case_icon.png',
                          width: 110, height: 110)),
                  onTap: () {
                    /// Navigate to Add A Case Page

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCaseCategoryPage()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: Visibility(
                    visible: visible,
                    child: Center(
                      child: Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 30),
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                CustColors.DarkBlue),
                          )),
                    )),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Future<void> _pullRefresh() async {
    setState(() {
      print('refreshing random stocks...');
      var list = ['id', 'rankCount', 'featuredFlag', 'commentCount', 'All'];
      final _random = Random();
      var element = list[_random.nextInt(list.length)];
      print(element);
      getCurrentLocation(LocationAccuracy.low);
      _homeListAllCasesBloc.allCaseAPI(page: "0", sortBy: "id");

      elementRandomFilter = element.toString();
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
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
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text('No Data Found',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: Colors.blueGrey)),
                )
              ],
            ),
          ),
        ),
      ),
    );
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

  dateconverter(format) {
    var parsedDate = DateTime.parse(format);
    return parsedDate;
  }

  Future loadData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      userDisplayName =
          (sharedPrefs.getString(SharedPrefKey.USER_NAME).toString());
    });
  }

  void listenApiCall() {
    _homeListAllCasesBloc.allCaseDetailsRespStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visible = false;
          isLoadingCases = false;
        });
        allCaseDetailsModel = data;
        if (allCaseDetailsModel.data.data.isNotEmpty) {
          for (int i = 0; i <= allCaseDetailsModel.data.data.length; i++) {
            if (allCaseDetailsModel.data.data[i].rankCase.isNotEmpty) {
              if (allCaseDetailsModel.data.data[i].rankCase[0].status == 1) {
                allCaseDetailsModel.data.data[i].isUpVote = true;
              } else {
                allCaseDetailsModel.data.data[i].isUpVote = false;
              }
              if (allCaseDetailsModel.data.data[i].rankCase[0].status == 2) {
                allCaseDetailsModel.data.data[i].isDownVote = true;
              } else {
                allCaseDetailsModel.data.data[i].isDownVote = false;
              }
            }
          }
        }
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
          isLoadingCases = false;
        });
      }
    });
    _homeListAllCasesBloc.LatLngResponse.listen((data) {
      if ((data.status == "success")) {
        print(data.status);
      } else if ((data.status == "error")) {
        print(data.status);
      }
    });
    _homeListAllCasesBloc.getUserDetailsStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          if (data.data.loginType == 2) {
            if (userDisplayName != null) {
              userDisplayName = data.data.username.toString();
            } else {
              userDisplayName = "";
            }
          } else {
            if (data.data.userProfile.isNotEmpty) {
              if (data.data.userProfile[0].displayName != null) {
                userDisplayName =
                    data.data.userProfile[0].displayName.toString();
              } else {
                userDisplayName = "";
              }
            }
          }

          if (data.data.userProfile.isNotEmpty) {
            if (data.data.userProfile[0].profilePic != null) {
              userProfilePic = data.data.userProfile[0].profilePic;
            } else {
              userProfilePic = "";
            }
          }
        });
      } else if ((data.status == "error")) {}
    });
    bloc.rank.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          //  _homeListAllCasesBloc.allCaseAPI(page: "0", sortBy: "commentCount");
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });
    bloc.rankCaseDown.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          // _homeListAllCasesBloc.allCaseAPI(page: "0", sortBy: "commentCount");
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });
    bloc.shareStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          toastMsg(data.message);
        });
      } else if ((data.status == "error")) {
        toastMsg(data.message);
      }
    });

    _homeListAllCasesBloc.allCaseSearchDetailsRespStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visible = false;
          isLoadingCases = false;
        });
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
          isLoadingCases = false;
        });
      }
    });
  }

  setRow(Datum data, String caseNetworkImage, String bannerImage,
      String caseVideoImage) {
    /*if(data.rankCase.length!=0){
      for (int i = 0; i <=data.rankCase.length; i++) {
        if (data.rankCase[0].status == 1) {
          data.isUpVote = true;
        } else {
          data.isUpVote = false;
        }
        if (data.rankCase[0].status == 2) {
          data.isDownVote = true;
        } else {
          data.isDownVote  = false;
        }
      }
    }*/

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Row(
              children: [
                InkWell(
                  child: data.isDownVote
                      ? Image.asset('assets/images/coloredDown.png',
                          width: 16, height: 16)
                      : Image.asset('assets/images/vote_down_icon.png',
                          width: 16, height: 16),
                  onTap: () {
                    if (data.isDownVote) {
                      toastMsg('Already Ranked');
                    } else {
                      setState(() {
                        if (data.isDownVote == false &&
                            data.isUpVote == false) {
                          data.rankCount = data.rankCount - 1;
                        } else {
                          data.rankCount = data.rankCount - 2;
                        }

                        data.isDownVote = true;
                        data.isUpVote = false;
                      });
                      bloc.rankDown(
                        data.id.toString(),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      '${data.rankCount}',
                      style:
                          const TextStyle(color: Colors.blueGrey, fontSize: 10),
                      minFontSize: 10,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                InkWell(
                  child: data.isUpVote
                      ? Image.asset('assets/images/coloredUp.png',
                          width: 16, height: 16)
                      : Image.asset('assets/images/vote_up_icon.png',
                          width: 16, height: 16),
                  onTap: () {
                    if (data.isUpVote) {
                      toastMsg('Already Ranked');
                    } else {
                      setState(() {
                        if (data.isDownVote == false &&
                            data.isUpVote == false) {
                          data.rankCount = data.rankCount + 1;
                        } else {
                          data.rankCount = data.rankCount + 2;
                        }
                        data.isUpVote = true;
                        data.isDownVote = false;
                      });
                      bloc.rankUp(data.id.toString());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            alignment: Alignment.center,
            width: double.infinity,
            child: InkWell(
              onTap: () {
                /// Navigate To CaseDetails
                var caseid = data.id;
                var userid = data.userId;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CaseDetailsPage(
                              caseId: caseid.toString(),
                              userId: userid,
                              caseNetworkImage: caseNetworkImage,
                              bannerImage: bannerImage,
                              caseVideoImage: caseVideoImage,
                            )));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Image.asset('assets/images/commenticonsmall.png',
                        width: 17, height: 17),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        '${data.commentCount}',
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 10),
                        minFontSize: 10,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Share Case"),
                      content: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Image.asset(
                                  'assets/images/mobile-phone.png',
                                  width: 70,
                                  height: 70),
                              onTap: () {
                                bloc.shareCase(data.id.toString());

                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Image.asset(
                                  'assets/images/social-media.png',
                                  width: 70,
                                  height: 70),
                              onTap: () {
                                urlFileShare(data);
                                Navigator.pop(context);
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
                    title: new Text("Share Case"),
                    content: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Image.asset('assets/images/mobile-phone.png',
                                width: 70, height: 70),
                            onTap: () {
                              bloc.shareCase(data.id.toString());

                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Image.asset('assets/images/social-media.png',
                                width: 70, height: 70),
                            onTap: () {
                              urlFileShare(data);
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ));*/
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Image.asset('assets/images/shareiconsmall.png',
                        width: 18, height: 18),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        'Share',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 10),
                        minFontSize: 10,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              /// Navigate To CaseDetails
              var caseid = data.id;
              var userid = data.userId;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CaseDetailsPage(
                            caseId: caseid.toString(),
                            userId: userid,
                            caseNetworkImage: caseNetworkImage,
                            bannerImage: bannerImage,
                            caseVideoImage: caseVideoImage,
                          )));
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: InkWell(
                      child: Image.asset(Joinicon, width: 18, height: 18),
                      onTap: () {
                        Join = "leave";
                        setState(() {
                          //  Join = 'assets/images/leave_case.png';
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        Join,
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 10),
                        minFontSize: 10,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void toastMsg(String s) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(s),
      duration: const Duration(seconds: 1),
    ));
  }

  Future<void> urlFileShare(Datum data) async {
    final RenderBox box = context.findRenderObject();
    // imagePaths.add(_caseDetailsModel.data.image[0].caseDocument);
    // if (imagePaths.isEmpty) {

    /* await Share.shareFiles(imagePaths,
          text: 'text',
          subject: 'subject',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);*/
    await Share.share(
        "1 Voices"
                "                                            "
                "                                            " +
            data.caseTitle +
            " Visit: " +
            "https://www.1voices.com/cases/${data.id}",
        subject: "                                            " +
            data.caseTitle +
            "                                            " +
            data.caseDescription,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void callBackToScreen() async {
    final addressMapModel = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CountryStateFilterPage()));
    filterCountry = addressMapModel.country;
    filterState = addressMapModel.state;
    print(addressMapModel.country);
    if (filterCountry != '' || filterState != '') {
      _homeListAllCasesBloc.CountryFilterAPI(
        page: "0",
        sortBy: "id",
        filterCountry: filterCountry,
        filterState: filterState,
      );
    }
  }

  Future<void> showAlert() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool banneradcool = prefs.getBool(SharedPrefKey.BANNERAD);
    print('bannerad showAlert $banneradcool');

    if (banneradcool == true) {
      prefs.setBool(SharedPrefKey.BANNERAD, false);
      Timer.run(() {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                insetPadding: const EdgeInsets.all(1),
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: setBanner(),
              );
            });
      });
    }
  }

  Widget displayProfilePic(String displayName) {
    String text = displayName.substring(0, 1);
    return CircularProfileAvatar(
      '',
      radius: 100, // sets radius, default 50.0
      backgroundColor:
          Colors.transparent, // sets background color, default Colors.white
      borderWidth: 10, // sets border, default 0.0
      initialsText: Text(
        text.toUpperCase(),
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ), // sets initials text, set your own style, default Text('')
      borderColor:
          CustColors.DarkBlue, // sets border color, default Colors.white
      elevation:
          5.0, // sets elevation (shadow of the profile picture), default value is 0.0
      //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
      cacheImage: true, // allow widget to cache image against provided url
      onTap: () {}, // sets on tap
      showInitialTextAbovePicture:
          true, // setting it true will show initials text above profile picture, default false
    );
  }

  Widget displayProfilePicWhite(String displayName) {
    String text = '';
    // if (displayName != "" || displayName != null) {
    //   text = displayName.substring(0, 1);
    // }
    if (displayName.isNotEmpty) {
      text = displayName.substring(0, 1);
    }

    return CircularProfileAvatar(
      '',
      radius: 80, // sets radius, default 50.0
      backgroundColor:
          Colors.transparent, // sets background color, default Colors.white
      borderWidth: 10, // sets border, default 0.0
      initialsText: Text(
        text.toUpperCase(),
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ), // sets initials text, set your own style, default Text('')
      borderColor: Colors.white, // sets border color, default Colors.white
      elevation:
          5.0, // sets elevation (shadow of the profile picture), default value is 0.0
      //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
      cacheImage: true, // allow widget to cache image against provided url
      onTap: () {}, // sets on tap
      showInitialTextAbovePicture:
          true, // setting it true will show initials text above profile picture, default false
    );
  }

  setBanner() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CardListPage('', '0', '')));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: [
              Image.asset(
                "assets/images/giftbgAlertHome.png",
                fit: BoxFit.fill,
              ),
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: RichText(
                maxLines: 2,
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "\$10000",
                      style: Styles.textHomePageAlertText00Blue25,
                    ),
                    TextSpan(
                      text: ' Grand prize',
                      style: Styles.textHomePageAlertText1Blue25,
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 20),
              child: Text(
                'For the most impactful case resolution',
                textAlign: TextAlign.center,
                style: Styles.textHomePageAlertText0Blue25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.requestPermission();
    var token = await _firebaseMessaging.getToken();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fcm = prefs.getString(SharedPrefKey.FCM_TOKEN);
    String oldfcm = prefs.getString(SharedPrefKey.OLD_FCM_TOKEN);

    // print("fcm ID: " + fcm);
    // print("oldfcm ID: " + oldfcm);
    // print("Instance ID: " + token);

    if (fcm == null || fcm == '') {
      prefs.setString(SharedPrefKey.FCM_TOKEN, token);
      bloc.updateFcm(token);
    }
    if (token != oldfcm) {
      bloc.updateFcm(token);
    }
  }
}

class Item {
  const Item(this.name);

  final String name;
}
