import 'package:bring2book/Constants/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




// submit Button widget

class SubmitButtonWidget extends StatefulWidget {
  final double height;
  final String buttonText;
  final Color buttonTextColor;
  final Color backgroundColor;
  final Function onpressed;
  final double width;

  const SubmitButtonWidget(
      {@required this.height,
      @required this.buttonText,
      @required this.buttonTextColor,
      @required this.backgroundColor,
      @required this.width,
      @required this.onpressed});

  @override
  State<StatefulWidget> createState() => SubmitButtonWidgetState();
}

class SubmitButtonWidgetState extends State<SubmitButtonWidget> {
  @override
  Widget build(Object context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: RaisedButton(
              onPressed: widget.onpressed,
              textColor: widget.buttonTextColor,
              color: widget.backgroundColor,
              child: Text(
                widget.buttonText,
                style: TextStyle(color: widget.buttonTextColor, fontSize: 15),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
            )));
  }
}



class SubmitFlatButtonWidget extends StatefulWidget {
  final double height;
  final String buttonText;
  final Color buttonTextColor;
  final Color backgroundColor;
  final Function onpressed;
  final double width;

  const SubmitFlatButtonWidget(
      {@required this.height,
        @required this.buttonText,
        @required this.buttonTextColor,
        @required this.backgroundColor,
        @required this.width,
        @required this.onpressed});

  @override
  State<SubmitFlatButtonWidget> createState() => SubmitFlatButtonWidgetState();
}

class SubmitFlatButtonWidgetState extends State<SubmitFlatButtonWidget> {
  @override
  Widget build(Object context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: FlatButton(
              onPressed: widget.onpressed,
              textColor: widget.buttonTextColor,
              color: widget.backgroundColor,
              child: Text(
                widget.buttonText,
                style: TextStyle(color: widget.buttonTextColor, fontSize: 15),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(4.0),
              ),
            )));
  }
}



class CasesFlatButtonWidget extends StatefulWidget {
  final double height;
  final String buttonText;
  final Color buttonTextColor;
  final Color backgroundColor;
  final Function onpressed;
  final double width;

  const CasesFlatButtonWidget(
      {@required this.height,
        @required this.buttonText,
        @required this.buttonTextColor,
        @required this.backgroundColor,
        @required this.width,
        @required this.onpressed});

  @override
  State<CasesFlatButtonWidget> createState() => CasesFlatButtonWidgetState();
}

class CasesFlatButtonWidgetState extends State<CasesFlatButtonWidget> {
  @override
  Widget build(Object context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: FlatButton(
              onPressed: widget.onpressed,
              textColor: widget.buttonTextColor,
              color: widget.backgroundColor,
              child: Text(
                widget.buttonText,
                style: TextStyle(color: widget.buttonTextColor, fontSize: 15,fontWeight: FontWeight.w300, ),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25),
              ),
            )));
  }
}







// textField

class TextFieldWidget extends StatefulWidget {
  final double height;
  final double width;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool validate;
  final bool autofocus;
  final int maxLines;
  final TextInputType textInputType;
  final TextAlign alignment;
  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;

  /// Maria New Changes  ///


  final  List<TextInputFormatter> inputFormatterRules;


  final Function onSubmitted;
  final Color backgroundColor;
  const TextFieldWidget(
      {@required this.height,
      @required this.width,
      @required this.validate,

      /// Maria New Changes  ///
      @required this.autofocus,
        this.inputFormatterRules,

      /// Maria New Changes  ///
      @required this.backgroundColor,
      @required this.hintText,
      @required this.errorText,
      @required this.labelText,
      @required this.maxLines,
      @required this.textInputType,
      @required this.alignment,
      @required this.enabled,
      @required this.controller,
      @required this.focusNode,

      /// Maria New Changes  ///
      @required this.onSubmitted});
  @override
  State<StatefulWidget> createState() => TextFieldWidgetState();
}

class TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5,right: 20,bottom: 20),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextField(
          inputFormatters:widget.inputFormatterRules,
          controller: widget.controller,
          onSubmitted: widget.onSubmitted,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          textAlign: widget.alignment,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            fillColor: widget.backgroundColor,
          ),
        ),
      ),
    );
  }
}



class TextFieldWidgetSignUp extends StatefulWidget {
  final double height;
  final double width;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool validate;
  final int maxLines;
  final TextInputType textInputType;
  final TextAlign alignment;
  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmitted;
  final Color backgroundColor;


  const TextFieldWidgetSignUp(
      {@required this.height,
      @required this.width,
      @required this.validate,
      @required this.backgroundColor,
      @required this.hintText,
      @required this.errorText,
      @required this.labelText,
      @required this.maxLines,
      @required this.textInputType,
      @required this.alignment,
      @required this.enabled,
      @required this.controller,
      @required this.focusNode,
      @required this.onSubmitted});
  @override
  State<StatefulWidget> createState() => TextFieldWidgetForSignUp();
}

