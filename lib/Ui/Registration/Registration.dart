import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Ui/BecomeProUser/BecomeProUserPage.dart';
import 'package:bring2book/Ui/base/CustomRadioWidget.dart';
import 'package:bring2book/Ui/Registration/RegistrationBloc.dart';
import 'package:bring2book/Ui/SignInScreen/SignInActivity.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:bring2book/Ui/LandingPage/MainLandingPage.dart';
import '../../Constants/colorConstants.dart';
import '../base/baseWidgets.dart';
import 'package:android_intent/android_intent.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:bring2book/Models/StateListModel/StateListModel.dart';
import 'package:bring2book/Ui/AddCase/AddCaseBloc.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Models/CountryListModel/CountryListModel.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<RegistrationPage> {
  // Default Radio Button Selected Item When App Starts.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RegistrationBloc _bloc = RegistrationBloc();
  final AddCaseBloc _addCaseBloc = AddCaseBloc();

  final CheckInternet _checkInternet = CheckInternet();
  String radioButtonItem = 'Male';
  TextEditingController name = TextEditingController();
  TextEditingController aliasName = TextEditingController();
  TextEditingController countrySelection = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController confrmPassword = TextEditingController();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController CountryCase = TextEditingController();
  TextEditingController StateCase = TextEditingController();
  String countryId;

  bool isCountryCodeSelected = false;
  String countrycode;

  StateSetter mycountry1, mystate1;

  bool isLoadingCountry = false;
  bool isLoadingState = false;

  TextEditingController aboutMe = TextEditingController();

  bool visibility = false;
  // Group Value for Radio Button.
  int id = 1;
  String signUp = 'Who are you?';
  String aliasFlag = '2';
  bool checkBoxValue = false;
  bool checkBoxAliasValue = false;

  final geolocator = GeolocatorPlatform.instance;
  Position currentPosition;
  String _currentAddress;
  String currentLat = "";
  String currentState = "";
  String currentLong = "";

  bool visibleError = false;

  @override
  void initState() {
    super.initState();

    getCurrentLocation(LocationAccuracy.low);

    _addCaseBloc.CountryListAPI(page: "0", searchTitle: '');
    _bloc.validateRegistrationStream.listen((event) {
      print('event is got $event');
      setState(() {
        visibility = false;
      });
      toastMsg(event);
    });
    listen();
  }

  @override
  void didUpdateWidget(RegistrationPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    listen();
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
            locationSettings: LocationSettings(accuracy: accuracy))
        .then((Position position) {
      print("555555555555555555getCurrentLocation Success");
      currentPosition = position;

      currentLat = currentPosition.latitude.toString();
      currentLong = currentPosition.longitude.toString();

      print(currentLat);
      print(currentLong);
      print("currentLatcurrentLatcurrentLatcurrentLatcurrentLatcurrentLat");
      _bloc.performUpdateLatLng(currentLat, currentLong);
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
        //     "${place.locality}, ${place.postalCode}, ${place.country}";

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

  @override
  Widget build(BuildContext context) {
    bool _isChecked = true;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            ListView(
              children: [
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
                  padding: const EdgeInsets.only(
                    left: 25,
                  ),
                  child: Text(
                    signUp,
                    style: const TextStyle(
                      color: CustColors.DarkBlue,
                      fontSize: 26.0,
                    ),
                  ),
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
                      'Use Aliases instead of name',
                      style:
                          TextStyle(fontSize: 17.0, color: CustColors.DarkBlue),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFieldWidgetSignUpMandatory(
                    controller: emailId,
                    textInputType: TextInputType.emailAddress,
                    height: 50,
                    width: double.infinity,
                    backgroundColor: CustColors.LightRose,
                    alignment: TextAlign.start,
                    hintText: "Email ID",
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Select Country"),
                            content: StatefulBuilder(builder:
                                (BuildContext context, StateSetter mycountry) {
                              mycountry1 = mycountry;
                              return SizedBox(
                                width: double.maxFinite,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 10),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: CustColors.LightRose,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 5, 0),
                                                width: double.infinity,
                                                child: TextFormField(
                                                  onChanged: (text) {
                                                    _addCaseBloc.CountryListAPI(
                                                        page: '0',
                                                        searchTitle: text);
                                                  },
                                                  textAlign: TextAlign.left,
                                                  decoration:
                                                      const InputDecoration(
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
                                          stream:
                                              _addCaseBloc.countryListStream,
                                          builder: (context,
                                              AsyncSnapshot<CountryListModel>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                    ConnectionState.waiting ||
                                                snapshot.connectionState ==
                                                    ConnectionState.none) {
                                              return Center(
                                                  child:
                                                      ProgressBarLightRose());
                                            } else if (snapshot.hasData ||
                                                snapshot.data.data.data
                                                    .isNotEmpty) {
                                              if (snapshot.data.status ==
                                                  'error') {
                                                return noDataFound();
                                              } else if (snapshot
                                                  .data.data.data.isEmpty) {
                                                return noDataFound();
                                              }
                                            } else {
                                              return Center(
                                                  child: ProgressBarDarkBlue());
                                            }
                                            return NotificationListener(
                                              // ignore: missing_return
                                              onNotification:
                                                  (ScrollNotification
                                                      scrollInfo) {
                                                if (!_addCaseBloc
                                                        .paginationLoading &&
                                                    scrollInfo.metrics.pixels ==
                                                        scrollInfo.metrics
                                                            .maxScrollExtent) {
                                                  // start loading data
                                                  if (snapshot.data.data
                                                          .currentPage <
                                                      snapshot.data.data
                                                          .totalPages) {
                                                    final page = snapshot.data
                                                            .data.currentPage +
                                                        1;
                                                    mycountry1(() {
                                                      isLoadingCountry = true;
                                                    });
                                                    _addCaseBloc.CountryListAPI(
                                                        page: page.toString(),
                                                        searchTitle: '');
                                                  }
                                                }
                                              },

                                              child: ListView.builder(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: snapshot
                                                    .data.data.data.length,
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
                                                      countryId = snapshot.data
                                                          .data.data[index].id
                                                          .toString();
                                                      var name = snapshot
                                                          .data
                                                          .data
                                                          .data[index]
                                                          .name;
                                                      print(countryId);
                                                      print(name);
                                                      _addCaseBloc.StateListAPI(
                                                          page: "0",
                                                          searchTitle: '',
                                                          countryId: countryId
                                                              .toString());
                                                      setState(() {
                                                        StateCase.text = '';
                                                        CountryCase.text = name;
                                                      });

                                                      Navigator.pop(context);
                                                    },
                                                    title: Container(
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    10,
                                                                    0,
                                                                    10),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child:
                                                                  AutoSizeText(
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .data[index]
                                                                    .name,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        13),
                                                                minFontSize: 10,
                                                                stepGranularity:
                                                                    1,
                                                                maxLines: 4,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 3, 5, 3),
                                                            child: Divider(
                                                              height: 1,
                                                              color: Colors
                                                                  .white54,
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

                    /*showDialog(
                        context: context,
                        child: new AlertDialog(
                          title: new Text("Select Country"),
                          content: StatefulBuilder(
                            builder: (BuildContext context, StateSetter mycountry) {
                              mycountry1 = mycountry;
                              return  Container(
                                width: double.maxFinite,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: CustColors.LightRose,
                                            borderRadius: BorderRadius.all(Radius.circular(5))),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                                width: double.infinity,
                                                child: TextFormField(
                                                  onChanged: (text) {
                                                    _addCaseBloc.CountryListAPI( page: '0', searchTitle: text);
                                                  },
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Search",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width: double.infinity,
                                                child: Image.asset('assets/images/rosesearch.png',
                                                    width: 20, height: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: StreamBuilder(
                                          stream: _addCaseBloc.countryListStream,
                                          builder: (context, AsyncSnapshot<CountryListModel> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting ||
                                                snapshot.connectionState == ConnectionState.none) {
                                              return Center(child: ProgressBarLightRose());
                                            } else
                                            if (snapshot.hasData ||
                                                snapshot.data.data.data.length != 0) {
                                              if (snapshot.data.status == 'error') {
                                                return noDataFound();
                                              } else if (snapshot.data.data.data.length == 0) {
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
                                                    final page = snapshot.data.data.currentPage + 1;
                                                    mycountry1(() {
                                                      isLoadingCountry = true;
                                                    });
                                                    _addCaseBloc.CountryListAPI( page: page.toString(), searchTitle: '');
                                                  }
                                                }
                                              },

                                              child: ListView.builder(
                                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: snapshot.data.data.data.length,
                                                itemBuilder: (context, index) {
                                                  */ /*if ((index+1) == snapshot.data.data.data.length ) {//pagination loader
                                                              return Container(
                                                                padding: EdgeInsets.only(bottom: 10),
                                                                child: snapshot.data.data.currentPage +1 < snapshot.data.data.totalPages
                                                                    ? Center(child: ProgressBarDarkBlue(),) :  Container(),
                                                              );
                                                            }*/ /*

                                                  return ListTile(
                                                    onTap: () {
                                                      /// Navigate To CaseDetails
                                                      countryId = snapshot.data.data.data[index].id.toString();
                                                      var name = snapshot.data.data.data[index].name;
                                                      print(countryId);
                                                      print(name);
                                                      _addCaseBloc.StateListAPI( page: "0", searchTitle: '', countryId: countryId.toString());
                                                      setState(() {
                                                        StateCase.text='';
                                                        CountryCase.text=name;
                                                      });

                                                      Navigator.pop(context);
                                                    },
                                                    title: Container(
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                            child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: AutoSizeText(
                                                                '${snapshot.data.data.data[index].name}',
                                                                style: TextStyle(
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
                                                          Padding(
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
                                      child: ProgressBarLightRose(),)
                                        : Container(),
                                  ],
                                ),
                              );
                            }
                          ),
                        ));*/
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
                              controller: CountryCase,
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
                  visible: CountryCase.text == '' || CountryCase.text.isEmpty
                      ? false
                      : true,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Select State"),
                              content: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter mystate) {
                                mystate1 = mystate;
                                return SizedBox(
                                  width: double.maxFinite,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 5, 10),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: CustColors.LightRose,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 5, 0),
                                                  width: double.infinity,
                                                  child: TextFormField(
                                                    onChanged: (text) {
                                                      _addCaseBloc.StateListAPI(
                                                          page: "0",
                                                          searchTitle: text,
                                                          countryId: countryId);
                                                    },
                                                    textAlign: TextAlign.left,
                                                    decoration:
                                                        const InputDecoration(
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
                                            stream:
                                                _addCaseBloc.stateListStream,
                                            builder: (context,
                                                AsyncSnapshot<StateListModel>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                      ConnectionState.waiting ||
                                                  snapshot.connectionState ==
                                                      ConnectionState.none) {
                                                return Center(
                                                    child:
                                                        ProgressBarLightRose());
                                              } else if (snapshot.hasData ||
                                                  snapshot.data.data.data
                                                      .isNotEmpty) {
                                                if (snapshot.data.status ==
                                                    'error') {
                                                  return noDataFound();
                                                } else if (snapshot
                                                    .data.data.data.isEmpty) {
                                                  return noDataFound();
                                                }
                                              } else {
                                                return Center(
                                                    child:
                                                        ProgressBarDarkBlue());
                                              }
                                              return NotificationListener(
                                                // ignore: missing_return
                                                onNotification:
                                                    (ScrollNotification
                                                        scrollInfo) {
                                                  if (!_addCaseBloc
                                                          .paginationLoading &&
                                                      scrollInfo
                                                              .metrics.pixels ==
                                                          scrollInfo.metrics
                                                              .maxScrollExtent) {
                                                    // start loading data
                                                    if (snapshot.data.data
                                                            .currentPage <
                                                        snapshot.data.data
                                                            .totalPages) {
                                                      final page = snapshot
                                                              .data
                                                              .data
                                                              .currentPage +
                                                          1;
                                                      mystate1(() {
                                                        isLoadingState = true;
                                                      });
                                                      _addCaseBloc.StateListAPI(
                                                          page: page.toString(),
                                                          searchTitle: '',
                                                          countryId: countryId);
                                                    }
                                                  }
                                                },

                                                child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount: snapshot
                                                      .data.data.data.length,
                                                  itemBuilder:
                                                      (context, index) {
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
                                                        var countryId = snapshot
                                                            .data
                                                            .data
                                                            .data[index]
                                                            .countryId;
                                                        var name = snapshot
                                                            .data
                                                            .data
                                                            .data[index]
                                                            .name;
                                                        print(countryId);
                                                        print(name);
                                                        StateCase.text = name;
                                                        Navigator.pop(context);
                                                      },
                                                      title: Container(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child:
                                                                    AutoSizeText(
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .name,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          13),
                                                                  minFontSize:
                                                                      10,
                                                                  stepGranularity:
                                                                      1,
                                                                  maxLines: 4,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .justify,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          5,
                                                                          3,
                                                                          5,
                                                                          3),
                                                              child: Divider(
                                                                height: 1,
                                                                color: Colors
                                                                    .white54,
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
                                      isLoadingState
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

                      /*showDialog(
                          context: context,
                          child: new AlertDialog(
                            title: new Text("Select State"),
                            content: StatefulBuilder(
                                builder: (BuildContext context, StateSetter mystate) {
                                  mystate1 = mystate;
                                return Container(
                                  width: double.maxFinite,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: CustColors.LightRose,
                                              borderRadius: BorderRadius.all(Radius.circular(5))),
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                                  width: double.infinity,
                                                  child: TextFormField(
                                                    onChanged: (text) {
                                                      _addCaseBloc.StateListAPI( page: "0", searchTitle: text, countryId:  countryId);
                                                    },
                                                    textAlign: TextAlign.left,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Search",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Image.asset('assets/images/rosesearch.png',
                                                      width: 20, height: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: StreamBuilder(
                                            stream: _addCaseBloc.stateListStream,
                                            builder: (context, AsyncSnapshot<StateListModel> snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting ||
                                                  snapshot.connectionState == ConnectionState.none) {
                                                return Center(child: ProgressBarLightRose());
                                              } else
                                              if (snapshot.hasData ||
                                                  snapshot.data.data.data.length != 0) {
                                                if (snapshot.data.status == 'error') {
                                                  return noDataFound();
                                                } else if (snapshot.data.data.data.length == 0) {
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
                                                      final page = snapshot.data.data.currentPage + 1;
                                                      mystate1(() {
                                                        isLoadingState = true;
                                                      });
                                                      _addCaseBloc.StateListAPI( page: page.toString(), searchTitle: '', countryId: countryId);
                                                    }
                                                  }
                                                },

                                                child: ListView.builder(
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  scrollDirection: Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data.data.data.length,
                                                  itemBuilder: (context, index) {
                                                    */ /*if ((index+1) == snapshot.data.data.data.length ) {//pagination loader
                                                                return Container(
                                                                  padding: EdgeInsets.only(bottom: 10),
                                                                  child: snapshot.data.data.currentPage +1 < snapshot.data.data.totalPages
                                                                      ? Center(child: ProgressBarDarkBlue(),) :  Container(),
                                                                );
                                                              }*/ /*

                                                    return ListTile(
                                                      onTap: () {
                                                        /// Navigate To CaseDetails
                                                        var countryId = snapshot.data.data.data[index].countryId;
                                                        var name = snapshot.data.data.data[index].name;
                                                        print(countryId);
                                                        print(name);
                                                        StateCase.text=name;
                                                        Navigator.pop(context);
                                                      },
                                                      title: Container(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                              child: Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: AutoSizeText(
                                                                  '${snapshot.data.data.data[index].name}',
                                                                  style: TextStyle(
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
                                                            Padding(
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
                                      isLoadingState
                                          ? Center(child: ProgressBarLightRose(),)
                                          : Container(),
                                    ],
                                  ),
                                );
                              }
                            ),
                          ));*/
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                                controller: StateCase,
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
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
                            // if you need custome picker use this
                            pickerBuilder: (context, CountryCode countryCode) {
                              countrySelection.text =
                                  countryCode.dialCode.toString();
                              return Container(
                                height: 50,
                                color: CustColors.LightRose,
                                child: Center(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 0, top: 0),
                                        height: 30,
                                        width: 40,
                                        decoration:
                                            const BoxDecoration(boxShadow: [
                                          BoxShadow(color: CustColors.LightRose)
                                        ]),
                                        child: Image.asset(
                                          countryCode.flagUri,
                                          package: 'country_list_pick',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: TextFieldWidgetProfileEmail(
                                          controller: countrySelection,
                                          textInputType: TextInputType.text,
                                          height: 50,
                                          enabled: false,
                                          maxLines: 1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              131,
                                          labelText: countryCode.dialCode,
                                          backgroundColor: CustColors.LightRose,
                                          alignment: TextAlign.start,
                                          hintText: "Country",
                                        ),
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
                            initialSelection: '+91',
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
                  padding: const EdgeInsets.only(top: 15),
                  child: TextFieldWidgetSignUpMandatory(
                    controller: phone,
                    textInputType: TextInputType.phone,
                    height: 50,
                    width: double.infinity,
                    backgroundColor: CustColors.LightRose,
                    alignment: TextAlign.start,
                    hintText: "Phone Number",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
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
                          style:
                              TextStyle(fontSize: 17.0, color: CustColors.Grey),
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
                          style:
                              TextStyle(fontSize: 17.0, color: CustColors.Grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFieldWidgetMandatoryPwd(
                    textInputType: TextInputType.visiblePassword,
                    controller: password,
                    obscureText: true,
                    height: 50,
                    width: double.infinity,
                    backgroundColor: CustColors.LightRose,
                    alignment: TextAlign.start,
                    hintText: "Password",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFieldWidgetMandatoryPwd(
                    textInputType: TextInputType.visiblePassword,
                    controller: confrmPassword,
                    height: 50,
                    obscureText: true,
                    width: double.infinity,
                    backgroundColor: CustColors.LightRose,
                    alignment: TextAlign.start,
                    hintText: "Confirm Password",
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Checkbox(
                        value: checkBoxValue,
                        onChanged: (bool value) {
                          print(value);
                          setState(() {
                            checkBoxValue = value;
                          });
                        },
                        activeColor: CustColors.Radio,
                      ),
                    ),
                    const Text(
                      'Become a Pro User',
                      style:
                          TextStyle(fontSize: 17.0, color: CustColors.DarkBlue),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SubmitButtonWidget(
                    height: 50,
                    width: double.infinity,
                    backgroundColor: CustColors.DarkBlue,
                    buttonText: "Sign Up",
                    buttonTextColor: Colors.white,
                    onpressed: () {
                      setState(() {
                        visibility = true;
                      });
                      _checkInternet.check().then((intenet) {
                        if (intenet != null && intenet) {
                          if (checkBoxAliasValue) {
                            aliasFlag = '1';
                          } else {
                            aliasFlag = '2';
                          }
                          // Internet Present Case
                          _bloc.initiateRegistrationValues(
                            latitude: currentLat,
                            longitude: currentLong,
                            country: CountryCase.text,
                            state: StateCase.text,
                            countryCode: countrySelection.text,
                            firstName: firstName.text.toString(),
                            lastName: lastName.text.toString(),
                            password: password.text.toString(),
                            phoneNo: phone.text.toString(),
                            email: emailId.text.toString(),
                            confrmPassword: confrmPassword.text.toString(),
                            radioButtonItem: radioButtonItem,
                            aliasName: aliasName.text.toString(),
                            aliasFlag: aliasFlag.toString(),
                            aboutMe: aboutMe.text.toString(),
                          );
                        } else {
                          toastMsg('No internet connection');
                        }
                      });

                      print(' Sign Up');
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: visibility,
              child: Container(
                color: Colors.transparent,
                child: const Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(CustColors.DarkBlue)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toastMsg(event) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(event),
      duration: const Duration(seconds: 2),
    ));
  }

  void listen() {
    print("Normal Register========");
    _bloc.loginStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visibility = false;
        });

        toastMsg(
            "Registration Completed Successfully...A conformation email has been sent to ${emailId.text.toString()}. Click on the confirmation link on the email to activate your account");
        Future.delayed(const Duration(seconds: 2)).then((_) {
          if (checkBoxValue) {
            _bloc.saveUserData(data);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => BecomeProUserPage()));
          } else {
            _bloc.saveUserData(data);
            Future.delayed(const Duration(seconds: 1)).then((_) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MainLandingPage(frompage: "0")),
                  ModalRoute.withName("/MainLandingPage"));
            });
            /* Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignInActivity()));*/
          }
        });
        toastMsg("Success");
        /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()));*/
      } else if ((data.status == "error")) {
        setState(() {
          visibility = false;
        });
        print("error ");
        String msg = data.message;
        toastMsg(msg);
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
