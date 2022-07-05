import 'package:flutter/material.dart';

class IconedButtonWidget extends StatelessWidget {
  final IconData? icon;
  final ImageIcon? imageIcon;
  final String title;
  final Function onTap;

  const IconedButtonWidget(
      {Key? key, this.icon, this.imageIcon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? Icon(
              icon,
              color: Colors.white,
            ) : imageIcon!,
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      onTap: () => onTap(),
    );
  }
}
