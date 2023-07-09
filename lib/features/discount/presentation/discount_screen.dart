import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_meals/features/discount/application/discount_provider.dart';
import 'package:my_meals/features/discount/domain/discount.dart';
import 'package:my_meals/features/discount/presentation/discount_card.dart';
import 'package:provider/provider.dart';

List<String> discountKeywords = [
  'Discount',
  'Sale',
  'Deal',
  'Special offer',
  'Promotional price',
  'Clearance',
  'Markdown',
  'Coupon',
  'Promo code',
  'Bargain',
  'Reduced price',
  'Savings',
  'Limited time offer',
  'Flash sale',
  'Percent off',
  'Bonus',
  'Free',
  'Price drop',
  'Exclusive offer',
  'Best price',
  'Hot deal',
  'Last chance',
  'Steal',
  'Massive savings',
  'Unbeatable prices',
  'Clearance sale',
  'Mega sale',
  'Extra discount',
  'Doorbuster deal',
  'Big savings',
];

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurants =
        context.read<DiscountProvider>().restuarants_with_discount;

    final discounts = restaurants.map((restaurant) {
      return Discount(
        name: discountKeywords[Random().nextInt(discountKeywords.length)],
        restaurant: restaurant,
      );
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Discount'),
          leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView.builder(
          itemCount: discounts.length,
          itemBuilder: (context, index) {
            return DiscountCard(
                discountInfo: discounts[index].name,
                restaurantName: discounts[index].restaurant.name,
                restaurantAddress: discounts[index].restaurant.address,
                imageUrl: discounts[index].restaurant.imageUrl);
          },
        ));
  }
}
