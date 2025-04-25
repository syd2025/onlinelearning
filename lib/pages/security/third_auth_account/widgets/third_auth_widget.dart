import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class ThirdAuthWidget extends StatelessWidget {
  const ThirdAuthWidget({super.key, required this.icon, required this.title});

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final fontSize =
        (Theme.of(context).appBarTheme.titleTextStyle?.fontSize ?? 20) - 4;
    return Row(
      children: [
        const SizedBox(width: 20),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Center(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
              child: Image.asset(icon, width: 25),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(title, style: TextStyle(fontSize: fontSize)),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextButton(
            onPressed: () {},
            child: Text(
              LocaleKeys.bind.tr,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
