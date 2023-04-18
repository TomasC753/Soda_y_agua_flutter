import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Get.changeThemeMode(
            Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
        icon: const Icon(Icons.light_mode));
  }
}
