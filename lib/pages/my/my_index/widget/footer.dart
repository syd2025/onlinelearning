import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final style =
        Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey);
    return <Widget>[
      Text("www.onlinelearning.com", style: style),
      SizedBox(height: 2),
      Text(LocaleKeys.profileFooter.tr, style: style),
      SizedBox(height: 10),
    ].toColumn();
  }
}
