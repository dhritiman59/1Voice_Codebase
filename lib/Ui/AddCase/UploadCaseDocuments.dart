import 'dart:io';
import 'package:bring2book/Constants/CheckInternet.dart';
import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/LandingPage/MainLandingPage.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AddCaseBloc.dart';
import 'package:video_player/video_player.dart';

class UploadCaseDocuments extends StatefulWidget {
  final String caseTypeFlag,
      caseCategory,
      caseTitle,
      caseDescription,
      filterCountry,
      filterState;

  const UploadCaseDocuments(
      {this.caseTypeFlag,
      this.caseCategory,
      this.caseTitle,
      this.caseDescription,
      this.filterCountry,
      this.filterState});

  @override
  _State createState() => _State();
}

class _State extends State<UploadCaseDocuments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CheckInternet _checkInternet = CheckInternet();
  String text = ' ';
  bool visible = false;
  bool visibileDocuments = false;
  bool visibileImages = false;
  bool visibleInactiveButton = true;
  bool visibleActiveButton = true;
  double documentContainerHeight = 500;

  final AddCaseBloc _addCaseBloc = AddCaseBloc();

  String fileName;
  FilePickerResult files;
  Map<String, String> docpaths;
  Map<String, String> mergedArrayOfFiles;
  final List<String> _galleryDocPathList = [];
  List<String> extensions;
  bool isLoadingPath = false;
  bool isLoadingImagePath = false;
  FileType fileType;
  var durationFromV;

  bool firstButtonClick = true;

  @override
  void initState() {
    super.initState();
    print(
        'caseTypeFlag ${widget.caseTypeFlag}  caseCategory ${widget.caseCategory}'
        'caseTitle ${widget.caseTitle}  caseDescription ${widget.caseDescription} ');

    listenAPi();

    if (_galleryDocPathList.isEmpty) {
      setState(() {
        visibleInactiveButton = true;
        visibleActiveButton = false;
        visibileDocuments = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  Container(height: 285, color: CustColors.DarkBlue),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 21.0, left: 30.0),
                      child: Image.asset(
                        "assets/images/whiteBackArrow.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 65.0),
                    child: Text("Add Case",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          fontFamily: 'Formular',
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/docUploadIcon.png",
                            width: 60,
                            height: 60,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text("Let’s upload documents",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                  fontFamily: 'Formular',
                                )),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 10.0, left: 30, right: 30),
                            child: Text(
                                "Attach a photo or video not more than 500KB in size",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.0,
                                  fontFamily: 'Formular',
                                )),
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Center(
                                child: Container(
                                  width: 120.0,
                                  height: 32.0,
                                  decoration: const BoxDecoration(
                                      color: CustColors.DarkGreen,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/open_gallery_icon.png',
                                          width: 15,
                                          height: 15),
                                      const Text(
                                        " Open Gallery",
                                        style: Styles.homeCategoryNameswhite,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ),
                            onTap: () {
                              _openFileExplorer();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: visibleInactiveButton,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                          height: 170,
                          child: Center(
                            child: Text('No Upload Files'),
                          )),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                        child: SubmitFlatButtonWidget(
                          height: 50,
                          width: double.infinity,
                          backgroundColor: CustColors.DarkBlue,
                          buttonText: "Submit",
                          buttonTextColor: Colors.white,
                          onpressed: () {
                            if (firstButtonClick == true) {
                              setState(() {
                                firstButtonClick = false;
                              });
                              var newList = _galleryDocPathList;
                              print(newList);
                              /*if (newList.length == 0) {
                              toastMsg('Please Upload files');
                            }*/
                              setState(() {
                                visible = true;
                              });
                              _addCaseBloc.updateDocuments(
                                  widget.caseTitle,
                                  widget.caseDescription,
                                  widget.caseTypeFlag,
                                  newList,
                                  widget.caseCategory,
                                  widget.filterCountry,
                                  widget.filterState);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visibleActiveButton,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Visibility(
                                  visible: visibileDocuments,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 20, 20),
                                    child: Text("Files",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'Formular',
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Visibility(
                                  visible: visibileDocuments,
                                  child: SizedBox(
                                    height: (_galleryDocPathList.length) *
                                        80.toDouble(),
                                    child: Builder(
                                      builder: (BuildContext context) =>
                                          isLoadingPath
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Container(),
                                                )
                                              : _galleryDocPathList.isNotEmpty
                                                  ? ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: _galleryDocPathList !=
                                                                  null &&
                                                              _galleryDocPathList
                                                                  .isNotEmpty
                                                          ? _galleryDocPathList
                                                              .length
                                                          : 0,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        String docpdficon;
                                                        final bool isMultiPath =
                                                            _galleryDocPathList !=
                                                                    null &&
                                                                _galleryDocPathList
                                                                    .isNotEmpty;
                                                        final String name =
                                                            (isMultiPath
                                                                ? _galleryDocPathList
                                                                        .toList()[
                                                                    index]
                                                                : fileName ??
                                                                    '...');

                                                        var completePath =
                                                            _galleryDocPathList
                                                                .toList()[index]
                                                                .toString();

                                                        var fileNameExtension =
                                                            (completePath
                                                                .split('.')
                                                                .last);

                                                        var filepathname =
                                                            (completePath
                                                                .split('/')
                                                                .last);

                                                        if (fileNameExtension ==
                                                                "pdf" ||
                                                            fileNameExtension ==
                                                                "PDF") {
                                                          docpdficon =
                                                              'assets/images/pdf_icon_addCase.png';
                                                        } else if (fileNameExtension ==
                                                                "doc" ||
                                                            fileNameExtension ==
                                                                "docx") {
                                                          docpdficon =
                                                              'assets/images/doc_icon_AddCase.png';
                                                        } else if (fileNameExtension == "jpg" ||
                                                            fileNameExtension ==
                                                                "jpeg" ||
                                                            fileNameExtension ==
                                                                "png" ||
                                                            fileNameExtension ==
                                                                "PNG") {
                                                          docpdficon =
                                                              'assets/images/image_icon2.png';
                                                        } else {
                                                          docpdficon =
                                                              'assets/images/play_icon.png';
                                                        }

                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  20,
                                                                  10,
                                                                  10,
                                                                  10),
                                                          child: SizedBox(
                                                            height: 60,
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0.0),
                                                                      child: Image.asset(
                                                                          docpdficon,
                                                                          width:
                                                                              45,
                                                                          height:
                                                                              45),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 2,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              3,
                                                                          child:
                                                                              SizedBox(
                                                                            child:
                                                                                Text(
                                                                              filepathname,
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.start,
                                                                              softWrap: false,
                                                                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                _galleryDocPathList.removeAt(index);
                                                                                if (_galleryDocPathList.isEmpty) {
                                                                                  isLoadingPath = true;
                                                                                  visibileDocuments = false;
                                                                                  visibleActiveButton = false;
                                                                                  visibleInactiveButton = true;
                                                                                }
                                                                              });
                                                                            },
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/images/deletenewicon.png",
                                                                              height: 23,
                                                                              width: 23,
                                                                            )),

                                                                        /* Expanded(
                                                                          flex:
                                                                              1,
                                                                          child: IconButton(
                                                                              icon: Icon(
                                                                                Icons.cancel,
                                                                                color: Colors.red,
                                                                                size: 23,
                                                                              ),
                                                                              onPressed: () => setState(() {
                                                                                    _galleryDocPathList.removeAt(index);
                                                                                    if (_galleryDocPathList.length == 0) {
                                                                                      isLoadingPath = true;
                                                                                      visibileDocuments = false;
                                                                                      visibleActiveButton = false;
                                                                                      visibleInactiveButton = true;
                                                                                    }
                                                                                  })),
                                                                        )*/
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Container(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SubmitFlatButtonWidget(
                          height: 50,
                          width: double.infinity,
                          backgroundColor: CustColors.DarkBlue,
                          buttonText: "Submit",
                          buttonTextColor: Colors.white,
                          onpressed: () {
                            if (firstButtonClick == true) {
                              setState(() {
                                firstButtonClick = false;
                              });
                              var newList = _galleryDocPathList;

                              List<bool> isFilesizeValid = [];
                              List<bool> videofilesincluded = [];
                              bool isValidFiles = true;
                              // var index = -1;
                              print(newList);
                              if (newList.isEmpty) {
                                setState(() {
                                  firstButtonClick = true;
                                });
                                toastMsg('Please Upload files');
                              } else {
                                if (newList.length > 2) {
                                  setState(() {
                                    firstButtonClick = true;
                                  });
                                  toastMsg("More than 2 Files Can't be Upload");
                                } else {
                                  for (int i = 0;
                                      i < _galleryDocPathList.length;
                                      i++) {
                                    var completePath =
                                        (_galleryDocPathList[i].toString());
                                    var fileNameExtension =
                                        (completePath.split('.').last);
                                    final f = File(_galleryDocPathList[i]);
                                    int sizeInBytes = f.lengthSync();
                                    double sizeInMb =
                                        sizeInBytes / (1024 * 1024);
                                    double sizeInKb = 0;
                                    if (fileNameExtension == "jpg" ||
                                        fileNameExtension == "jpeg" ||
                                        fileNameExtension == "png" ||
                                        fileNameExtension == "PNG") {
                                      sizeInKb = sizeInBytes / (1024);
                                    }

                                    if (sizeInMb > 150) {
                                      setState(() {
                                        firstButtonClick = true;
                                      });
                                      toastMsg(
                                          'Greater than 150Mb not supported');
                                    } else if (sizeInKb > 500) {
                                      setState(() {
                                        firstButtonClick = true;
                                      });
                                      toastMsg(
                                          'Images greater than 500kb not supported');
                                    } else if (fileNameExtension == "mp4" ||
                                        fileNameExtension == "MP4") {
                                      videofilesincluded.add(true);
                                      VideoPlayerController ctlVideo;
                                      ctlVideo = VideoPlayerController.file(
                                          File(files.files[i].bytes.toString()))
                                        ..initialize().then((_) {
                                          print(durationFromV);
                                          // Get Video Duration in Milliseconds
                                          durationFromV =
                                              ctlVideo.value.duration.inMinutes;
                                          print('durationFromV $durationFromV');

                                          if (durationFromV >= 3) {
                                            isFilesizeValid.add(false);
                                          } else {
                                            isFilesizeValid.add(true);
                                          }
                                          print(isFilesizeValid);
                                          print(videofilesincluded);

                                          if (isFilesizeValid.length ==
                                              videofilesincluded.length) {
                                            for (var element
                                                in isFilesizeValid) {
                                              print('element  $element');
                                              if (element == false) {
                                                isValidFiles = false;
                                              }
                                            }
                                            if (isValidFiles == false) {
                                              setState(() {
                                                firstButtonClick = true;
                                              });
                                              toastMsg(
                                                  'Video Duration greater than 3 min cant be upload');
                                            } else {
                                              //toastMsg(' success with video');
                                              print(
                                                  'file size ok upload hurayyyyyyyyyyyy');
                                              setState(() {
                                                visible = true;
                                              });
                                              _addCaseBloc.updateDocuments(
                                                  widget.caseTitle,
                                                  widget.caseDescription,
                                                  widget.caseTypeFlag,
                                                  newList,
                                                  widget.caseCategory,
                                                  widget.filterCountry,
                                                  widget.filterState);
                                            }
                                          }
                                        });
                                    }
                                  }
                                  if (videofilesincluded.isEmpty) {
                                    // toastMsg('Files uploaded sucess without video');
                                    print(
                                        'Files uploaded sucess without video hurayyyyyyyyyyyy');
                                    setState(() {
                                      visible = true;
                                    });
                                    _addCaseBloc.updateDocuments(
                                        widget.caseTitle,
                                        widget.caseDescription,
                                        widget.caseTypeFlag,
                                        newList,
                                        widget.caseCategory,
                                        widget.filterCountry,
                                        widget.filterState);
                                  }
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: Visibility(
                visible: visible,
                child: Center(
                  child: Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 30),
                      child: const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(CustColors.DarkBlue),
                      )),
                )),
          ),
        ],
      ),
    );
  }

  void listenAPi() {
    _addCaseBloc.addCaseStream.listen((data) {
      if ((data.status == "success")) {
        setState(() {
          visible = false;
        });
        print(data.message);
        toastMsg(data.message);
        Future.delayed(const Duration(seconds: 1)).then((_) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainLandingPage(frompage: "0")),
              ModalRoute.withName("/MainLandingPage"));
        });
      } else if ((data.status == "error")) {
        setState(() {
          visible = false;
          firstButtonClick = true;
        });
        toastMsg(data.message);
        print(data.message);
      }
    });
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ));
  }

  void _openFileExplorer() async {
    VideoPlayerController _controller;

    try {
      files = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'mp4', 'docx', 'jpeg'],
      );
      if (files != null) {
        setState(() {
          visibileDocuments = true;
          visibleInactiveButton = false;
          visibleActiveButton = true;
        });
        for (int i = 0; i < files.count; i++) {
          var completePath = (files.files[i].toString());
          var fileNameExtension = (completePath.split('.').last);
          final f = File(files.files[i].bytes.toString());
          int sizeInBytes = f.lengthSync();
          double sizeInMb = sizeInBytes / (1024 * 1024);
          double sizeInKb = 0;
          if (fileNameExtension == "jpg" ||
              fileNameExtension == "jpeg" ||
              fileNameExtension == "png" ||
              fileNameExtension == "PNG") {
            sizeInKb = sizeInBytes / (1024);
          }

          if (sizeInMb > 150) {
            toastMsg('Files Greater than 150Mb not supported');
          } else if (sizeInKb > 500) {
            toastMsg('Images Greater than 500kb not supported');
          } else {
            _galleryDocPathList.add(files.files[i].bytes.toString());
          }
        }

        if (_galleryDocPathList.length == 1) {
          setState(() {
            documentContainerHeight = 100;
          });
        } else {
          setState(() {
            documentContainerHeight = 500;
          });
        }
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      isLoadingPath = false;
      fileName = files != null ? files.toString() : '...';
    });
  }
}
