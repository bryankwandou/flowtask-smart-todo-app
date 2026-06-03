import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'FlowTask'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get homeTitle;

  /// No description provided for @analyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analyticsTitle;

  /// No description provided for @focusTitle.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get focusTitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @addSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s in your flow?'**
  String get addSubtitle;

  /// No description provided for @createTask.
  ///
  /// In en, this message translates to:
  /// **'Create Task'**
  String get createTask;

  /// No description provided for @emptyState.
  ///
  /// In en, this message translates to:
  /// **'Your flow is clear.'**
  String get emptyState;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search your flow...'**
  String get searchHint;

  /// No description provided for @highPriority.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get highPriority;

  /// No description provided for @medPriority.
  ///
  /// In en, this message translates to:
  /// **'Med'**
  String get medPriority;

  /// No description provided for @lowPriority.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get lowPriority;

  /// No description provided for @upgradePro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradePro;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @totalTasks.
  ///
  /// In en, this message translates to:
  /// **'Total Tasks'**
  String get totalTasks;

  /// No description provided for @completion.
  ///
  /// In en, this message translates to:
  /// **'Completion'**
  String get completion;

  /// No description provided for @peakHour.
  ///
  /// In en, this message translates to:
  /// **'Peak Hour'**
  String get peakHour;

  /// No description provided for @weeklyPerformance.
  ///
  /// In en, this message translates to:
  /// **'Weekly Performance'**
  String get weeklyPerformance;

  /// No description provided for @productivityIQ.
  ///
  /// In en, this message translates to:
  /// **'Productivity IQ'**
  String get productivityIQ;

  /// No description provided for @cognitivePatterns.
  ///
  /// In en, this message translates to:
  /// **'Cognitive Focus Patterns'**
  String get cognitivePatterns;

  /// No description provided for @intelligenceTip.
  ///
  /// In en, this message translates to:
  /// **'Intelligence Tip'**
  String get intelligenceTip;

  /// No description provided for @smartRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Smart Recommendation'**
  String get smartRecommendation;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @securityData.
  ///
  /// In en, this message translates to:
  /// **'Security & Data Deletion'**
  String get securityData;

  /// No description provided for @newTask.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get newTask;

  /// No description provided for @taskHint.
  ///
  /// In en, this message translates to:
  /// **'What needs to be done?'**
  String get taskHint;

  /// No description provided for @detailsHint.
  ///
  /// In en, this message translates to:
  /// **'Add details (optional)'**
  String get detailsHint;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started Free'**
  String get getStarted;

  /// No description provided for @onboarding1Tag.
  ///
  /// In en, this message translates to:
  /// **'TASK INTELLIGENCE'**
  String get onboarding1Tag;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Tame the Chaos'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Sub.
  ///
  /// In en, this message translates to:
  /// **'Organize every task in a minimalist space engineered for clarity. No clutter, just progress.'**
  String get onboarding1Sub;

  /// No description provided for @onboarding2Tag.
  ///
  /// In en, this message translates to:
  /// **'DEEP FOCUS ENGINE'**
  String get onboarding2Tag;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Find Your Flow'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Sub.
  ///
  /// In en, this message translates to:
  /// **'Launch precision sessions tied to any task. Eliminate distractions. Enter the zone.'**
  String get onboarding2Sub;

  /// No description provided for @onboarding3Tag.
  ///
  /// In en, this message translates to:
  /// **'PRODUCTIVITY IQ'**
  String get onboarding3Tag;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Unlock Your Insights'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Sub.
  ///
  /// In en, this message translates to:
  /// **'Discover your peak performance hours and track streaks—automatically.'**
  String get onboarding3Sub;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @registerFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registerFailed;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @todayLabel.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get todayLabel;

  /// No description provided for @flowIQ.
  ///
  /// In en, this message translates to:
  /// **'FLOW IQ'**
  String get flowIQ;

  /// No description provided for @streakLabel.
  ///
  /// In en, this message translates to:
  /// **'STREAK'**
  String get streakLabel;

  /// No description provided for @focusDefense.
  ///
  /// In en, this message translates to:
  /// **'Focus Defense Active: Notifications optimized.'**
  String get focusDefense;

  /// No description provided for @allFilter.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allFilter;

  /// No description provided for @noMatchingTasks.
  ///
  /// In en, this message translates to:
  /// **'No Matching Tasks'**
  String get noMatchingTasks;

  /// No description provided for @captureGoal.
  ///
  /// In en, this message translates to:
  /// **'Capture your next goal below.'**
  String get captureGoal;

  /// No description provided for @adjustFilters.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters.'**
  String get adjustFilters;

  /// No description provided for @authSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start your journey to absolute focus.'**
  String get authSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **'By registering, you agree to our Terms of Service and Privacy Policy.'**
  String get termsAgreement;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
