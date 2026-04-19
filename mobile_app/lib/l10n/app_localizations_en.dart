// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FlowTask';

  @override
  String get homeTitle => 'Tasks';

  @override
  String get analyticsTitle => 'Analytics';

  @override
  String get focusTitle => 'Focus';

  @override
  String get profileTitle => 'Profile';

  @override
  String get addSubtitle => 'What\'s in your flow?';

  @override
  String get createTask => 'Create Task';

  @override
  String get emptyState => 'Your flow is clear.';

  @override
  String get searchHint => 'Search your flow...';

  @override
  String get highPriority => 'High';

  @override
  String get medPriority => 'Med';

  @override
  String get lowPriority => 'Low';

  @override
  String get upgradePro => 'Upgrade to Pro';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';
}
