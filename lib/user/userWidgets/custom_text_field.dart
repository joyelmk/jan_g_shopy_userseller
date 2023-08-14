import 'package:flutter/material.dart';


class UserCustomTextField extends StatefulWidget
{
  TextEditingController? textEditingController;
  IconData? iconData;
  String? hintText;
  bool? isObsecre = true;
  bool? enabled = true;

  UserCustomTextField({
    this.textEditingController,
    this.iconData,
    this.hintText,
    this.isObsecre,
    this.enabled,
  });

  @override
  State<UserCustomTextField> createState() => _UserCustomTextFieldState();
}



class _UserCustomTextFieldState extends State<UserCustomTextField>
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.textEditingController,
        obscureText: widget.isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            widget.iconData,
            color: Colors.black,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
