import 'package:flutter/material.dart';

AppBar globalAppBar({Widget? title}) => AppBar(
      title: title,
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.notifications),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.more_vert),
        ),
      ],
    );
