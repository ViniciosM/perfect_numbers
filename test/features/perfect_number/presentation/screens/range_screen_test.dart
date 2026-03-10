import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/perfect_number_result_entity.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_cubit.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_state.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/screens/range_screen.dart';
import '../../../../helpers/mock_repository.dart';
import '../../../../helpers/test_app_wrapper.dart';

class MockPerfectNumberCubit extends MockCubit<PerfectNumberState>
    implements PerfectNumberCubit {}

void main() {
  late MockPerfectNumberCubit mockCubit;

  setUp(() {
    registerFallbacks();
    mockCubit = MockPerfectNumberCubit();
    when(() => mockCubit.state).thenReturn(const PerfectNumberInitial());
  });

  Widget buildSubject() =>
      TestAppWrapper(cubit: mockCubit, child: const RangeScreen());

  group('RangeScreen', () {
    testWidgets('renders two input fields and find button', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows LoadingIndicator when state is Loading', (tester) async {
      when(() => mockCubit.state).thenReturn(const PerfectNumberLoading());

      await tester.pumpWidget(buildSubject());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows results when FindPerfectNumbersSuccess', (tester) async {
      when(() => mockCubit.state).thenReturn(
        FindPerfectNumbersSuccess(
          rangeStart: 1,
          rangeEnd: 100,
          results: [
            const PerfectNumberResult(
              number: 6,
              isPerfect: true,
              divisors: [1, 2, 3],
            ),
            const PerfectNumberResult(
              number: 28,
              isPerfect: true,
              divisors: [1, 2, 4, 7, 14],
            ),
          ],
        ),
      );

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byIcon(Icons.verified_rounded), findsWidgets);
    });

    testWidgets('shows ErrorBanner on error state', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const PerfectNumberError(message: 'errorStartBeforeEnd'));

      await tester.pumpWidget(buildSubject());

      expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    });

    testWidgets('calls findInRange with both inputs on button tap', (
      tester,
    ) async {
      when(() => mockCubit.findInRange(any(), any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildSubject());

      final fields = find.byType(TextField);
      await tester.enterText(fields.first, '1');
      await tester.enterText(fields.last, '100');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(() => mockCubit.findInRange('1', '100')).called(1);
    });
  });
}
