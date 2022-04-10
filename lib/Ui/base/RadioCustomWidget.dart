import 'package:bring2book/Constants/colorConstants.dart';
import 'package:flutter/material.dart';

class RadioCustomWidget<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final double width;
  final double height;
  final String text;

  RadioCustomWidget({this.value, this.groupValue, this.onChanged, this.width = 15, this.height = 15,this.text,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onChanged(this.value);
        },
        child: Row(
          children: [
            Container(
              height: this.height,
              width: this.width,
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff4e1d56),
                    Color(0xff4e1d56),
                  ],
                ),
              ),

              child: Center(
                child: Container(
                  height: this.height - 6,
                  width: this.width - 6,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    gradient: LinearGradient(
                      colors: value == groupValue ? [
                        Color(0xfffeb0ac),
                        Color(0xfffeb0ac),
                      ] : [
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                '  $text',
                style: new TextStyle(
                    fontSize: 17.0, color: CustColors.Grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}