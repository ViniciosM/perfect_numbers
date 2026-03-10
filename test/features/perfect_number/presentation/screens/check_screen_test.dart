import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/perfect_number_result_entity.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_cubit.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_state.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/screens/check_screen.dart';
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
      TestAppWrapper(cubit: mockCubit, child: const CheckScreen());

  group('CheckScreen', () {
    testWidgets('renders input field and check button', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows LoadingIndicator when state is Loading', (tester) async {
      when(() => mockCubit.state).thenReturn(const PerfectNumberLoading());

      await tester.pumpWidget(buildSubject());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows PerfectCheckBadge when CheckPerfectNumberSuccess', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(
        CheckPerfectNumberSuccess(
          result: const PerfectNumberResult(
            number: 6,
            isPerfect: true,
            divisors: [1, 2, 3],
          ),
        ),
      );

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byIcon(Icons.verified_rounded), findsOneWidget);
    });

    testWidgets('shows ErrorBanner when state is PerfectNumberError', (
      tester,
    ) async {
      when(
        () => mockCubit.state,
      ).thenReturn(const PerfectNumberError(message: 'errorInvalidNumber'));

      await tester.pumpWidget(buildSubject());

      expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    });

    testWidgets('calls checkNumber on button tap', (tester) async {
      when(() => mockCubit.checkNumber(any())).thenAnswer((_) async {});

      await tester.pumpWidget(buildSubject());
      await tester.enterText(find.byType(TextField), '6');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(() => mockCubit.checkNumber('6')).called(1);
    });
  });
}
