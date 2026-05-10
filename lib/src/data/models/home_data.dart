import 'package:flutter/material.dart';
import 'package:pollux/src/core/theme/app_theme.dart';
import '../models/models.dart';

abstract final class HomeData {
  static const heroCameras = [
    HeroCamera(
      name: 'Canon R5 II',
      price: '₹3,20,000',
      bgColor: Color(0xFF1A1410),
    ),
    HeroCamera(
      name: 'Sony A7 IV',
      price: '₹2,45,000',
      bgColor: Color(0xFF18181F),
    ),
    HeroCamera(
      name: 'Nikon Z8',
      price: '₹3,80,000',
      bgColor: Color(0xFF101420),
    ),
  ];

  static const categories = [
    CategoryModel(name: 'Cameras', icon: Icons.camera_alt_outlined),
    CategoryModel(name: 'Lenses', icon: Icons.lens_outlined),
    CategoryModel(name: 'Lighting', icon: Icons.lightbulb_outline),
    CategoryModel(name: 'Accessories', icon: Icons.battery_charging_full_outlined),
    CategoryModel(name: 'Bags', icon: Icons.work_outline),
    CategoryModel(name: 'Drones', icon: Icons.flight_outlined),
    CategoryModel(name: 'Tripods', icon: Icons.camera_outlined),
  ];

  static final steps = [
    StepModel(
      number: '01',
      title: 'Browse Gear',
      description: 'Filter by brand, sensor size, or budget',
      icon: Icons.search_rounded,
      iconBg: AppColors.lightOrange,
      iconColor: AppColors.primary,
    ),
    StepModel(
      number: '02',
      title: 'Add to Cart',
      description: 'Compare specs and read expert reviews',
      icon: Icons.shopping_cart_outlined,
      iconBg: Color(0xFFFFE8D6),
      iconColor: Color(0xFFCC5500),
    ),
    StepModel(
      number: '03',
      title: 'Fast Delivery',
      description: '48hr doorstep delivery, fully insured',
      icon: Icons.local_shipping_outlined,
      iconBg: AppColors.lightTeal,
      iconColor: AppColors.secondary,
    ),
    StepModel(
      number: '04',
      title: 'Start Shooting',
      description: 'Warranty included, free 7-day returns',
      icon: Icons.camera_alt_rounded,
      iconBg: Color(0xFFE0EDE0),
      iconColor: Color(0xFF2E6B2E),
    ),
  ];

  static final products = [
    ProductModel(
      id: '1',
      brand: 'Canon',
      name: 'EOS R5 Mark II',
      specs: ['45MP', '8K RAW', 'IBIS'],
      price: 320000,
      originalPrice: 365000,
      tag: 'BEST SELLER',
      tagColor: AppColors.primary,
      icon: Icons.camera_alt_rounded,
    ),
    ProductModel(
      id: '2',
      brand: 'Sony',
      name: 'Alpha A7R V',
      specs: ['61MP', '4K 120fps', 'AI AF'],
      price: 245000,
      originalPrice: 280000,
      tag: 'NEW',
      tagColor: AppColors.secondary,
      icon: Icons.camera_rounded,
    ),
    ProductModel(
      id: '3',
      brand: 'Sigma',
      name: '85mm f/1.4 Art',
      specs: ['Full Frame', 'Bokeh', 'HSM AF'],
      price: 77000,
      originalPrice: 110000,
      tag: '-30%',
      tagColor: Color(0xFFB84C1E),
      icon: Icons.lens_rounded,
    ),
    ProductModel(
      id: '4',
      brand: 'Nikon',
      name: 'Z8 Mirrorless',
      specs: ['45.7MP', '8K RAW', 'Dual Card'],
      price: 380000,
      originalPrice: 420000,
      tag: 'PRO',
      tagColor: AppColors.secondary,
      icon: Icons.camera_alt_outlined,
    ),
  ];

  static const brands = ['Canon', 'Nikon', 'Sony', 'Fujifilm', 'Sigma'];

  static const testimonials = [
    _Testimonial(
      initials: 'AR',
      name: 'Arjun Reddy',
      role: 'Wedding Photographer, Hyderabad',
      text:
          '"Ordered the Sony A7 IV and it arrived next day, perfectly packed. Their lens rental saved me ₹2 lakh before I committed to buying."',
      stars: 5,
    ),
    _Testimonial(
      initials: 'PK',
      name: 'Priya Kumar',
      role: 'Wildlife Photographer, Chennai',
      text:
          '"The Sigma 85mm Art lens I rented blew me away. Bought it the next week. FrameCraft made it so easy and affordable."',
      stars: 5,
    ),
  ];
}

class _Testimonial {
  final String initials;
  final String name;
  final String role;
  final String text;
  final int stars;

  const _Testimonial({
    required this.initials,
    required this.name,
    required this.role,
    required this.text,
    required this.stars,
  });
}
