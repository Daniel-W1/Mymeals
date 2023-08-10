import 'package:go_router/go_router.dart';
import 'package:my_meals/common/loading_screen.dart';
import 'package:my_meals/features/authentication/application/auth_provider.dart';
import 'package:my_meals/features/authentication/presentation/login_screen.dart';
import 'package:my_meals/features/authentication/presentation/register_screen.dart';
import 'package:my_meals/features/discount/application/discount_provider.dart';
import 'package:my_meals/features/discount/presentation/discount_screen.dart';
import 'package:my_meals/features/home/presentation/home_screen.dart';
import 'package:my_meals/features/location/application/location_provider.dart';
import 'package:my_meals/features/meals/presentation/meal_screen.dart';
import 'package:my_meals/features/pickforme/presentation/pick_screen.dart';
import 'package:my_meals/features/restaurants/application/restaurant_provider.dart';
import 'package:my_meals/features/restaurants/presentation/restaurant_screen.dart';
import 'package:provider/provider.dart';

import '../../common/nothing_screen.dart';
import '../meals/application/meal_provider.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => HomeScreen(),
    redirect: (context, state) {
      final authProvider = context.read<AuthProvider>();
      return authProvider.isSignedIn ? '/' : '/signin';
    },
  ),
  GoRoute(
    path: '/signin',
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    path: '/signup',
    builder: (context, state) => SignupScreen(),
  ),
  GoRoute(
    path: '/meals',
    builder: (context, state) => const MealsScreen(),
    redirect: (context, state) async {
      final resProvider = context.read<RestaurantProvider>();
      final locationProvider = context.read<LocationProvider>();

      var loca = locationProvider.currentLocation;

      if (loca == null) {
        await locationProvider.syncLocation(context);
        loca = locationProvider.currentLocation;
      }

      print('so the location we got is $loca');
      final mealProvider = context.read<MealProvider>();

      if (resProvider.restaurants == null) {
        await resProvider.getRestaurants(loca!.latitude, loca.longitude);
      }
      print(resProvider.restaurants!);

      if (mealProvider.meals!.isEmpty && resProvider.restaurants!.isNotEmpty) {
        await mealProvider.prepareMealspage(resProvider.restaurants!);
      }

      return resProvider.restaurants != null ? '/meals' : '/waiting';
    },
  ),
  GoRoute(
    path: '/restaurants',
    builder: (context, state) => RestaurantsPage(),
    redirect: (context, state) async {
      final resProvider = context.read<RestaurantProvider>();
      final locationProvider = context.read<LocationProvider>();

      if (locationProvider.currentLocation == null) {
        await locationProvider.syncLocation(context);
      }
      final loca = locationProvider.currentLocation!;
      if (resProvider.restaurants == null) {
        await resProvider.getRestaurants(loca.latitude, loca.longitude);
      }

      return resProvider.restaurants != null ? '/restaurants' : '/waiting';
    },
  ),
  GoRoute(
    path: '/pickforme',
    builder: (context, state) => const PickScreen(),
    redirect: (context, state) async {
      print('we are herere --------------------------------------------');
      final mealProvider = context.read<MealProvider>();
      final authProvider = context.read<AuthProvider>();
      final user_id = authProvider.user!.uid;

      if (mealProvider.topFiveMeals!.isEmpty) {
        final res = await mealProvider.getTopFiveMeals(user_id);

        print(res);
      }

      return mealProvider.topFiveMeals != null ? '/pickforme' : '/waiting';
    },
  ),
  GoRoute(
    path: '/discounts',
    builder: (context, state) => const DiscountScreen(),
    redirect: (context, state) async {
      final discountProvider = context.read<DiscountProvider>();
      final resProvider = context.read<RestaurantProvider>();
      final locationProvider = context.read<LocationProvider>();

      if (locationProvider.currentLocation == null) {
        await locationProvider.syncLocation(context);
      }

      print('here finding location');
      if (resProvider.restaurants == null) {
        await resProvider.getRestaurants(
            locationProvider.currentLocation!.latitude,
            locationProvider.currentLocation!.longitude);
      }

      print('here finding discount');
      if (discountProvider.restuarants_with_discount.isEmpty) {
        await discountProvider.getDiscountRestuarants(resProvider.restaurants!);
      }

      print(discountProvider.restuarants_with_discount);
      print('-----------------------------------------');

      return discountProvider.restuarants_with_discount.isNotEmpty
          ? '/discounts'
          : '/nothing';
    },
  ),
  GoRoute(path: '/waiting', builder: (context, state) => WaitingScreen()),
  GoRoute(
      path: '/nothing',
      builder: (context, state) =>
          const NothingScreen(message: 'Not available Today'))
]);
