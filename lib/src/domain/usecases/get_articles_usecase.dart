import 'package:design/src/core/params/article_request.dart';
import 'package:design/src/core/resources/data_state.dart';
import 'package:design/src/core/usecases/usecase.dart';
import 'package:design/src/domain/entities/article.dart';
import 'package:design/src/domain/repositories/article_repository.dart';

class GetArticlesUseCase implements UseCase<DataState<List<Article>>, ArticlesRequestParams>{
  final ArticlesRepository _articlesRepository;

  GetArticlesUseCase(this._articlesRepository);

  @override
  Future<DataState<List<Article>>>? call({ArticlesRequestParams? params}){
    return _articlesRepository.getBreakingNewsArticles(params!);
  }
}