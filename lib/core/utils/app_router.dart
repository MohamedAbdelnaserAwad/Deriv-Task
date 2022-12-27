
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_tracker/core/utils/route_names.dart';

import '../../features/price_tracker/presintation/screens/price_tracker_screen.dart';

class AppRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.priceTracker:
        return MaterialPageRoute(builder: (_) => const PriceTrackerScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}
