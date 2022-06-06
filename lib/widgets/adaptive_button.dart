import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({required this.text, required this.handler, Key? key})
      : super(key: key);
  final String text;
  final VoidCallback handler;
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(child: Text(text), onPressed: handler)
        : ElevatedButton(onPressed: handler, child: Text(text));
  }
}
