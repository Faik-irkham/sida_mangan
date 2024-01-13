import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:sida_mangan/data/preference/schedulling_preference.dart';
import 'package:sida_mangan/utils/background_service.dart';
import 'package:sida_mangan/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  SchedulingPref schedulingPref = SchedulingPref();
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRecomendations(bool value) async {
    _isScheduled = value;
    schedulingPref.setScheduling(value);
    notifyListeners();

    if (_isScheduled) {
      log('Schedulling Recomendations Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      log('Schedulling Recomendations Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
