import '../helper/color_extension.dart';
import '../helper/imports/common_import.dart';
import '../screens/settings_menu/settings_controller.dart';
import 'constant_util.dart';

final SettingsController settingsController = Get.find();

class AppConfigConstants {
  // Name of app
  static String appName = 'Socialified';

  static String currentVersion = '2.0';
  static const liveAppLink = 'https://www.google.com/';

  static String appTagline = 'Share your day activity with friends';
  static const googleMapApiKey = 'add your google map api key';
  static const razorpayKey = '';

  static const restApiBaseUrl = 'your rest api url';

  static const socketApiBaseUrl = "your socket server url";

  // Chat encryption key -- DO NOT CHANGE THIS
  static const encryptionKey = 'bbC2H19lkVbQDfakxcrtNMQdd0FloLyw';

  // enable encryption -- DO NOT CHANGE THIS
  static const int enableEncryption = 1;

  // chat version
  static const int chatVersion = 1;

  // is demo app
  static const bool isDemoApp = true;

  // parameters for delete chat
  static const secondsInADay = 86400;
  static const secondsInThreeDays = 259200;
  static const secondsInSevenDays = 604800;
}

class DesignConstants {
  static double horizontalPadding = 24;
}

class AppColorConstants {
  static Color themeColor = settingsController.setting.value == null
      ? Colors.blue
      : HexColor.fromHex(settingsController.setting.value!.themeColor!);

  static Color get backgroundColor => isDarkMode
      ? HexColor.fromHex(
          settingsController.setting.value?.bgColorForDarkTheme ?? '000000')
      : HexColor.fromHex(
          settingsController.setting.value?.bgColorForLightTheme ?? 'FFFFFF');

  static Color get cardColor => isDarkMode
      ? HexColor.fromHex('2d3436')
      : HexColor.fromHex('dcdde1').lighten();

  static Color get dividerColor =>
      isDarkMode ? Colors.white.withOpacity(0.2) : Colors.grey.withOpacity(0.2);

  static Color get borderColor =>
      isDarkMode ? Colors.white.withOpacity(0.9) : Colors.grey.withOpacity(0.2);

  static Color get disabledColor =>
      isDarkMode ? Colors.grey.withOpacity(0.2) : Colors.grey.withOpacity(0.2);

  static Color get shadowColor => isDarkMode
      ? Colors.white.withOpacity(0.2)
      : Colors.black.withOpacity(0.2);

  static Color get inputFieldBackgroundColor =>
      isDarkMode ? const Color(0xFF212121) : const Color(0xFFdfe6e9);

  static Color get iconColor => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white.withOpacity(0.8)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForDarkTheme!)
              .withOpacity(0.8)
      : settingsController.setting.value == null
          ? Colors.black
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForLightTheme!)
              .withOpacity(0.8);

  static Color get inputFieldTextColor =>
      isDarkMode ? const Color(0xFFFAFAFA) : const Color(0xFF212121);

  static Color get inputFieldPlaceholderTextColor =>
      isDarkMode ? const Color(0xFF3F434E) : const Color(0xFF9E9E9E);

  static Color get red => isDarkMode ? Colors.red : Colors.red;

  static Color get green => isDarkMode ? Colors.green : Colors.green;

  // text colors

  static Color get grayscale900 => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white
          : HexColor.fromHex(
              settingsController.setting.value!.textColorForDarkTheme!)
      : settingsController.setting.value == null
          ? Colors.black
          : HexColor.fromHex(
              settingsController.setting.value!.textColorForLightTheme!);

  static Color get grayscale800 => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white.withOpacity(0.8)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForDarkTheme!)
              .withOpacity(0.8)
      : settingsController.setting.value == null
          ? Colors.black.withOpacity(0.8)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForLightTheme!)
              .withOpacity(0.8);

  static Color get grayscale700 => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white.withOpacity(0.7)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForDarkTheme!)
              .withOpacity(0.7)
      : settingsController.setting.value == null
          ? Colors.black.withOpacity(0.7)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForLightTheme!)
              .withOpacity(0.7);

  static Color get grayscale600 => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white.withOpacity(0.6)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForDarkTheme!)
              .withOpacity(0.6)
      : settingsController.setting.value == null
          ? Colors.black.withOpacity(0.6)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForLightTheme!)
              .withOpacity(0.6);

  static Color get grayscale500 => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white.withOpacity(0.5)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForDarkTheme!)
              .withOpacity(0.5)
      : settingsController.setting.value == null
          ? Colors.black.withOpacity(0.5)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForLightTheme!)
              .withOpacity(0.5);

  static Color get grayscale400 => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white.withOpacity(0.4)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForDarkTheme!)
              .withOpacity(0.4)
      : settingsController.setting.value == null
          ? Colors.black.withOpacity(0.4)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForLightTheme!)
              .withOpacity(0.4);

  static Color get grayscale300 => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white.withOpacity(0.3)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForDarkTheme!)
              .withOpacity(0.3)
      : settingsController.setting.value == null
          ? Colors.black.withOpacity(0.3)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForLightTheme!)
              .withOpacity(0.3);

  static Color get grayscale200 => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white.withOpacity(0.2)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForDarkTheme!)
              .withOpacity(0.2)
      : settingsController.setting.value == null
          ? Colors.black.withOpacity(0.2)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForLightTheme!)
              .withOpacity(0.2);

  static Color get grayscale100 => isDarkMode
      ? settingsController.setting.value == null
          ? Colors.white.withOpacity(0.1)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForDarkTheme!)
              .withOpacity(0.1)
      : settingsController.setting.value == null
          ? Colors.black.withOpacity(0.1)
          : HexColor.fromHex(
                  settingsController.setting.value!.textColorForLightTheme!)
              .withOpacity(0.1);
}

class DatingProfileConstants {
  static List<String> genders = ['Male', 'Female', 'Other'];
  static List<String> colors = ['Black', 'White', 'Brown'];
  static List<String> religions = [
    'Christians',
    'Muslims',
    'Hindus',
    'Buddhists',
    'Sikhs',
    'Jainism',
    'Judaism'
  ];
  static List<String> maritalStatus = ['Single', 'Married', 'Divorced'];
  static List<String> drinkHabits = ['Regular', 'Planning to quit', 'Socially'];
}
