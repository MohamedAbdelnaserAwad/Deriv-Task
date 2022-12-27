
import 'package:flutter/material.dart';
import 'package:price_tracker/core/utils/app_router.dart';

import 'core/utils/route_names.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Price Tracker",
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.priceTracker,
      onGenerateRoute: AppRouter.allRoutes,
    );
  }
}