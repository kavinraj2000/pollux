import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollux/src/core/theme/app_theme.dart';
import 'package:pollux/src/data/models/home_data.dart';



class BrandsStrip extends StatelessWidget {
  const BrandsStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: Column(
        children: [
          Text(
            'TRUSTED BRANDS',
            style: GoogleFonts.dmSans(
              fontSize: 10, letterSpacing: 1.5,
              fontWeight: FontWeight.w500, color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: HomeData.brands
                .map(
                  (b) => Text(
                    b,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.border,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// RENTAL CARD
// ─────────────────────────────────────────
class RentalCard extends StatelessWidget {
  const RentalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            // Decorative circle
            Positioned(
              right: -20, bottom: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08), width: 3,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10, bottom: 10,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.06), width: 2,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TRY BEFORE YOU BUY',
                  style: GoogleFonts.dmSans(
                    fontSize: 10, letterSpacing: 1.5,
                    color: Colors.white54, fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Rent Any Gear',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Test top cameras & lenses from ₹499/day.\nNo deposit needed for verified users.',
                  style: GoogleFonts.dmSans(
                    fontSize: 12, color: Colors.white60, height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '25+',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 32, fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'NEW DESTINATIONS EVERY MONTH',
                  style: GoogleFonts.dmSans(
                    fontSize: 9, letterSpacing: 1, color: Colors.white54,
                  ),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.secondary,
                    textStyle: GoogleFonts.dmSans(
                      fontSize: 12, fontWeight: FontWeight.w600,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Browse Rentals →'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// TESTIMONIAL SECTION
// ─────────────────────────────────────────
class TestimonialSection extends StatelessWidget {
  const TestimonialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OUR CUSTOMERS SAY',
            style: GoogleFonts.dmSans(
              fontSize: 10, letterSpacing: 2,
              fontWeight: FontWeight.w500, color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Testimonial',
            style: GoogleFonts.playfairDisplay(
              fontSize: 26, fontWeight: FontWeight.w700,
              color: Colors.white, fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 18),
          _TestimonialCard(
            initials: 'AR',
            name: 'Arjun Reddy',
            role: 'Wedding Photographer, Hyderabad',
            text:
                '"Ordered the Sony A7 IV and it arrived next day, perfectly packed. Their lens rental saved me ₹2 lakh before I committed to buying."',
            stars: 5,
          ),
          const SizedBox(height: 12),
          _TestimonialCard(
            initials: 'PK',
            name: 'Priya Kumar',
            role: 'Wildlife Photographer, Chennai',
            text:
                '"The Sigma 85mm Art lens I rented blew me away. Bought it the next week. FrameCraft made it so easy and affordable."',
            stars: 5,
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String initials;
  final String name;
  final String role;
  final String text;
  final int stars;

  const _TestimonialCard({
    required this.initials,
    required this.name,
    required this.role,
    required this.text,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              stars,
              (_) => const Icon(Icons.star_rounded, color: AppColors.primary, size: 14),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: 13, color: const Color(0xFFC5BDB4),
              height: 1.7, fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary,
                child: Text(
                  initials,
                  style: GoogleFonts.dmSans(
                    fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.dmSans(
                      fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white,
                    ),
                  ),
                  Text(
                    role,
                    style: GoogleFonts.dmSans(
                      fontSize: 11, color: Colors.white38,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// NEWSLETTER SECTION
// ─────────────────────────────────────────
class NewsletterSection extends StatefulWidget {
  const NewsletterSection({super.key});

  @override
  State<NewsletterSection> createState() => _NewsletterSectionState();
}

class _NewsletterSectionState extends State<NewsletterSection> {
  final _controller = TextEditingController();
  bool _subscribed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Grab It Now!',
            style: GoogleFonts.playfairDisplay(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Get exclusive deals, new arrivals & photography tips weekly.',
            style: GoogleFonts.dmSans(
              fontSize: 12, color: Colors.white70, height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          if (_subscribed)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'You\'re subscribed! 🎉',
                    style: GoogleFonts.dmSans(
                      fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'your@email.com',
                      hintStyle: GoogleFonts.dmSans(
                        fontSize: 13, color: Colors.white54,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 11,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white38),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white38),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _subscribed = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Subscribe',
                    style: GoogleFonts.dmSans(
                      fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
