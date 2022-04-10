import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bring2book/Models/StateListModel/StateListModel.dart';
import 'package:bring2book/Ui/AddCase/AddCaseBloc.dart';
import 'package:bring2book/Ui/HomePage/HomeListAllCasesBloc.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:bring2book/Models/CountryListModel/CountryListModel.dart';
import 'package:bring2book/Models/CountryFilterBackScreenModel/CountryFilterBackScreenModel.dart';



class CountryStateFilterPage extends StatefulWidget {
  CountryStateFilterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CountryStateFilterPageState createState() => _CountryStateFilterPageState();
}

class _CountryStateFilterPageState extends State<CountryStateFilterPage> {

  CountryFilterBackScreenModel _countryFilterBackScreenModel = new CountryFilterBackScreenModel();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HomeListAllCasesBloc _homeListAllCasesBloc = HomeListAllCasesBloc();

  AddCaseBloc _addCaseBloc = AddCaseBloc();
  TextEditingController CountryCase = new TextEditingController();
  TextEditingController StateCase = new TextEditingController();



  bool visible = false;

  String countryId;


  StateSetter mycountry1,mystate1;

  bool isLoadingCountry = false;
  bool isLoadingState = false;





  @override
  void initState() {
    super.initState();
    _addCaseBloc.CountryListAPI( page: "0", searchTitle: '');
    listenApi();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Stack(
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 30.0, top: 30),
                          child: Text("Filter",
                              style: new TextStyle(
                                color: CustColors.DarkBlue,
                                fontSize: 18.0,
                                fontFamily: 'Formular',
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height * 0.60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    InkWell(
                      onTap: (){


                        showDialog(context: context,
                            builder: (BuildContext context){
                              return   AlertDialog(
                                title: new Text("Select Country"),
                                content: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter mycountry) {
                                      mycountry1 = mycountry;
                                      return Container(
                                        width: double.maxFinite,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 5, 5, 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: CustColors.LightRose,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(5))),
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .fromLTRB(10, 0, 5, 0),
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          onChanged: (text) {
                                                            _addCaseBloc
                                                                .CountryListAPI(
                                                                page: "0",
                                                                searchTitle: text);
                                                          },
                                                          textAlign: TextAlign.left,
                                                          decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "Search",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Image.asset(
                                                            'assets/images/rosesearch.png',
                                                            width: 20, height: 20),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: StreamBuilder(
                                                  stream: _addCaseBloc
                                                      .countryListStream,
                                                  builder: (context, AsyncSnapshot<
                                                      CountryListModel> snapshot) {
                                                    if (snapshot.connectionState ==
                                                        ConnectionState.waiting ||
                                                        snapshot.connectionState ==
                                                            ConnectionState.none) {
                                                      return Center(
                                                          child: ProgressBarLightRose());
                                                    } else if (snapshot.hasData ||
                                                        snapshot.data.data.data
                                                            .length != 0) {
                                                      if (snapshot.data.status ==
                                                          'error') {
                                                        return noDataFound();
                                                      } else
                                                      if (snapshot.data.data.data
                                                          .length == 0) {
                                                        return noDataFound();
                                                      }
                                                    } else {
                                                      return Center(
                                                          child: ProgressBarDarkBlue());
                                                    }
                                                    return NotificationListener(
                                                      // ignore: missing_return
                                                      onNotification: (
                                                          ScrollNotification scrollInfo) {
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
                                                                .data.data
                                                                .currentPage + 1;
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
                                                        padding: EdgeInsets
                                                            .fromLTRB(0, 0, 0, 0),
                                                        scrollDirection: Axis
                                                            .vertical,
                                                        shrinkWrap: true,
                                                        itemCount: snapshot.data
                                                            .data.data.length,
                                                        itemBuilder: (context,
                                                            index) {
                                                          return ListTile(
                                                            onTap: () {
                                                              /// Navigate To CaseDetails
                                                              countryId =
                                                                  snapshot.data.data
                                                                      .data[index]
                                                                      .id
                                                                      .toString();
                                                              var name = snapshot
                                                                  .data.data
                                                                  .data[index].name;
                                                              print(countryId);
                                                              print(name);
                                                              _addCaseBloc
                                                                  .StateListAPI(
                                                                  page: "0",
                                                                  searchTitle: '',
                                                                  countryId: countryId
                                                                      .toString());
                                                              setState(() {
                                                                StateCase.text = '';
                                                                CountryCase.text =
                                                                    name;
                                                              });

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            title: Container(
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                        0, 10, 0,
                                                                        10),
                                                                    child: Align(
                                                                      alignment: Alignment
                                                                          .centerLeft,
                                                                      child: AutoSizeText(
                                                                        '${snapshot
                                                                            .data
                                                                            .data
                                                                            .data[index]
                                                                            .name}',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize: 13),
                                                                        minFontSize: 10,
                                                                        stepGranularity: 1,
                                                                        maxLines: 4,
                                                                        textAlign: TextAlign
                                                                            .justify,
                                                                        overflow: TextOverflow
                                                                            .ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets
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
                                              child: ProgressBarLightRose(),)
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    }
                                ),
                              );
                            }
                        );

                       /* showDialog(
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
                                          padding: EdgeInsets.fromLTRB(
                                              5, 5, 5, 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: CustColors.LightRose,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    padding: EdgeInsets
                                                        .fromLTRB(10, 0, 5, 0),
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      onChanged: (text) {
                                                        _addCaseBloc
                                                            .CountryListAPI(
                                                            page: "0",
                                                            searchTitle: text);
                                                      },
                                                      textAlign: TextAlign.left,
                                                      decoration: InputDecoration(
                                                        border: InputBorder
                                                            .none,
                                                        hintText: "Search",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: Image.asset(
                                                        'assets/images/rosesearch.png',
                                                        width: 20, height: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: StreamBuilder(
                                              stream: _addCaseBloc
                                                  .countryListStream,
                                              builder: (context, AsyncSnapshot<
                                                  CountryListModel> snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting ||
                                                    snapshot.connectionState ==
                                                        ConnectionState.none) {
                                                  return Center(
                                                      child: ProgressBarLightRose());
                                                } else if (snapshot.hasData ||
                                                    snapshot.data.data.data
                                                        .length != 0) {
                                                  if (snapshot.data.status ==
                                                      'error') {
                                                    return noDataFound();
                                                  } else
                                                  if (snapshot.data.data.data
                                                      .length == 0) {
                                                    return noDataFound();
                                                  }
                                                } else {
                                                  return Center(
                                                      child: ProgressBarDarkBlue());
                                                }
                                                return NotificationListener(
                                                  // ignore: missing_return
                                                  onNotification: (
                                                      ScrollNotification scrollInfo) {
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
                                                            .data.data
                                                            .currentPage + 1;
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
                                                    padding: EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
                                                    scrollDirection: Axis
                                                        .vertical,
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data
                                                        .data.data.length,
                                                    itemBuilder: (context,
                                                        index) {
                                                      return ListTile(
                                                        onTap: () {
                                                          /// Navigate To CaseDetails
                                                          countryId =
                                                              snapshot.data.data
                                                                  .data[index]
                                                                  .id
                                                                  .toString();
                                                          var name = snapshot
                                                              .data.data
                                                              .data[index].name;
                                                          print(countryId);
                                                          print(name);
                                                          _addCaseBloc
                                                              .StateListAPI(
                                                              page: "0",
                                                              searchTitle: '',
                                                              countryId: countryId
                                                                  .toString());
                                                          setState(() {
                                                            StateCase.text = '';
                                                            CountryCase.text =
                                                                name;
                                                          });

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        title: Container(
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                    0, 10, 0,
                                                                    10),
                                                                child: Align(
                                                                  alignment: Alignment
                                                                      .centerLeft,
                                                                  child: AutoSizeText(
                                                                    '${snapshot
                                                                        .data
                                                                        .data
                                                                        .data[index]
                                                                        .name}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 13),
                                                                    minFontSize: 10,
                                                                    stepGranularity: 1,
                                                                    maxLines: 4,
                                                                    textAlign: TextAlign
                                                                        .justify,
                                                                    overflow: TextOverflow
                                                                        .ellipsis,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                EdgeInsets
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
                          child: TextField(
                           controller: CountryCase,
                           textAlign: TextAlign.left,
                           enabled: false,
                           decoration: new InputDecoration(
                             contentPadding: EdgeInsets.all(10.0),
                             suffixIcon: IconButton(
                               icon:  Padding(
                                   padding:
                                   EdgeInsets.fromLTRB(5, 0, 0, 0),
                                   child: Image.asset(
                                       'assets/images/dropdownarrow.png',
                                       width: 12,
                                       height: 12)),
                             ),
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
                             hintText: 'Select your Country',
                           ),
                              ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:CountryCase.text==''||CountryCase.text.isEmpty?false:true,
                      child: InkWell(
                        onTap: (){

                          showDialog(context: context,
                              builder: (BuildContext context){
                                return  AlertDialog(
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
                                                              _addCaseBloc.StateListAPI( page: "0", searchTitle: text, countryId: countryId);
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
                                );
                              }
                          );

                        /*  showDialog(
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
                                                          _addCaseBloc.StateListAPI( page: "0", searchTitle: text, countryId: countryId);
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
                                                        *//*if ((index+1) == snapshot.data.data.data.length ) {//pagination loader
                                                              return Container(
                                                                padding: EdgeInsets.only(bottom: 10),
                                                                child: snapshot.data.data.currentPage +1 < snapshot.data.data.totalPages
                                                                    ? Center(child: ProgressBarDarkBlue(),) :  Container(),
                                                              );
                                                            }*//*

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
                          padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
                          child: SizedBox(
                            height: 45,
                            child: new TextField(
                              controller: StateCase,
                              textAlign: TextAlign.left,
                              enabled: false,
                              decoration: new InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                suffixIcon: IconButton(
                                  icon:  Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Image.asset(
                                          'assets/images/dropdownarrow.png',
                                          width: 12,
                                          height: 12)),
                                ),
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
                                hintText: 'Select your State',
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
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SubmitFlatButtonWidget(
                      height: 50,
                      width: double.infinity,
                      backgroundColor: CustColors.DarkBlue,
                      buttonText: "Submit",
                      buttonTextColor: Colors.white,
                      onpressed: () {
                        if(CountryCase.text==""||CountryCase.text.isEmpty)
                          {
                            toastMsg('Enter County');
                          }
                        else{
                          var addressmodel = new  CountryFilterBackScreenModel(

                              country:CountryCase.text,

                              state:StateCase.text,);

                          Navigator.pop(context,addressmodel);
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
    );


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
        print("${data.status}");
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
        print("${data.status}");
      }
    });
  }



  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
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
                Text('No Data Found',
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
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.DarkBlue),
          )),
    );
  }

  Widget ProgressBarLightRose() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.Radio),
          )),
    );
  }

}