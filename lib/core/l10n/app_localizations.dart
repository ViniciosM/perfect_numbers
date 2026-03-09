import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

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
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'PerfectNum'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore the beauty of perfect numbers'**
  String get appSubtitle;

  /// No description provided for @tabCheck.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get tabCheck;

  /// No description provided for @tabRange.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get tabRange;

  /// No description provided for @tabHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get tabHistory;

  /// No description provided for @checkInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter a number'**
  String get checkInputLabel;

  /// No description provided for @checkInputHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 28'**
  String get checkInputHint;

  /// No description provided for @checkButton.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get checkButton;

  /// No description provided for @checkInfoText.
  ///
  /// In en, this message translates to:
  /// **'A perfect number equals the sum of its proper divisors.\nExamples: 6, 28, 496, 8128'**
  String get checkInfoText;

  /// No description provided for @resultIsPerfect.
  ///
  /// In en, this message translates to:
  /// **'✨ Perfect Number!'**
  String get resultIsPerfect;

  /// No description provided for @resultIsNotPerfect.
  ///
  /// In en, this message translates to:
  /// **'Not a Perfect Number'**
  String get resultIsNotPerfect;

  /// No description provided for @resultDivisorsEqual.
  ///
  /// In en, this message translates to:
  /// **'Divisors: {divisors} = {number}'**
  String resultDivisorsEqual(String divisors, int number);

  /// No description provided for @resultDivisorsNotEqual.
  ///
  /// In en, this message translates to:
  /// **'Sum of divisors: {divisors} = {sum} ≠ {number}'**
  String resultDivisorsNotEqual(String divisors, int sum, int number);

  /// No description provided for @rangeFromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get rangeFromLabel;

  /// No description provided for @rangeToLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get rangeToLabel;

  /// No description provided for @rangeFromHint.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get rangeFromHint;

  /// No description provided for @rangeToHint.
  ///
  /// In en, this message translates to:
  /// **'10000'**
  String get rangeToHint;

  /// No description provided for @rangeFindButton.
  ///
  /// In en, this message translates to:
  /// **'Find Perfect Numbers'**
  String get rangeFindButton;

  /// No description provided for @rangeResultSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} perfect number{count, plural, one{} other{s}} found between {start} and {end}'**
  String rangeResultSummary(int count, int start, int end);

  /// No description provided for @rangeNoResults.
  ///
  /// In en, this message translates to:
  /// **'No perfect numbers found\nbetween {start} and {end}'**
  String rangeNoResults(int start, int end);

  /// No description provided for @rangeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter a range to discover\nperfect numbers'**
  String get rangeEmptyTitle;

  /// No description provided for @rangeEmptyTip.
  ///
  /// In en, this message translates to:
  /// **'Tip: try 1 → 10000 to find 6, 28, 496, 8128'**
  String get rangeEmptyTip;

  /// No description provided for @historyChecked.
  ///
  /// In en, this message translates to:
  /// **'Checked: {input}'**
  String historyChecked(String input);

  /// No description provided for @historyRange.
  ///
  /// In en, this message translates to:
  /// **'Range: {input}'**
  String historyRange(String input);

  /// No description provided for @historyResult.
  ///
  /// In en, this message translates to:
  /// **'Result: {result}'**
  String historyResult(String result);

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No searches yet.\nCheck or find a number first!'**
  String get historyEmpty;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Calculating...'**
  String get loading;

  /// No description provided for @errorInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number.'**
  String get errorInvalidNumber;

  /// No description provided for @errorInvalidRange.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid numbers.'**
  String get errorInvalidRange;

  /// No description provided for @errorStartBeforeEnd.
  ///
  /// In en, this message translates to:
  /// **'Start must be less than end.'**
  String get errorStartBeforeEnd;
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
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
