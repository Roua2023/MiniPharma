import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minipharma/Models/themes.dart';
import 'package:minipharma/Services/notifications_services.dart';


class ServicesThemes {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _savedThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    final isDarkMode = !_loadThemeFromBox();
    _savedThemeToBox(isDarkMode);
    Get.changeTheme(isDarkMode ? Themes.dark : Themes.light);
    NotificationServices().showNotification(
      title: 'Theme Changed',
      body: isDarkMode ? 'Activated Dark Theme' : 'Activated Light Theme',
    );
  }
}
