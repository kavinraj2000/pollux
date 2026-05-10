import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollux/src/core/theme/app_theme.dart';
import 'package:pollux/src/data/models/home_data.dart';


class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 22, 18, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Browse',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.ink,
                ),
              ),
              Text(
                'All categories',
                style: GoogleFonts.dmSans(
                  fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 82,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: HomeData.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final cat = HomeData.categories[index];
              final isActive = _selected == index;
              return GestureDetector(
                onTap: () => setState(() => _selected = index),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? AppColors.secondary : AppColors.card,
                        border: Border.all(
                          color: isActive ? AppColors.secondary : AppColors.border,
                          width: 0.5,
                        ),
                      ),
                      child: Icon(
                        cat.icon,
                        size: 24,
                        color: isActive ? AppColors.primary : AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      cat.name,
                      style: GoogleFonts.dmSans(
                        fontSize: 10,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                        color: isActive ? AppColors.secondary : AppColors.muted,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
