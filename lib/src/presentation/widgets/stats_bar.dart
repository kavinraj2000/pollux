import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollux/src/core/theme/app_theme.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: const [
            _StatItem(value: '2,400+', label: 'PRODUCTS'),
            _Divider(),
            _StatItem(value: '48hr', label: 'DELIVERY'),
            _Divider(),
            _StatItem(value: '12K+', label: 'HAPPY BUYERS'),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.playfairDisplay(
                fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.dmSans(
                fontSize: 10, letterSpacing: 0.8,
                fontWeight: FontWeight.w500, color: AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      width: 0.5, color: AppColors.border, indent: 10, endIndent: 10,
    );
  }
}
