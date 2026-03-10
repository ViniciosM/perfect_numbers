import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perfect_numbers/core/l10n/l10n_keys.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/check_perfect_number_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/domain/usecases/find_perfect_numbers_usecase.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_cubit.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_state.dart';
import '../../../../helpers/mock_repository.dart';

void main() {
  late PerfectNumberCubit cubit;
  late MockSaveSearchUsecase mockSaveSearch;
  late MockGetHistoryUsecase mockGetHistory;

  setUp(() {
    registerFallbacks();
    mockSaveSearch = MockSaveSearchUsecase();
    mockGetHistory = MockGetHistoryUsecase();

    when(() => mockSaveSearch(any())).thenAnswer((_) async {});

    cubit = PerfectNumberCubit(
      checkPerfectNumber: CheckPerfectNumberUsecase(),
      findPerfectNumbers: FindPerfectNumbersUsecase(),
      saveSearch: mockSaveSearch,
      getHistory: mockGetHistory,
    );
  });

  tearDown(() => cubit.close());

  group('reset', () {
    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'emits PerfectNumberInitial',
      build: () => cubit,
      act: (c) => c.reset(),
      expect: () => [isA<PerfectNumberInitial>()],
    );
  });

  group('checkNumber', () {
    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'emits [Loading, CheckPerfectNumberSuccess] for perfect number 6',
      build: () => cubit,
      act: (c) => c.checkNumber('6'),
      expect: () => [
        isA<PerfectNumberLoading>(),
        isA<CheckPerfectNumberSuccess>(),
      ],
      verify: (_) {
        verify(() => mockSaveSearch(any())).called(1);
      },
    );

    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'result.isPerfect is true for 6',
      build: () => cubit,
      act: (c) => c.checkNumber('6'),
      expect: () => [
        isA<PerfectNumberLoading>(),
        isA<CheckPerfectNumberSuccess>().having(
          (s) => s.result.isPerfect,
          'isPerfect',
          isTrue,
        ),
      ],
    );

    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'result.isPerfect is false for 12',
      build: () => cubit,
      act: (c) => c.checkNumber('12'),
      expect: () => [
        isA<PerfectNumberLoading>(),
        isA<CheckPerfectNumberSuccess>().having(
          (s) => s.result.isPerfect,
          'isPerfect',
          isFalse,
        ),
      ],
    );

    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'result contains correct divisors for 6',
      build: () => cubit,
      act: (c) => c.checkNumber('6'),
      expect: () => [
        isA<PerfectNumberLoading>(),
        isA<CheckPerfectNumberSuccess>().having(
          (s) => s.result.divisors,
          'divisors',
          equals([1, 2, 3]),
        ),
      ],
    );

    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'emits PerfectNumberError for non-numeric input',
      build: () => cubit,
      act: (c) => c.checkNumber('abc'),
      expect: () => [
        isA<PerfectNumberError>().having(
          (s) => s.message,
          'message',
          equals(L10nKeys.errorInvalidNumber),
        ),
      ],
    );

    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'emits PerfectNumberError for empty input',
      build: () => cubit,
      act: (c) => c.checkNumber(''),
      expect: () => [isA<PerfectNumberError>()],
    );
  });

  group('findInRange', () {
    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'emits [Loading, FindPerfectNumbersSuccess] for range 1–100',
      build: () => cubit,
      act: (c) => c.findInRange('1', '100'),
      expect: () => [
        isA<PerfectNumberLoading>(),
        isA<FindPerfectNumbersSuccess>(),
      ],
      verify: (_) {
        verify(() => mockSaveSearch(any())).called(1);
      },
    );

    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'finds 6 and 28 in range 1–100',
      build: () => cubit,
      act: (c) => c.findInRange('1', '100'),
      expect: () => [
        isA<PerfectNumberLoading>(),
        isA<FindPerfectNumbersSuccess>().having(
          (s) => s.results.map((r) => r.number).toList(),
          'numbers',
          equals([6, 28]),
        ),
      ],
    );

    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'emits FindPerfectNumbersSuccess with empty results for range 7–27',
      build: () => cubit,
      act: (c) => c.findInRange('7', '27'),
      expect: () => [
        isA<PerfectNumberLoading>(),
        isA<FindPerfectNumbersSuccess>().having(
          (s) => s.results,
          'results',
          isEmpty,
        ),
      ],
    );

    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'emits PerfectNumberError when start >= end',
      build: () => cubit,
      act: (c) => c.findInRange('100', '10'),
      expect: () => [
        isA<PerfectNumberError>().having(
          (s) => s.message,
          'message',
          equals(L10nKeys.errorStartBeforeEnd),
        ),
      ],
    );

    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'emits PerfectNumberError for non-numeric inputs',
      build: () => cubit,
      act: (c) => c.findInRange('a', 'b'),
      expect: () => [
        isA<PerfectNumberError>().having(
          (s) => s.message,
          'message',
          equals(L10nKeys.errorInvalidRange),
        ),
      ],
    );
  });

  group('loadHistory', () {
    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'emits [Loading, HistoryLoaded] with records',
      build: () => cubit,
      setUp: () {
        when(() => mockGetHistory()).thenAnswer(
          (_) async => [
            SearchRecordEntity(
              id: 1,
              type: 'check',
              input: '6',
              result: 'true',
              createdAt: DateTime(2024),
            ),
          ],
        );
      },
      act: (c) => c.loadHistory(),
      expect: () => [
        isA<PerfectNumberLoading>(),
        isA<HistoryLoaded>().having(
          (s) => s.records.length,
          'records length',
          equals(1),
        ),
      ],
    );

    blocTest<PerfectNumberCubit, PerfectNumberState>(
      'emits [Loading, HistoryLoaded] with empty list',
      build: () => cubit,
      setUp: () {
        when(() => mockGetHistory()).thenAnswer((_) async => []);
      },
      act: (c) => c.loadHistory(),
      expect: () => [
        isA<PerfectNumberLoading>(),
        isA<HistoryLoaded>().having((s) => s.records, 'records', isEmpty),
      ],
    );
  });
}
