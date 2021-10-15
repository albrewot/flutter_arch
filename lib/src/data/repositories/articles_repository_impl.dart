import 'package:design/src/core/params/article_request.dart';
import 'package:design/src/core/resources/data_state.dart';
import 'package:design/src/data/datasources/local/daos/articles_dao.dart';
import 'package:design/src/data/datasources/remote/news_api_service.dart';
import 'package:design/src/domain/entities/article.dart';
import 'package:design/src/domain/repositories/article_repository.dart';
import 'package:dio/dio.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final NewsApiService _newsApiService;

  final ArticlesDao _articlesDao;

  const ArticlesRepositoryImpl(this._newsApiService, this._articlesDao);

  //Remote Articles
  @override
  Future<DataState<List<Article>>> getBreakingNewsArticles(
    ArticlesRequestParams params,
  ) async {
    try {
      final httpResponse = await _newsApiService.getBreakingNewsArticles(
        apiKey: params.apiKey,
        country: params.country,
        category: params.category,
        page: params.page,
        pageSize: params.pageSize,
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data.articles!);
      }
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (error) {
      return DataFailed(error);
    }
  }

  //Db Articles
  @override
  Future<List<Article>> getSavedArticles() async{
    try {
      return _articlesDao.getArticles();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> saveArticle(Article article) async{
    try {
      return _articlesDao.upsertArticle(article);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> removeArticle(Article article) async{
    try {
      return _articlesDao.deleteArticle(article.id!);
    } catch (error) {
      rethrow;
    }
  }
}
