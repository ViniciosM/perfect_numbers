import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfect_numbers/core/l10n/app_localizations.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_cubit.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/cubit/perfect_number_state.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/widgets/error_banner_widget.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/widgets/loading_indicator_widget.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/widgets/number_text_field_widget.dart';
import 'package:perfect_numbers/features/perfect_number/presentation/widgets/perfect_check_badge_widget.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    context.read<PerfectNumberCubit>().checkNumber(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InfoCard(icon: Icons.info_outline_rounded, text: l10n.checkInfoText),
          const SizedBox(height: 24),

          NumberTextFieldWidget(
            controller: _controller,
            label: l10n.checkInputLabel,
            hint: l10n.checkInputHint,
            onSubmitted: _check,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _check,
            icon: const Icon(Icons.search_rounded),
            label: Text(l10n.checkButton),
          ),
          const SizedBox(height: 28),

          BlocBuilder<PerfectNumberCubit, PerfectNumberState>(
            builder: (context, state) {
              if (state is PerfectNumberLoading) {
                return const LoadingIndicatorWidget();
              }
              if (state is PerfectNumberError) {
                return ErrorBannerWidget(message: state.message);
              }
              if (state is CheckPerfectNumberSuccess) {
                return PerfectCheckBadgeWidget(
                  isPerfect: state.result.isPerfect,
                  number: state.result.number,
                  divisors: state.result.divisors,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2330),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white30, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white38,
                fontSize: 13,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
