import 'package:design/src/core/params/article_request.dart';
import 'package:design/src/core/resources/data_state.dart';
import 'package:design/src/domain/entities/article.dart';

abstract class ArticlesRepository {

  //Remote Articles
  Future<DataState<List<Article>>>? getBreakingNewsArticles(
    ArticlesRequestParams params,
  );

  //DB Articles
  Future<List<Article>> getSavedArticles();

  Future<void> saveArticle(Article article);

  Future<void> removeArticle(Article article); 
}
