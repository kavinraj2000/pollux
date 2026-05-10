import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollux/src/core/theme/app_theme.dart';
import 'package:pollux/src/data/models/home_data.dart';
import 'package:pollux/src/data/models/models.dart';


class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 22, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Eyebrow
                Text(
                  'NEW ARRIVALS 2025',
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Capture the\n',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 36, fontWeight: FontWeight.w700,
                          color: Colors.white, height: 1.1,
                        ),
                      ),
                      TextSpan(
                        text: 'World, ',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 36, fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: AppColors.primary, height: 1.1,
                        ),
                      ),
                      TextSpan(
                        text: 'Your Way.',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 36, fontWeight: FontWeight.w700,
                          color: Colors.white, height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Professional cameras, lenses & accessories\ndelivered to your door.',
                  style: GoogleFonts.dmSans(
                    fontSize: 13, color: Colors.white60, height: 1.6,
                  ),
                ),
                const SizedBox(height: 14),
                // Badges
                Row(
                  children: [
                    _HeroBadge(
                      label: '60% off Lenses',
                      borderColor: AppColors.primary,
                      textColor: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    _HeroBadge(
                      label: 'Free Shipping',
                      borderColor: Colors.white30,
                      textColor: Colors.white70,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // CTAs
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Shop Now'),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Rent Gear'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Camera strip
          SizedBox(
            height: 130,
            child: Row(
              children: HomeData.heroCameras
                  .map((c) => Expanded(child: _HeroCameraCard(camera: c)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  final String label;
  final Color borderColor;
  final Color textColor;

  const _HeroBadge({
    required this.label,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 11, fontWeight: FontWeight.w500, color: textColor,
        ),
      ),
    );
  }
}

class _HeroCameraCard extends StatelessWidget {
  final HeroCamera camera;

  const _HeroCameraCard({required this.camera});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 1),
      decoration: BoxDecoration(
        color: camera.bgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          // Camera icon
          Center(
            child: Icon(
              Icons.camera_alt_rounded,
              size: 44,
              color: AppColors.primary.withOpacity(0.25),
            ),
          ),
          // Name label
          Positioned(
            bottom: 8, left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                camera.name,
                style: GoogleFonts.dmSans(
                  fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Price
          Positioned(
            top: 8, right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                camera.price,
                style: GoogleFonts.dmSans(
                  fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
