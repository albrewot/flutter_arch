import 'package:design/src/domain/entities/article.dart';
import 'package:design/src/presentation/views/article_details_view.dart';
import 'package:design/src/presentation/views/breaking_news_view.dart';
import 'package:design/src/presentation/views/saved_articles_view.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _materialRoute(
          const BreakinngNewsView(),
        );
      case "/article-details":
        return _materialRoute(
          ArticleDetailsView(article: settings.arguments as Article?),
        );
      case "/saved-articles":
        return _materialRoute(
          const SavedArticlesView(),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
