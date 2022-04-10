import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Ui/AddCase/UploadCaseDocuments.dart';
import 'package:bring2book/Models/StateListModel/StateListModel.dart';
import 'package:bring2book/Ui/AddCase/AddCaseBloc.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bring2book/Models/CountryListModel/CountryListModel.dart';

class AddCasePage extends StatefulWidget {
  final String caseTypeFlag, caseCategory;

  const AddCasePage({this.caseTypeFlag, this.caseCategory});

  @override
  _State createState() => _State();
}

class _State extends State<AddCasePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AddCaseBloc _addCaseBloc = AddCaseBloc();

  TextEditingController caseTitle = TextEditingController();
  TextEditingController caseDescription = TextEditingController();

  TextEditingController CountryCase = TextEditingController();
  TextEditingController StateCase = TextEditingController();

  int charLength = 0;

  String text = ' ';
  bool visibility = true;

  String countryId;

  StateSetter mycountry1, mystate1;
  bool isLoadingCountry = false;
  bool isLoadingState = false;

  @override
  void initState() {
    super.initState();
    _addCaseBloc.CountryListAPI(page: "0", searchTitle: '');

    print(
        'caseTypeFlag ${widget.caseTypeFlag}  caseCategory ${widget.caseCategory} ');

    listenApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
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
                        Navigator.of(context).pop(null);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 30),
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
                      padding:
                          EdgeInsets.only(left: 10.0, right: 30.0, top: 30),
                      child: Text(
                        "Log a Case",
                        style: TextStyle(
                          color: CustColors.DarkBlue,
                          fontSize: 18.0,
                          fontFamily: 'Formular',
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            color: Colors.red,
                            width: 60,
                            height: 58,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              color: Colors.white,
                              height: 58,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                reverse: true,
                                child: SizedBox(
                                  height: 58.0,
                                  child: TextField(
                                    controller: caseTitle,
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.TextGray,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          color: CustColors.TextGray,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      hintText: 'Title',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            color: Colors.red,
                            width: 60,
                            height: 130,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              height: 130,
                              color: Colors.white,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 150.0,
                                ),
                                child: Scrollbar(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: SizedBox(
                                      height: 130.0,
                                      child: TextField(
                                        onChanged: _onChanged,
                                        controller: caseDescription,
                                        maxLines: 2000,
                                        decoration: InputDecoration(
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: CustColors.TextGray,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(
                                              color: CustColors.TextGray,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          hintText: 'Description',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AutoSizeText(
                        '$charLength of 300 characters used',
                        style: const TextStyle(color: Colors.grey, fontSize: 8),
                        minFontSize: 10,
                        stepGranularity: 1,
                        maxLines: 1,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                                  (BuildContext context,
                                      StateSetter mycountry) {
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
                                                      _addCaseBloc
                                                          .CountryListAPI(
                                                              page: '0',
                                                              searchTitle:
                                                                  text);
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
                                                      mycountry1(() {
                                                        isLoadingCountry = true;
                                                      });
                                                      _addCaseBloc
                                                          .CountryListAPI(
                                                              page: page
                                                                  .toString(),
                                                              searchTitle: '');
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
                                                        countryId = snapshot
                                                            .data
                                                            .data
                                                            .data[index]
                                                            .id
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
                                                          CountryCase.text =
                                                              name;
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
                              child: Container(
                                color: Colors.white,
                                child: TextField(
                                  controller: CountryCase,
                                  textAlign: TextAlign.left,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10.0),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: CustColors.TextGray,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: CustColors.TextGray,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    hintText: 'Select your Country',
                                  ),
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
                                    (BuildContext context,
                                        StateSetter mystate) {
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 5, 0),
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      onChanged: (text) {
                                                        _addCaseBloc
                                                            .StateListAPI(
                                                                page: "0",
                                                                searchTitle:
                                                                    text,
                                                                countryId:
                                                                    countryId);
                                                      },
                                                      textAlign: TextAlign.left,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
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
                                                        ConnectionState
                                                            .waiting ||
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
                                                        scrollInfo.metrics
                                                                .pixels ==
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
                                                        _addCaseBloc
                                                            .StateListAPI(
                                                                page: page
                                                                    .toString(),
                                                                searchTitle: '',
                                                                countryId:
                                                                    countryId);
                                                      }
                                                    }
                                                  },

                                                  child: ListView.builder(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
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
                                                          var countryId =
                                                              snapshot
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
                                                          Navigator.pop(
                                                              context);
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
                                                                  alignment:
                                                                      Alignment
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
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                                child: Container(
                                  color: Colors.white,
                                  child: TextField(
                                    controller: StateCase,
                                    textAlign: TextAlign.left,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.all(10.0),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustColors.TextGray,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          color: CustColors.TextGray,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      hintText: 'Select your State',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SubmitFlatButtonWidget(
                    height: 50,
                    width: double.infinity,
                    backgroundColor: CustColors.DarkBlue,
                    buttonText: "Continue",
                    buttonTextColor: Colors.white,
                    onpressed: () {
                      print(caseTitle.text.length);
                      if (caseTitle.text.toString().isEmpty) {
                        toastMsg("Enter Case Title");
                      } else if (caseDescription.text.toString().isEmpty) {
                        toastMsg("Enter Case Description");
                      } else if (CountryCase.text.toString().isEmpty) {
                        toastMsg("Enter Country");
                      } else if (StateCase.text.toString().isEmpty) {
                        toastMsg("Enter State");
                      } else if (caseTitle.text.length > 75) {
                        toastMsg(
                            "Case Title Greater Than 75 Characters Not Allowed");
                      } else if (caseDescription.text.length > 300) {
                        toastMsg(
                            "Case Description Greater Than 300 Characters Not Allowed");
                      } else if (charLength < 50) {
                        toastMsg(
                            "Case Description should be minimum 50 Characters");
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadCaseDocuments(
                                      caseTypeFlag: widget.caseTypeFlag,
                                      caseCategory: widget.caseCategory,
                                      caseTitle: caseTitle.text.toString(),
                                      caseDescription:
                                          caseDescription.text.toString(),
                                      filterCountry:
                                          CountryCase.text.toString(),
                                      filterState: StateCase.text.toString(),
                                    )));
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ));
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

  _onChanged(String value) {
    setState(() {
      charLength = value.length;
    });
  }

  void listenApi() {
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
}
