import 'package:flutter_switch/flutter_switch.dart';
import 'package:foap/helper/imports/common_import.dart';
import 'package:foap/screens/settings_menu/account.dart';
import 'package:foap/screens/settings_menu/payment_and_coins.dart';
import 'package:foap/screens/settings_menu/security_privacy_options.dart';
import 'package:foap/screens/settings_menu/settings_controller.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'change_language.dart';
import 'faq_list.dart';
import 'help_screen.dart';
import 'notification_settings.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SettingsController _settingsController = Get.find();
  final UserProfileManager _userProfileManager = Get.find();

  @override
  void initState() {
    super.initState();
    _settingsController.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: AppColorConstants.backgroundColor,
          body: Column(
            children: [
              if (_settingsController.appearanceChanged!.value) Container(),
              const SizedBox(
                height: 50,
              ),
              titleNavigationBar(
                   title: settingsString.tr),
              divider().tP8,
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Column(
                      children: [
                        addTileEvent('assets/language.png',
                            changeLanguageString.tr, '', () {
                          Get.to(() => const ChangeLanguage());
                        }, true),
                        addTileEvent('assets/coins.png',
                            paymentAndCoinsString.tr, '', () {
                          Get.to(() => const PaymentAndCoins());
                        }, true),
                        addTileEvent('assets/account.png',
                            accountString.tr, '', () {
                          Get.to(() => const AppAccount());
                        }, true),
                        addTileEvent('assets/privacy.png',
                            privacyString.tr, '', () {
                          Get.to(() => const PrivacyOptions());
                        }, true),
                        addTileEvent(
                            'assets/settings.png',
                            notificationSettingsString.tr,
                            tuneSettingsString.tr, () {
                          Get.to(() => const AppNotificationSettings());
                        }, true),
                        addTileEvent('assets/faq.png', faqString.tr,
                            faqMessageString.tr, () {
                          Get.to(() => const FaqList());
                        }, true),
                        addTileEvent(
                            'assets/request.png',
                            helpString.tr,
                            faqMessageString.tr, () {
                          Get.to(() => const HelpScreen());
                        }, true),
                        if (_settingsController
                            .setting.value!.enableDarkLightModeSwitch)
                          darkModeTile(),
                        addTileEvent(
                            'assets/share.png',
                            shareString.tr,
                            shareAppSubtitleString.tr, () {
                          Share.share(
                              '${installThisCoolAppString.tr} ${AppConfigConstants.liveAppLink}');
                        }, false),
                        addTileEvent(
                            'assets/logout.png',
                            logoutString.tr,
                            exitAppString.tr, () {
                          AppUtil.showConfirmationAlert(
                              title: logoutString.tr,
                              subTitle: logoutConfirmationString.tr,
                              okHandler: () {
                                _userProfileManager.logout();
                              });
                        }, false),
                        addTileEvent(
                            'assets/delete_account.png',
                            deleteAccountString.tr,
                            deleteAccountSubheadingString.tr, () {
                          AppUtil.showConfirmationAlert(
                              title: deleteAccountString.tr,
                              subTitle:
                                  areYouSureToDeleteAccountString.tr,
                              okHandler: () {
                                _settingsController.deleteAccount();
                              });
                        }, false),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  addTileEvent(String icon, String title, String subTitle, VoidCallback action,
      bool showNextArrow) {
    return InkWell(
        onTap: action,
        child: Column(
          children: [
            SizedBox(
              height: 65,
              child: Row(children: [
                Container(
                        color: AppColorConstants.themeColor.withOpacity(0.2),
                        child: Image.asset(
                          icon,
                          height: 20,
                          width: 20,
                          color: AppColorConstants.themeColor,
                        ).p8)
                    .circular,
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BodyLargeText(title.tr).bP4,
                    ],
                  ),
                ),
                // const Spacer(),
                if (showNextArrow)
                  ThemeIconWidget(
                    ThemeIcon.nextArrow,
                    color: AppColorConstants.iconColor,
                    size: 15,
                  )
              ]).hP16,
            ),
            divider()
          ],
        ));
  }

  darkModeTile() {
    return Column(
      children: [
        SizedBox(
          height: 65,
          child: Row(children: [
            Container(
                    color: AppColorConstants.themeColor.withOpacity(0.2),
                    child: Image.asset(
                      'assets/dark-mode.png',
                      height: 20,
                      width: 20,
                      color: AppColorConstants.themeColor,
                    ).p8)
                .circular,
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [BodyLargeText(darkModeString.tr)],
              ),
            ),
            // const Spacer(),
            Obx(() => FlutterSwitch(
                  inactiveColor: AppColorConstants.disabledColor,
                  activeColor: AppColorConstants.themeColor,
                  width: 50.0,
                  height: 30.0,
                  valueFontSize: 15.0,
                  toggleSize: 20.0,
                  value: _settingsController.darkMode.value,
                  borderRadius: 30.0,
                  padding: 8.0,
                  // showOnOff: true,
                  onToggle: (val) {
                    _settingsController.appearanceModeChanged(val);
                  },
                )),
          ]).hP16,
        ),
        divider()
      ],
    );
  }
}
