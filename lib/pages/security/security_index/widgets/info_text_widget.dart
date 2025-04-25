import 'package:flutter/material.dart';

class InfoTextWidget extends StatelessWidget {
  InfoTextWidget(
      {super.key,
      required this.title,
      required this.info,
      required this.onTap});

  String title;
  String info;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style =
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                info,
                style: style,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
