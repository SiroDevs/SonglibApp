import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../repository/local_storage.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/constants/pref_constants.dart';
import '../../utils/date_util.dart';
import '../../widgets/general/toast.dart';

@injectable
class InfoVm with ChangeNotifier {
  late final InfoNavigator navigator;
  final LocalStorage localStorage;

  InfoVm(this.localStorage);

  BuildContext? context;
  AppLocalizations? tr;
  String timeInstalled = "";
  int dateDiff = 0;
  final dateUtility = DateUtil();

  Future<void> init(InfoNavigator screenNavigator) async {
    navigator = screenNavigator;
    tr = AppLocalizations.of(context!)!;
    timeInstalled = localStorage.getPrefString(PrefConstants.dateInstalledKey);
    var dateValue = DateTime.parse(timeInstalled);
    dateDiff = DateTime.now().difference(dateValue).inDays;
  }

  Future<void> goToHowItWorks() async {
    navigator.goToOnboarding();
  }

  Future<void> goToApptore() async {
    final Uri andyUrl = Uri.parse(AppConstants.playstoreLink);
    final Uri iosUrl = Uri.parse(AppConstants.applestoreLink);
    final Uri msUrl = Uri.parse(AppConstants.microsoftstoreLink);

    if (Platform.isAndroid && await canLaunchUrl(andyUrl)) {
      await launchUrl(andyUrl);
    } else if (Platform.isIOS && await canLaunchUrl(iosUrl)) {
      await launchUrl(iosUrl);
    } else if (Platform.isMacOS && await canLaunchUrl(iosUrl)) {
      await launchUrl(iosUrl);
    } else if (Platform.isWindows && await canLaunchUrl(msUrl)) {
      await launchUrl(msUrl);
    }
  }

  Future<void> goToEmail() async {
    final Uri url = Uri.parse('mailto:futuristicken' '@' 'gmail.com');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Future<void> goToCalling() async {
    final Uri url = Uri.parse('tel:+' '254115' '586529');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Future<void> goToSms() async {
    final Uri url = Uri.parse('sms:+'
        '254115'
        '586529'
        '&body=Hi there, I use SongLib app. I am contacting you with regards to');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Future<void> goToWhatsapp() async {
    final Uri url = Uri.parse('https://wa.me/message/CUDWSUFSUJPHN1');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Future<void> goToTelegram() async {
    final Uri url = Uri.parse('https://t.me/JacksiroKe');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Future<void> goToMerchandise() async {
    final Uri url = Uri.parse('https://forms.gle/iMq8GXjMGmUSJg949');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Future<void> copyText(int type) async {
    String text1 = '', text2 = '';
    switch (type) {
      case 0:
        text1 =
            'SongLib is an easy to use app that gives you offline access to your church hymns. '
            'Install it today ${AppConstants.siteLink}';
        text2 = 'App link';
        break;

      case 1:
        text1 = 'futuristicken' '@' 'gmail.com';
        text2 = 'Email address';
        break;

      case 2:
        text1 = '+254' '115' '586' '529';
        text2 = 'Phone number';
        break;
    }

    try {
      await Clipboard.setData(
        ClipboardData(text: text1),
      );
      showToast(
        text: '$text2 ${tr!.textCopied}',
        state: ToastStates.success,
      );
    } catch (_) {}
  }

  Future<void> copyNumber() async {
    try {
      await Clipboard.setData(
        const ClipboardData(text: '+254' '115' '586' '529'),
      );
      showToast(
        text: 'Phone number ${tr!.textCopied}',
        state: ToastStates.success,
      );
    } catch (_) {}
  }

  Future<void> donateViaPaypal() async {
    final Uri url = Uri.parse(AppConstants.donationPaypalLink);
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Future<void> donateViaPaetron() async {
    final Uri url = Uri.parse(AppConstants.donationPatreaonLink);
    if (await canLaunchUrl(url)) await launchUrl(url);
  }
}

abstract class InfoNavigator {
  void goToOnboarding();
  void goToDonation();
}
