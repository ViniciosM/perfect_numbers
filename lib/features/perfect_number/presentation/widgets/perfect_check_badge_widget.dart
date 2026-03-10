import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfect_numbers/core/l10n/app_localizations.dart';
import 'package:perfect_numbers/core/theme/app_theme.dart';

class PerfectCheckBadgeWidget extends StatefulWidget {
  final bool isPerfect;
  final int number;
  final List<int> divisors;

  const PerfectCheckBadgeWidget({
    super.key,
    required this.isPerfect,
    required this.number,
    required this.divisors,
  });

  @override
  State<PerfectCheckBadgeWidget> createState() =>
      _PerfectCheckBadgeWidgetState();
}

class _PerfectCheckBadgeWidgetState extends State<PerfectCheckBadgeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final accent = widget.isPerfect ? colors.success : colors.error;
    final l10n = AppLocalizations.of(context)!;
    final sum = widget.divisors.fold(0, (a, b) => a + b);

    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: accent.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(
                widget.isPerfect
                    ? Icons.verified_rounded
                    : Icons.cancel_rounded,
                color: accent,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                widget.isPerfect
                    ? l10n.resultIsPerfect
                    : l10n.resultIsNotPerfect,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
              const SizedBox(height: 8),
              _buildDivisorText(l10n, sum),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivisorText(AppLocalizations l10n, int sum) {
    if (widget.divisors.isEmpty && widget.number > 1000000000) {
      return Text(
        widget.isPerfect
            ? l10n.resultLargeNumberPerfect
            : l10n.resultLargeNumberNotPerfect,
        textAlign: TextAlign.center,
        style: GoogleFonts.spaceGrotesk(
          fontSize: 14,
          color: Colors.white60,
          height: 1.5,
        ),
      );
    }

    return Text(
      widget.isPerfect
          ? l10n.resultDivisorsEqual(widget.divisors.join(' + '), widget.number)
          : l10n.resultDivisorsNotEqual(
              widget.divisors.isEmpty ? '0' : widget.divisors.join(' + '),
              sum,
              widget.number,
            ),
      textAlign: TextAlign.center,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        color: Colors.white60,
        height: 1.5,
      ),
    );
  }
}
