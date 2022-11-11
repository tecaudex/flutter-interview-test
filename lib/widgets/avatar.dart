import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

getUserAvatar(String? url) {
  return CircleAvatar(
    child: url != null
        ? Image.network(
            url,
            width: 30,
            height: 30,
          )
        : Icon(
            FontAwesomeIcons.image,
          ),
  );
}