class TextFieldWidgetForSignUp extends State<TextFieldWidgetSignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextField(
          controller: widget.controller,
          onSubmitted: widget.onSubmitted,
          textAlign: widget.alignment,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            fillColor: widget.backgroundColor,
          ),
        ),
      ),
    );
  }
}




class TextFieldWidgetForgot extends StatefulWidget {

  final bool obscureText;
  final double height;
  final double width;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool validate;
  final int maxLines;
  final TextInputType textInputType;
  final TextAlign alignment;
  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmitted;
  final Color backgroundColor;
  const TextFieldWidgetForgot(
      {@required this.height,
      @required this.width,
        @required this.obscureText,
      @required this.validate,
      @required this.backgroundColor,
      @required this.hintText,
      @required this.errorText,
      @required this.labelText,
      @required this.maxLines,
      @required this.textInputType,
      @required this.alignment,
      @required this.enabled,
      @required this.controller,
      @required this.focusNode,
      @required this.onSubmitted});
  @override
  State<TextFieldWidgetForgot> createState() => TextFieldWidgetForForgot();
}

class TextFieldWidgetForForgot extends State<TextFieldWidgetForgot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextField(
          obscureText:widget.obscureText,
          controller: widget.controller,
          onSubmitted: widget.onSubmitted,
          textAlign: widget.alignment,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            fillColor: widget.backgroundColor,
          ),
        ),
      ),
    );
  }
}




class TextFieldWidgetProfileEmail extends StatefulWidget {
  final double height;
  final double width;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool validate;
  final int maxLines;
  final TextInputType textInputType;
  final TextAlign alignment;
  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmitted;
  final Function onTap;
  final Color backgroundColor;


  const TextFieldWidgetProfileEmail(
      {@required this.height,
        @required this.width,
        @required this.validate,
        @required this.backgroundColor,
        @required this.hintText,
        @required this.errorText,
        @required this.labelText,
        @required this.maxLines,
        @required this.textInputType,
        @required this.alignment,
        @required this.enabled,
        @required this.controller,
        @required this.focusNode,
        @required this.onSubmitted,
        @required this.onTap});
  @override
  State<StatefulWidget> createState() => TextFieldWidgetProfile();
}

class TextFieldWidgetProfile extends State<TextFieldWidgetProfileEmail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextField(
          maxLines: widget.maxLines,
          onTap: widget.onTap,
          enabled: widget.enabled,
          controller: widget.controller,
          onSubmitted: widget.onSubmitted,
          textAlign: widget.alignment,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            fillColor: widget.backgroundColor,
          ),
        ),
      ),
    );
  }
}



class TextFieldWidgetProfileEmail1 extends StatefulWidget {
  final double height;
  final double width;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool validate;
  final int maxLines;
  final TextInputType textInputType;
  final TextAlign alignment;
  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmitted;
  final Function onTap;
  final Color backgroundColor;


  const TextFieldWidgetProfileEmail1(
      {@required this.height,
        @required this.width,
        @required this.validate,
        @required this.backgroundColor,
        @required this.hintText,
        @required this.errorText,
        @required this.labelText,
        @required this.maxLines,
        @required this.textInputType,
        @required this.alignment,
        @required this.enabled,
        @required this.controller,
        @required this.focusNode,
        @required this.onSubmitted,
        @required this.onTap});
  @override
  State<StatefulWidget> createState() => TextFieldWidgetProfile1();
}

class TextFieldWidgetProfile1 extends State<TextFieldWidgetProfileEmail1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 0, top: 10),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextFormField(
          maxLines: widget.maxLines,
          onTap: widget.onTap,
          enabled: widget.enabled,
          controller: widget.controller,
          onChanged: widget.onSubmitted,
          textAlign: widget.alignment,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            fillColor: widget.backgroundColor,
          ),
        ),
      ),
    );
  }
}



class TextFieldWidgetSignUpMandatory extends StatefulWidget {
  final double height;
  final double width;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool validate;
  final int maxLines;
  final TextInputType textInputType;
  final TextAlign alignment;
  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmitted;
  final Color backgroundColor;


  const TextFieldWidgetSignUpMandatory(
      {@required this.height,
        @required this.width,
        @required this.validate,
        @required this.backgroundColor,
        @required this.hintText,
        @required this.errorText,
        @required this.labelText,
        @required this.maxLines,
        @required this.textInputType,
        @required this.alignment,
        @required this.enabled,
        @required this.controller,
        @required this.focusNode,
        @required this.onSubmitted});
  @override
  State<StatefulWidget> createState() => TextFieldWidgetMandatory();
}

