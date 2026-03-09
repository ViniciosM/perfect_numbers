// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PerfectNum';

  @override
  String get appSubtitle => 'Explore the beauty of perfect numbers';

  @override
  String get tabCheck => 'Check';

  @override
  String get tabRange => 'Range';

  @override
  String get tabHistory => 'History';

  @override
  String get checkInputLabel => 'Enter a number';

  @override
  String get checkInputHint => 'e.g. 28';

  @override
  String get checkButton => 'Check';

  @override
  String get checkInfoText =>
      'A perfect number equals the sum of its proper divisors.\nExamples: 6, 28, 496, 8128';

  @override
  String get resultIsPerfect => '✨ Perfect Number!';

  @override
  String get resultIsNotPerfect => 'Not a Perfect Number';

  @override
  String resultDivisorsEqual(String divisors, int number) {
    return 'Divisors: $divisors = $number';
  }

  @override
  String resultDivisorsNotEqual(String divisors, int sum, int number) {
    return 'Sum of divisors: $divisors = $sum ≠ $number';
  }

  @override
  String get rangeFromLabel => 'From';

  @override
  String get rangeToLabel => 'To';

  @override
  String get rangeFromHint => '1';

  @override
  String get rangeToHint => '10000';

  @override
  String get rangeFindButton => 'Find Perfect Numbers';

  @override
  String rangeResultSummary(int count, int start, int end) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count perfect number$_temp0 found between $start and $end';
  }

  @override
  String rangeNoResults(int start, int end) {
    return 'No perfect numbers found\nbetween $start and $end';
  }

  @override
  String get rangeEmptyTitle => 'Enter a range to discover\nperfect numbers';

  @override
  String get rangeEmptyTip => 'Tip: try 1 → 10000 to find 6, 28, 496, 8128';

  @override
  String historyChecked(String input) {
    return 'Checked: $input';
  }

  @override
  String historyRange(String input) {
    return 'Range: $input';
  }

  @override
  String historyResult(String result) {
    return 'Result: $result';
  }

  @override
  String get historyEmpty => 'No searches yet.\nCheck or find a number first!';

  @override
  String get loading => 'Calculating...';

  @override
  String get errorInvalidNumber => 'Please enter a valid number.';

  @override
  String get errorInvalidRange => 'Please enter valid numbers.';

  @override
  String get errorStartBeforeEnd => 'Start must be less than end.';
}
