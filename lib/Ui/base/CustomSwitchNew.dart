library custom_switch;

import 'package:bring2book/Constants/colorConstants.dart';
import 'package:bring2book/Constants/styles.dart';
import 'package:flutter/material.dart';

class CustomSwitchNew extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  const CustomSwitchNew({Key key, this.value, this.onChanged, this.activeColor})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitchNew>
    with SingleTickerProviderStateMixin {
  Animation _circleAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
        begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
        parent: _animationController, curve: Curves.linear));
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            height: 25.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: _circleAnimation.value == Alignment.centerLeft
                    ? widget.activeColor
                    : widget.activeColor),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _circleAnimation.value == Alignment.centerRight
                    ? Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 4.0),
                  child: Text(
                    'Show',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 11.0),
                  ),
                )
                    : Container(),
                Container(
                  width: 45,
                  child: Container(
                    decoration: BoxDecoration(
                        color: CustColors.LightGray,
                        borderRadius: BorderRadius.all(
                            Radius.circular(20))),
                    child: Center(
                        child: Text(
                          _circleAnimation.value == Alignment.centerRight?'Hide':'Show',
                          style: Styles.textshowAlias18,
                        )),
                  ),
                ),
                _circleAnimation.value == Alignment.centerLeft
                    ? Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 10.0),
                  child: Text(
                    'Hide',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 11.0),
                  ),
                )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
