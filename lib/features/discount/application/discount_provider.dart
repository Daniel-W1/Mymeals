import 'package:flutter/widgets.dart';
import 'package:my_meals/core/services/discount_scrapper.dart';

class DiscountProvider extends ChangeNotifier {
  var _restuarants_with_discount = [];

  List get restuarants_with_discount => _restuarants_with_discount;

  getDiscountRestuarants(restuarants) async {
    for (var restuarant in restuarants) {
      final hasDiscount = await checkForDiscounts(restuarant.webUrl);
      if (hasDiscount) {
        _restuarants_with_discount.add(restuarant);
      }
    }
    notifyListeners();
  }
}
