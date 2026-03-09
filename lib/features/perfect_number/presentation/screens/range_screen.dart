import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfect_numbers/core/l10n/app_localizations.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_cubit.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_state.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/widgets/error_banner_widget.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/widgets/loading_indicator_widget.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/widgets/number_text_field_widget.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/widgets/perfect_number_card_widget.dart';

class RangeScreen extends StatefulWidget {
  const RangeScreen({super.key});

  @override
  State<RangeScreen> createState() => _RangeScreenState();
}

class _RangeScreenState extends State<RangeScreen> {
  final _startController = TextEditingController();
  final _endController = TextEditingController();

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  void _find() {
    context.read<PerfectNumberCubit>().findInRange(
      _startController.text,
      _endController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: NumberTextFieldWidget(
                      controller: _startController,
                      label: l10n.rangeFromLabel,
                      hint: l10n.rangeFromHint,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: NumberTextFieldWidget(
                      controller: _endController,
                      label: l10n.rangeToLabel,
                      hint: l10n.rangeToHint,
                      onSubmitted: _find,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: _find,
                icon: const Icon(Icons.travel_explore_rounded),
                label: Text(l10n.rangeFindButton),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),

        Expanded(
          child: BlocBuilder<PerfectNumberCubit, PerfectNumberState>(
            builder: (context, state) {
              if (state is PerfectNumberLoading) {
                return const LoadingIndicatorWidget();
              }
              if (state is PerfectNumberError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ErrorBannerWidget(message: state.message),
                );
              }
              if (state is FindPerfectNumbersSuccess) {
                if (state.results.isEmpty) {
                  return _EmptyRangeResult(
                    start: state.rangeStart,
                    end: state.rangeEnd,
                  );
                }
                return _RangeResults(state: state);
              }
              return const _RangeEmptyState();
            },
          ),
        ),
      ],
    );
  }
}

class _RangeResults extends StatelessWidget {
  final FindPerfectNumbersSuccess state;

  const _RangeResults({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primary = Theme.of(context).colorScheme.primary;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primary.withValues(alpha: 0.3)),
          ),
          child: Text(
            l10n.rangeResultSummary(
              state.results.length,
              state.rangeStart,
              state.rangeEnd,
            ),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              color: primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        for (int i = 0; i < state.results.length; i++)
          PerfectNumberCardWidget(
            key: ValueKey(state.results[i].number),
            number: state.results[i].number,
            divisors: state.results[i].divisors,
            index: i,
          ),
      ],
    );
  }
}

class _EmptyRangeResult extends StatelessWidget {
  final int start;
  final int end;

  const _EmptyRangeResult({required this.start, required this.end});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.search_off_rounded, color: Colors.white24, size: 48),
          const SizedBox(height: 12),
          Text(
            l10n.rangeNoResults(start, end),
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white30,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _RangeEmptyState extends StatelessWidget {
  const _RangeEmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔢', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(
            l10n.rangeEmptyTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white30,
              fontSize: 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.rangeEmptyTip,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white24,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
