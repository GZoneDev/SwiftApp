import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordInputWidget extends StatefulWidget {
  final double width, height;
  final EdgeInsets margin, padding;
  final String placeholder;

  const PasswordInputWidget({
    super.key,
    required this.placeholder,
    this.width = 278,
    this.height = 42,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.only(bottom: 3, left: 16, right: 44),
  });

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _isObscured = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Container(
            padding: widget.padding,
            child: TextField(
              obscureText: _isObscured,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => setState(() => _isObscured = !_isObscured),
              icon: Icon(
                _isObscured ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                size: 17,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
