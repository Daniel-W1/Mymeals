import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_meals/features/authentication/application/auth_provider.dart';
import 'package:my_meals/features/discount/application/discount_provider.dart';
import 'package:my_meals/features/location/application/location_provider.dart';
import 'package:my_meals/features/meals/application/meal_provider.dart';
import 'package:my_meals/features/restaurants/application/restaurant_provider.dart';
import 'package:my_meals/features/routes/app_routes.dart';
import 'package:my_meals/firebase_options.dart';
import 'package:provider/provider.dart';
import 'features/user/application/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider(), lazy: false),
    ChangeNotifierProvider(create: (_) => UserProvider(), lazy: false),
    ChangeNotifierProvider(create: (_) => LocationProvider(), lazy: false),
    ChangeNotifierProvider(create: (_) => RestaurantProvider(), lazy: false),
    ChangeNotifierProvider(create: (_) => MealProvider(), lazy: false),
    ChangeNotifierProvider(create: (_) => DiscountProvider(), lazy: false)
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Meals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
