import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfect_numbers/core/theme/app_theme.dart';

class PerfectNumberCardWidget extends StatefulWidget {
  final int number;
  final List<int> divisors;
  final int index;

  const PerfectNumberCardWidget({
    super.key,
    required this.number,
    required this.divisors,
    required this.index,
  });

  @override
  State<PerfectNumberCardWidget> createState() =>
      _PerfectNumberCardWidgetState();
}

class _PerfectNumberCardWidgetState extends State<PerfectNumberCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: Duration(milliseconds: 300 + widget.index * 80),
      vsync: this,
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
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

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: colors.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.number}',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: colors.success,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    '${widget.divisors.join(' + ')} = ${widget.number}',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ),
                Icon(Icons.verified_rounded, color: colors.success, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
