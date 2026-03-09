import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfect_numbers/core/l10n/app_localizations.dart';
import 'package:perfect_numbers/features/perfect_number/domain/entities/search_record_entity.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_cubit.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_state.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/widgets/error_banner_widget.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/widgets/loading_indicator_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PerfectNumberCubit>().loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfectNumberCubit, PerfectNumberState>(
      builder: (context, state) {
        if (state is PerfectNumberLoading) {
          return const LoadingIndicatorWidget();
        }
        if (state is PerfectNumberError) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: ErrorBannerWidget(message: state.message),
          );
        }
        if (state is HistoryLoaded) {
          if (state.records.isEmpty) {
            return _EmptyHistory();
          }
          return _HistoryList(records: state.records);
        }
        return const LoadingIndicatorWidget();
      },
    );
  }
}

class _HistoryList extends StatelessWidget {
  final List<SearchRecordEntity> records;

  const _HistoryList({required this.records});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      itemCount: records.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, i) => _HistoryTile(record: records[i]),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final SearchRecordEntity record;

  const _HistoryTile({required this.record});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primary = Theme.of(context).colorScheme.primary;
    final isCheck = record.type == 'check';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2330),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isCheck ? Icons.search_rounded : Icons.travel_explore_rounded,
              color: primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCheck
                      ? l10n.historyChecked(record.input)
                      : l10n.historyRange(record.input),
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.historyResult(record.result),
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatDate(record.createdAt),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 11,
              color: Colors.white24,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/'
        '${dt.month.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🕓', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(
            l10n.historyEmpty,
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
