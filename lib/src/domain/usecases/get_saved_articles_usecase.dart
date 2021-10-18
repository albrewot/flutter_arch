import 'package:design/src/core/usecases/usecase.dart';
import 'package:design/src/domain/entities/article.dart';
import 'package:design/src/domain/repositories/article_repository.dart';

class GetSavedArticlesUseCase implements UseCase<List<Article>, void>{
  final ArticlesRepository _articlesRepository;

  GetSavedArticlesUseCase(this._articlesRepository);

  @override
  Future<List<Article>> call({void params}){
    return _articlesRepository.getSavedArticles();
  }
}
