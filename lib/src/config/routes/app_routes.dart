import 'package:design/src/presentation/views/breaking_news_view.dart';
import 'package:design/src/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _materialRoute(
          const BreakinngNewsView(),
        );
      case "/article-details-view":
        return _materialRoute(
          const HomeView(),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
