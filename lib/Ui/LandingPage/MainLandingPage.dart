import 'package:bring2book/Ui/ChatHomePage/ChatHomePage.dart';
import 'package:bring2book/Ui/HomePage/HomeListPage.dart';
import 'package:bring2book/Ui/MyCaseAndJoinCaseHomePage/MyCaseAndJoinCaseHomePage.dart';
import 'package:bring2book/Ui/ProfileHomePage/ProfileMainHomePage.dart';
import 'package:bring2book/Widgets/exit_popup_widget.dart';
import 'package:flutter/material.dart';

class MainLandingPage extends StatefulWidget {
  final String frompage;

  const MainLandingPage({this.frompage});

  @override
  _MainLandingPageState createState() => _MainLandingPageState();
}

class _MainLandingPageState extends State<MainLandingPage> {
  DateTime timeBackPressed = DateTime.now();

  int selectedIndex = 0;
  final widgetOptions = [
    HomeListPage(),
    MyCaseAndJoinCaseHomePage(),
    const ChatHomePage(),
    ProfileMainHomePage(),
  ];

  @override
  void initState() {
    if (widget.frompage == "3") {
      setState(() {
        selectedIndex = 3;
      });
    } else if (widget.frompage == "1") {
      setState(() {
        selectedIndex = 1;
      });
    } else {
      setState(() {
        selectedIndex = 0;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child:  IndexedStack(
            index: selectedIndex,
            children: <Widget> [
              HomeListPage(),
              MyCaseAndJoinCaseHomePage(),
              ChatHomePage(),
              ProfileMainHomePage(),
            ],
          )
        //widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Container(
                child: new Image.asset('assets/images/homewhiteicon.png',
                    width: 30, height: 30),
              ),
              activeIcon: new Image.asset('assets/images/homeactiveicon.png',
                  width: 30, height: 30),
              title: new  Container(height: 0.0)),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset('assets/images/cases_inactive_icon.png',
                  width: 30, height: 30),
              activeIcon: new Image.asset('assets/images/home_mycases_icon.png',
                  width: 30, height: 30),
              title: new Container(height: 0.0)),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset('assets/images/chathomeicon.png',
                  width: 30, height: 30),
              activeIcon: new Image.asset('assets/images/chat_active_icon.png',
                  width: 30, height: 30),
              title:  new  Container(height: 0.0)),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset('assets/images/profilehomeicon.png',
                  width: 30, height: 30),
              activeIcon: new Image.asset(
                  'assets/images/profie_active_icon.png',
                  width: 30,
                  height: 30),
              title: new  Container(height: 0.0)),
        ],
        currentIndex: selectedIndex,
        //fixedColor: Colors.transparent,
        onTap: onItemTapped,
      ),
    );*/

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          /* final message = 'Press back again to exit';
            Fluttertoast.showToast(msg: message,fontSize: 18);
            */
          return false;
        } else {
          //Fluttertoast.cancel();
          ShowPopUpWidget().showPopUp(context);
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: selectedIndex,
          children: [
            HomeListPage(),
            MyCaseAndJoinCaseHomePage(),
            const ChatHomePage(),

            ProfileMainHomePage(),
            // Container(
            //   color: Colors.white,
            //   child: const Center(
            //     child: Text("Coming Soon"),
            //   ),
            // ),

            // Container(
            //   color: Colors.white,
            //   child: const Center(
            //     child: Text("Coming Soon"),
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Image.asset('assets/images/homewhiteicon.png',
                  width: 30, height: 30),
              activeIcon: Image.asset('assets/images/homeactiveicon.png',
                  width: 30, height: 30),
              label: "",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Image.asset('assets/images/cases_inactive_icon.png',
                  width: 30, height: 30),
              activeIcon: Image.asset('assets/images/home_mycases_icon.png',
                  width: 30, height: 30),
              label: "",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Image.asset('assets/images/chathomeicon.png',
                  width: 30, height: 30),
              activeIcon: Image.asset('assets/images/chat_active_icon.png',
                  width: 30, height: 30),
              label: "",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Image.asset('assets/images/profilehomeicon.png',
                  width: 30, height: 30),
              activeIcon: Image.asset('assets/images/profie_active_icon.png',
                  width: 30, height: 30),
              label: "",
            ),
          ],
          currentIndex: selectedIndex,
          //fixedColor: Colors.transparent,
          onTap: onItemTapped,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  /* showExitPopup(){
    return showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Confirm'),
            content: Text('Do you want to exit?'),
            actions: <Widget>[
              RaisedButton(
                  child: Text('No'),
                  color: Colors.white,
                  onPressed: (){
                    Navigator.of(context).pop();
              },),
              RaisedButton(
                child: Text("Yes"),
                  color: Colors.white,
                  onPressed: (){
                    SystemNavigator.pop();
                  }
              )
            ],
          );
        }
    );
  }*/
}
