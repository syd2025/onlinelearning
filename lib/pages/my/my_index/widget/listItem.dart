import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.style});

  final IconData icon;
  final String title;
  final GestureTapCallback onTap;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).textTheme.titleLarge?.color,
          size: 20,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 16,
        ),
        title: Text(
          title,
          style: style,
        ),
        onTap: null,
      ),
    );
  }
}
