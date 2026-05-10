import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollux/src/core/theme/app_theme.dart';

class FlashDealBanner extends StatefulWidget {
  const FlashDealBanner({super.key});

  @override
  State<FlashDealBanner> createState() => _FlashDealBannerState();
}

class _FlashDealBannerState extends State<FlashDealBanner> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = 8 * 3600 + 42 * 60 + 17;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final h = _remainingSeconds ~/ 3600;
    final m = (_remainingSeconds % 3600) ~/ 60;
    final s = _remainingSeconds % 60;
    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFB84C1E), AppColors.primary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flash Deal',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Today\'s top offers',
                  style: GoogleFonts.dmSans(
                    fontSize: 11, color: Colors.white70,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formattedTime,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white,
                  ),
                ),
                Text(
                  'ENDS IN',
                  style: GoogleFonts.dmSans(
                    fontSize: 9, letterSpacing: 1, color: Colors.white60,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