class TextFieldWidgetMandatory extends State<TextFieldWidgetSignUpMandatory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: Colors.red,
                width: 50,
                height: widget.height,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: TextField(
                controller: widget.controller,
                onSubmitted: widget.onSubmitted,
                textAlign: widget.alignment,
                keyboardType: widget.textInputType,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: widget.backgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class TextFieldWidgetMandatoryPwd extends StatefulWidget {

  final bool obscureText;
  final double height;
  final double width;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool validate;
  final int maxLines;
  final TextInputType textInputType;
  final TextAlign alignment;
  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmitted;
  final Color backgroundColor;
  const TextFieldWidgetMandatoryPwd(
      {@required this.height,
        @required this.width,
        @required this.obscureText,
        @required this.validate,
        @required this.backgroundColor,
        @required this.hintText,
        @required this.errorText,
        @required this.labelText,
        @required this.maxLines,
        @required this.textInputType,
        @required this.alignment,
        @required this.enabled,
        @required this.controller,
        @required this.focusNode,
        @required this.onSubmitted});
  @override
  State<TextFieldWidgetMandatoryPwd> createState() => TextFieldWidgetPwd();
}

class TextFieldWidgetPwd extends State<TextFieldWidgetMandatoryPwd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: Colors.red,
                width: 50,
                height: widget.height,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: TextField(
                obscureText:widget.obscureText,
                controller: widget.controller,
                onSubmitted: widget.onSubmitted,
                textAlign: widget.alignment,
                keyboardType: widget.textInputType,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: widget.backgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class TextFieldWidgetProfileEmailMandatory extends StatefulWidget {
  final double height;
  final double width;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool validate;
  final int maxLines;
  final TextInputType textInputType;
  final TextAlign alignment;
  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmitted;
  final Function onTap;
  final Color backgroundColor;


  const TextFieldWidgetProfileEmailMandatory(
      {@required this.height,
        @required this.width,
        @required this.validate,
        @required this.backgroundColor,
        @required this.hintText,
        @required this.errorText,
        @required this.labelText,
        @required this.maxLines,
        @required this.textInputType,
        @required this.alignment,
        @required this.enabled,
        @required this.controller,
        @required this.focusNode,
        @required this.onSubmitted,
        @required this.onTap});
  @override
  State<StatefulWidget> createState() => TextFieldWidgetProfileMandatory();
}

class TextFieldWidgetProfileMandatory extends State<TextFieldWidgetProfileEmailMandatory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: Colors.red,
                width: 50,
                height: widget.height,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: TextField(
                maxLines: widget.maxLines,
                onTap: widget.onTap,
                enabled: widget.enabled,
                controller: widget.controller,
                onSubmitted: widget.onSubmitted,
                textAlign: widget.alignment,
                keyboardType: widget.textInputType,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: widget.backgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class TextFieldWidgetMandatoryDOB extends StatefulWidget {
  final double height;
  final double width;
  final String hintText;
  final String labelText;
  final String errorText;
  final bool validate;
  final bool autofocus;
  final int maxLines;
  final TextInputType textInputType;
  final TextAlign alignment;
  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;

  /// Maria New Changes  ///


  final  List<TextInputFormatter> inputFormatterRules;


  final Function onSubmitted;
  final Color backgroundColor;
  const TextFieldWidgetMandatoryDOB(
      {@required this.height,
        @required this.width,
        @required this.validate,

        /// Maria New Changes  ///
        @required this.autofocus,
        this.inputFormatterRules,

        /// Maria New Changes  ///
        @required this.backgroundColor,
        @required this.hintText,
        @required this.errorText,
        @required this.labelText,
        @required this.maxLines,
        @required this.textInputType,
        @required this.alignment,
        @required this.enabled,
        @required this.controller,
        this.focusNode,

        /// Maria New Changes  ///
        @required this.onSubmitted});
  @override
  State<StatefulWidget> createState() => TextFieldWidgetStateMandatory();
}

class TextFieldWidgetStateMandatory extends State<TextFieldWidgetMandatoryDOB> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(
            children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                    color: Colors.red,
                    width: 50,
                    height: widget.height,
                  ),
                   ),
                   Padding(
            padding: EdgeInsets.only(left: 5),
            child: TextField(
              inputFormatters:widget.inputFormatterRules,
              controller: widget.controller,
              onSubmitted: widget.onSubmitted,
              focusNode: widget.focusNode,
              autofocus: widget.autofocus,
              textAlign: widget.alignment,
              keyboardType: widget.textInputType,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: widget.backgroundColor,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

