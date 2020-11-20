import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpDialog extends StatefulWidget {
  final String dialogTitle;
  final List<Widget> dialogBody;
  final List<Widget> dialogActions;

  PopUpDialog({
    @required this.dialogTitle,
    @required this.dialogBody,
    @required this.dialogActions,
  });

  @override
  _PopUpDialogState createState() => _PopUpDialogState();
}

class _PopUpDialogState extends State<PopUpDialog> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(widget.dialogTitle),
        content: SingleChildScrollView(
          child: ListBody(
            children: widget.dialogBody,
          ),
        ),
        actions: widget.dialogActions,
      );
    } else {
      return AlertDialog(
        title: Text(widget.dialogTitle),
        content: SingleChildScrollView(
          child: ListBody(
            children: widget.dialogBody,
          ),
        ),
        actions: widget.dialogActions,
      );
    }
  }
}
