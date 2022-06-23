import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant2/data/preferences/preferences_helper.dart';
import 'package:restaurant2/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Dark Theme Test', () {
    test('Expect DarkMode is deactivated', () async {
      SharedPreferences.setMockInitialValues({
        "DARK_THEME": false,
      });

      SharedPreferences pref = await SharedPreferences.getInstance();
      PreferencesHelper helper =
          PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());
      bool isDarkMode = await helper.isDarkTheme;

      expect(isDarkMode, equals(pref.getBool(darkTheme)));
    });

    test('Expect DarkMode is activated', () async {
      SharedPreferences.setMockInitialValues({
        "DARK_THEME": false,
      });

      SharedPreferences pref = await SharedPreferences.getInstance();
      PreferencesHelper helper =
          PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());
      helper.setDarkTheme(true);

      bool isDarkMode = await helper.isDarkTheme;

      // expect in shared preferences
      expect(isDarkMode, equals(pref.getBool(darkTheme)));
    });
  });

  group('Daily Reminder Test', () {
    test('Expect Daily Reminder is deactivated', () async {
      SharedPreferences.setMockInitialValues({
        "DAILY_REMINDER": false,
      });

      SharedPreferences pref = await SharedPreferences.getInstance();
      PreferencesHelper helper =
          PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());
      bool isDailyActivated = await helper.isDailyReminderActive;

      expect(isDailyActivated, equals(pref.getBool(dailyReminder)));
    });

    test('Expect DarkMode is activated', () async {
      SharedPreferences.setMockInitialValues({
        "DAILY_REMINDER": false,
      });

      SharedPreferences pref = await SharedPreferences.getInstance();
      PreferencesHelper helper =
          PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());
      helper.setDailyReminder(true);

      bool isDailyReminderActivated = await helper.isDailyReminderActive;

      // expect in shared preferences
      expect(isDailyReminderActivated, equals(pref.getBool(dailyReminder)));
    });
  });
}
