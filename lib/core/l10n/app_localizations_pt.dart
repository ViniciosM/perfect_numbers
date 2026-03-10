// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'PerfectNum';

  @override
  String get appSubtitle => 'Explore a beleza dos números perfeitos';

  @override
  String get tabCheck => 'Verificar';

  @override
  String get tabRange => 'Intervalo';

  @override
  String get tabHistory => 'Histórico';

  @override
  String get checkInputLabel => 'Digite um número';

  @override
  String get checkInputHint => 'ex: 28';

  @override
  String get checkButton => 'Verificar';

  @override
  String get checkInfoText =>
      'Um número perfeito é igual à soma de seus divisores próprios.\nExemplos: 6, 28, 496, 8128';

  @override
  String get resultIsPerfect => '✨ Número Perfeito!';

  @override
  String get resultIsNotPerfect => 'Não é um Número Perfeito';

  @override
  String resultDivisorsEqual(String divisors, int number) {
    return 'Divisores: $divisors = $number';
  }

  @override
  String resultDivisorsNotEqual(String divisors, int sum, int number) {
    return 'Soma dos divisores: $divisors = $sum ≠ $number';
  }

  @override
  String get rangeFromLabel => 'De';

  @override
  String get rangeToLabel => 'Até';

  @override
  String get rangeFromHint => '1';

  @override
  String get rangeToHint => '10000';

  @override
  String get rangeFindButton => 'Buscar Números Perfeitos';

  @override
  String rangeResultSummary(int count, int start, int end) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    String _temp2 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count número$_temp0 perfeito$_temp1 encontrado$_temp2 entre $start e $end';
  }

  @override
  String rangeNoResults(int start, int end) {
    return 'Nenhum número perfeito encontrado\nentre $start e $end';
  }

  @override
  String get rangeEmptyTitle =>
      'Digite um intervalo para descobrir\nnúmeros perfeitos';

  @override
  String get rangeEmptyTip =>
      'Dica: tente 1 → 10000 para encontrar 6, 28, 496, 8128';

  @override
  String historyChecked(String input) {
    return 'Verificado: $input';
  }

  @override
  String historyRange(String input) {
    return 'Intervalo: $input';
  }

  @override
  String historyResult(String result) {
    return 'Resultado: $result';
  }

  @override
  String get historyEmpty =>
      'Nenhuma busca ainda.\nVerifique ou encontre um número primeiro!';

  @override
  String get loading => 'Calculando...';

  @override
  String get errorInvalidNumber => 'Por favor, insira um número válido.';

  @override
  String get errorInvalidRange => 'Por favor, insira números válidos.';

  @override
  String get errorStartBeforeEnd => 'O início deve ser menor que o fim.';

  @override
  String get resultLargeNumberPerfect =>
      'Este é um número perfeito.\n(Divisores omitidos — número muito grande para exibir)';

  @override
  String get resultLargeNumberNotPerfect =>
      'Este não é um número perfeito.\n(Divisores omitidos — número muito grande para exibir)';
}
