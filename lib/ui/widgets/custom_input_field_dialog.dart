import 'package:cygneto/exports/resources.dart';
import 'package:cygneto/exports/themes.dart';
import 'package:flutter/material.dart';

class CustomInputFieldDialog extends StatefulWidget {
  CustomInputFieldDialog(
      {required this.textEditingController,
      required this.title,
      required this.hint,
      required this.yes,
      required this.no,
      required this.yesOnPressed,
      required this.noOnPressed,
      required this.caption,
      Key? key})
      : super(key: key);

  TextEditingController textEditingController;
  String title;
  String hint;
  String yes = '';
  String no = '';
  Function yesOnPressed = () {};
  Function noOnPressed = () {};
  ValueSetter<String> caption;

  @override
  _CustomInputFieldDialogState createState() => _CustomInputFieldDialogState();
}

class _CustomInputFieldDialogState extends State<CustomInputFieldDialog> {
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.title),
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: TextField(
          onChanged: (value) {
            setState(() {
              print(value);
              widget.caption(value);
              // valueText = value;
            });
          },
          controller: widget.textEditingController,
          decoration: InputDecoration(hintText: widget.hint),
        ),
        actions: <Widget>[
          MaterialButton(
            textColor: Colors.white,
            child:
                Text(widget.no, style: CustomTextStyle.mobileNumberTextStyle),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          MaterialButton(
            textColor: Colors.white,
            child:
                Text(widget.yes, style: CustomTextStyle.mobileNumberTextStyle),
            onPressed: () {
              widget.yesOnPressed();
              setState(() {
                print('Ok pressed');
                // codeDialog = valueText;
                Navigator.of(context).pop(true);
              });
            },
          ),
        ],
      );
}
