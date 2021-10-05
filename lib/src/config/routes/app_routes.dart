import 'package:design/src/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _materialRoute(
          const HomeView(),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
