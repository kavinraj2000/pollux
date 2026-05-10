import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollux/src/core/theme/app_theme.dart';
import 'package:pollux/src/presentation/widgets/category_section.dart';
import 'package:pollux/src/presentation/widgets/featured_products.dart';
import 'package:pollux/src/presentation/widgets/flash_deal_banner.dart';
import 'package:pollux/src/presentation/widgets/hero_section.dart';
import 'package:pollux/src/presentation/widgets/other_sections.dart';
import 'package:pollux/src/presentation/widgets/stats_bar.dart';
import 'package:pollux/src/presentation/widgets/steps_section.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const _HomeTab(),
          const _PlaceholderTab(label: 'Shop'),
          const _PlaceholderTab(label: 'Saved'),
          const _PlaceholderTab(label: 'Cart'),
          const _PlaceholderTab(label: 'Profile'),
        ],
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          pinned: true,
          backgroundColor: AppColors.secondary,
          expandedHeight: 0,
          toolbarHeight: 56,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Frame',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: 'Craft',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20, fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'SALE',
                style: GoogleFonts.dmSans(
                  fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search_rounded, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),

        SliverToBoxAdapter(
          child: Column(
            children: const [
              HeroSection(),
              StatsBar(),
              CategorySection(),
              StepsSection(),
              FlashDealBanner(),
              FeaturedProductsSection(),
              BrandsStrip(),
              RentalCard(),
              SizedBox(height: 22),
              TestimonialSection(),
              NewsletterSection(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── PLACEHOLDER TABS ───────────────────────────────────────
class _PlaceholderTab extends StatelessWidget {
  final String label;

  const _PlaceholderTab({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Frame',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white,
                ),
              ),
              TextSpan(
                text: 'Craft',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.secondary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 64,
              color: AppColors.secondary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: GoogleFonts.playfairDisplay(
                fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coming soon',
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── BOTTOM NAV ─────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_outlined, Icons.home_rounded, 'Home'),
      (Icons.camera_alt_outlined, Icons.camera_alt_rounded, 'Shop'),
      (Icons.favorite_outline, Icons.favorite_rounded, 'Saved'),
      (Icons.shopping_cart_outlined, Icons.shopping_cart_rounded, 'Cart'),
      (Icons.person_outline, Icons.person_rounded, 'Profile'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: items.asMap().entries.map((e) {
              final index = e.key;
              final (outlineIcon, filledIcon, label) = e.value;
              final isActive = currentIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isActive ? filledIcon : outlineIcon,
                        size: 22,
                        color: isActive ? AppColors.secondary : AppColors.muted,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        label,
                        style: GoogleFonts.dmSans(
                          fontSize: 10,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                          color: isActive ? AppColors.secondary : AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
