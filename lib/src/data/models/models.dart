import 'dart:ui';

import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String brand;
  final String name;
  final List<String> specs;
  final double price;
  final double originalPrice;
  final String tag;
  final Color tagColor;
  final IconData icon;

  const ProductModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.specs,
    required this.price,
    required this.originalPrice,
    required this.tag,
    required this.tagColor,
    required this.icon,
  });

  int get discountPercent =>
      ((1 - price / originalPrice) * 100).round();
}

class CategoryModel {
  final String name;
  final IconData icon;

  const CategoryModel({required this.name, required this.icon});
}

class HeroCamera {
  final String name;
  final String price;
  final Color bgColor;

  const HeroCamera({
    required this.name,
    required this.price,
    required this.bgColor,
  });
}

class StepModel {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  const StepModel({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });
}
