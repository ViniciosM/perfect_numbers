import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_cubit.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_state.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/screens/history_screen.dart';
import '../../../../helpers/mock_repository.dart';
import '../../../../helpers/test_app_wrapper.dart';

class MockPerfectNumberCubit extends MockCubit<PerfectNumberState>
    implements PerfectNumberCubit {}

void main() {
  late MockPerfectNumberCubit mockCubit;

  setUp(() {
    registerFallbacks();
    mockCubit = MockPerfectNumberCubit();
    when(() => mockCubit.state).thenReturn(const PerfectNumberLoading());
    when(() => mockCubit.loadHistory()).thenAnswer((_) async {});
  });

  Widget buildSubject() =>
      TestAppWrapper(cubit: mockCubit, child: const HistoryScreen());

  group('HistoryScreen', () {
    testWidgets('shows loading indicator on initial state', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows list when HistoryLoaded with records', (tester) async {
      when(() => mockCubit.state).thenReturn(
        HistoryLoaded(
          records: [
            SearchRecordEntity(
              id: 1,
              type: 'check',
              input: '6',
              result: 'true',
              createdAt: DateTime(2024, 1, 1, 10, 30),
            ),
            SearchRecordEntity(
              id: 2,
              type: 'range',
              input: '1-100',
              result: '6, 28',
              createdAt: DateTime(2024, 1, 2, 14, 0),
            ),
          ],
        ),
      );

      await tester.pumpWidget(buildSubject());

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byIcon(Icons.search_rounded), findsOneWidget);
      expect(find.byIcon(Icons.travel_explore_rounded), findsOneWidget);
    });

    testWidgets('shows empty state when HistoryLoaded with no records', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(HistoryLoaded(records: const []));

      await tester.pumpWidget(buildSubject());

      expect(find.text('🕓', findRichText: true), findsOneWidget);
    });

    testWidgets('calls loadHistory on init', (tester) async {
      await tester.pumpWidget(buildSubject());

      verify(() => mockCubit.loadHistory()).called(1);
    });
  });
}
