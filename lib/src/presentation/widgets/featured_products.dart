import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollux/src/core/theme/app_theme.dart';
import 'package:pollux/src/data/models/home_data.dart';
import 'package:pollux/src/data/models/models.dart';
import 'section_header.dart';

class FeaturedProductsSection extends StatefulWidget {
  const FeaturedProductsSection({super.key});

  @override
  State<FeaturedProductsSection> createState() =>
      _FeaturedProductsSectionState();
}

class _FeaturedProductsSectionState extends State<FeaturedProductsSection> {
  final Set<String> _cartAdded = {};

  void _handleCart(String id) {
    setState(() => _cartAdded.add(id));
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _cartAdded.remove(id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Featured',
          titleAccent: 'Gear',
          actionLabel: 'View all',
          onAction: () {},
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: HomeData.products
                .map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ProductCard(
                        product: p,
                        isAdded: _cartAdded.contains(p.id),
                        onCart: () => _handleCart(p.id),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isAdded;
  final VoidCallback onCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.isAdded,
    required this.onCart,
  });

  String _formatPrice(double price) {
    final formatted = price.toStringAsFixed(0);
    final result = StringBuffer();
    int counter = 0;
    for (int i = formatted.length - 1; i >= 0; i--) {
      if (counter > 0 && counter % 2 == 0 && i != 0) result.write(',');
      result.write(formatted[i]);
      counter++;
    }
    return '₹${result.toString().split('').reversed.join()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          // Image placeholder
          Container(
            width: 110,
            height: 115,
            color: AppColors.secondary.withOpacity(0.08),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    product.icon,
                    size: 52,
                    color: AppColors.secondary.withOpacity(0.3),
                  ),
                ),
                Positioned(
                  top: 8, left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: product.tagColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product.tag,
                      style: GoogleFonts.dmSans(
                        fontSize: 9, color: Colors.white, fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand.toUpperCase(),
                    style: GoogleFonts.dmSans(
                      fontSize: 10, letterSpacing: 0.8,
                      fontWeight: FontWeight.w500, color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.name,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: product.specs
                        .map((s) => _SpecChip(label: s))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatPrice(product.originalPrice),
                            style: GoogleFonts.dmSans(
                              fontSize: 11, color: AppColors.muted,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            _formatPrice(product.price),
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 17, fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: isAdded ? AppColors.secondary : AppColors.ink,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            isAdded ? Icons.check_rounded : Icons.add_rounded,
                            color: isAdded ? AppColors.primary : Colors.white,
                            size: 18,
                          ),
                          onPressed: onCart,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final String label;

  const _SpecChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.muted),
      ),
    );
  }
}
