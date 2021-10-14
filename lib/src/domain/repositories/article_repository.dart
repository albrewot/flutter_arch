import 'package:design/src/core/params/article_request.dart';
import 'package:design/src/core/resources/data_state.dart';
import 'package:design/src/domain/entities/article.dart';

abstract class ArticlesRepository {
  Future<DataState<List<Article>>>? getBreakingNewsArticles(
    ArticlesRequestParams params,
  );
}
