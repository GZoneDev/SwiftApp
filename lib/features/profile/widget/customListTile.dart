import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final String? trailingIconPath;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? iconColor;
  final Color? trailingIconColor;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.iconPath,
    this.trailingIconPath,
    required this.onTap,
    this.titleColor, // Цвет текста
    this.iconColor, // Цвет иконки
    this.trailingIconColor, // Цвет trailing иконки
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 18, // Ширина области для иконки
        height: 18, // Высота области для иконки
        child: Center(
          child: SvgPicture.asset(
            iconPath, // Путь к иконке
            width: 18,
            height: 18,
            color: iconColor ??
                Color(
                    0xFF000000), // Применяем кастомный цвет или по умолчанию черный
          ),
        ),
      ),
      trailing: trailingIconPath != null
          ? SvgPicture.asset(
              trailingIconPath!, // Путь к иконке для trailing
              width: 6,
              height: 12,
              color: trailingIconColor ??
                  Color(
                      0xFF000000), // Применяем кастомный цвет или по умолчанию черный
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ??
              Color(
                  0xFF000000), // Применяем кастомный цвет или по умолчанию черный
          fontFamily: 'SFProText-Bold.ttf',
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      minVerticalPadding: 0,
      minTileHeight: 0,
      dense: true,
    );
  }
}
