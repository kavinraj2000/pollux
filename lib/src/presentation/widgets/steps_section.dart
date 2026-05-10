import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollux/src/core/theme/app_theme.dart';
import 'package:pollux/src/data/models/home_data.dart';
import 'package:pollux/src/data/models/models.dart';

import 'section_header.dart';

class StepsSection extends StatelessWidget {
  const StepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Easy Steps for', titleAccent: 'Shooting'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.4,
            children: HomeData.steps
                .map((step) => _StepCard(step: step))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  final StepModel step;

  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Stack(
        children: [
          // Background step number
          Positioned(
            top: -6, right: 4,
            child: Text(
              step.number,
              style: GoogleFonts.playfairDisplay(
                fontSize: 38,
                fontWeight: FontWeight.w700,
                color: AppColors.border,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: step.iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(step.icon, color: step.iconColor, size: 18),
              ),
              const SizedBox(height: 8),
              Text(
                step.title,
                style: GoogleFonts.dmSans(
                  fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  step.description,
                  style: GoogleFonts.dmSans(
                    fontSize: 10.5, color: AppColors.muted, height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
