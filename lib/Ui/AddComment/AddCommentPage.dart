import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:bring2book/Ui/AddComment/AddCommentBloc.dart';
import 'package:bring2book/Ui/base/baseWidgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class AddCommentPage extends StatefulWidget {
  final String caseId;
  int userId;

  AddCommentPage({this.caseId, this.userId});

  @override
  _AddCommentPageState createState() =>
      _AddCommentPageState(caseId: caseId, userId: userId);
}

class _AddCommentPageState extends State<AddCommentPage> {
  final String caseId;
  int userId;
  _AddCommentPageState({this.caseId, this.userId});
  bool visible = false;
  TextEditingController comment = TextEditingController();
  final FocusNode _commentFocus = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String fileName;
  FilePickerResult paths;

  List<String> extensions;
  bool isLoadingPath = false;
  FileType fileType;
  AddCommentBloc bloc = AddCommentBloc();
  final List<String> _galleryImagePathList = [];

  var durationFromV;

  bool firstButtonClick = true;

  @override
  void initState() {
    super.initState();
    listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(children: [
        ListView(
          //physics: const NeverScrollableScrollPhysics(),
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
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Text(
                "Enter your Comment",
                style: Styles.textHeadAddCommentBlue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Container(
                color: CustColors.LightRose,
                height: 150,
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
                        height: 150.0,
                        child: TextField(
                          controller: comment,
                          maxLines: 250,
                          onSubmitted: (text) {
                            _commentFocus.unfocus();
                          },
                          decoration: InputDecoration(
                            fillColor: CustColors.LightRose,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: CustColors.TextGray,
                                style: BorderStyle.solid,
                              ),
                            ),
                            hintText: 'Type here…..',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: InkWell(
                onTap: () {
                  print('hi');
                  _openFileExplorer();
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/camera.png",
                      width: 20,
                      height: 20,
                      gaplessPlayback: true,
                    ),
                    const Text("  Add Image")
                  ],
                ),
              ),
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _galleryImagePathList.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Text(_galleryImagePathList[pos]),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
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
                          if (comment.text.toString().isEmpty) {
                            toastMsg("Enter Comment");
                          } else {
                            var newList = _galleryImagePathList;
                            List<bool> isFilesizeValid = [];
                            List<bool> videofilesincluded = [];
                            bool isValidFiles = true;
                            print(newList);
                            if (newList.isEmpty) {
                              bloc.updateDocuments(comment.text.toString(),
                                  _galleryImagePathList, caseId);
                            } else {
                              if (newList.length > 10) {
                                toastMsg("More than 10 Files Can't be Upload");
                              } else {
                                for (int i = 0; i < newList.length; i++) {
                                  var completePath = (newList[i].toString());
                                  var fileNameExtension =
                                      (completePath.split('.').last);
                                  final f = File(newList[i]);
                                  int sizeInBytes = f.lengthSync();
                                  double sizeInMb = sizeInBytes / (1024 * 1024);

                                  if (sizeInMb > 100) {
                                    toastMsg(
                                        'Greater than 100Mb not supported');
                                  } else if (fileNameExtension == "mp4" ||
                                      fileNameExtension == "MP4") {
                                    videofilesincluded.add(true);
                                    VideoPlayerController ctlVideo;
                                    ctlVideo = VideoPlayerController.file(
                                        File(newList[i].toString()))
                                      ..initialize().then((_) {
                                        print(durationFromV);
                                        // Get Video Duration in Milliseconds
                                        durationFromV =
                                            ctlVideo.value.duration.inMinutes;
                                        print('durationFromV$durationFromV');

                                        if (durationFromV >= 3) {
                                          isFilesizeValid.add(false);
                                        } else {
                                          isFilesizeValid.add(true);
                                        }
                                        print(isFilesizeValid);
                                        print(videofilesincluded);

                                        if (isFilesizeValid.length ==
                                            videofilesincluded.length) {
                                          for (var element in isFilesizeValid) {
                                            print('element  $element');
                                            if (element == false) {
                                              isValidFiles = false;
                                            }
                                          }
                                          if (isValidFiles == false) {
                                            setState(() {
                                              _galleryImagePathList.clear();
                                              newList.clear();
                                            });
                                            toastMsg(
                                                'Video Duration greater than 3 min cant be upload');
                                          } else {
                                            print(
                                                'file size ok upload hurayyyyyyyyyyyy');
                                            setState(() {
                                              visible = true;
                                            });
                                            bloc.updateDocuments(
                                                comment.text.toString(),
                                                _galleryImagePathList,
                                                caseId);
                                          }
                                        }
                                      });
                                  }
                                }
                                if (videofilesincluded.isEmpty) {
                                  print(
                                      'Files uploaded sucess without video hurayyyyyyyyyyyy');
                                  setState(() {
                                    visible = true;
                                  });
                                  bloc.updateDocuments(comment.text.toString(),
                                      _galleryImagePathList, caseId);
                                }
                              }
                            }
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
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
      ]),
    );
  }

  void _openFileExplorer() async {
    setState(() => isLoadingPath = true);
    try {
      paths = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'mp4'],
      );
      print(paths);
      for (int i = 0; i < paths.count; i++) {
        _galleryImagePathList.add(paths.files.toList()[i].path.toString());
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      isLoadingPath = false;
      fileName = paths != null ? paths.paths.toString() : '...';
    });
  }

  void listen() {
    bloc.addComment.listen((data) {
      if ((data.status == "success")) {
        print(data.message);
        setState(() {
          firstButtonClick = true;
          visible = false;
        });
        toastMsg(data.message);

        Future.delayed(const Duration(seconds: 1)).then((_) {
          Navigator.pop(context, true);
        });
      } else if ((data.status == "error")) {
        print(data.message);
        toastMsg(data.message);
        setState(() {
          firstButtonClick = true;
          visible = false;
        });
      }
    });
  }

  toastMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ));
  }
}
