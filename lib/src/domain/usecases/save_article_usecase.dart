import 'package:design/src/core/usecases/usecase.dart';
import 'package:design/src/domain/entities/article.dart';
import 'package:design/src/domain/repositories/article_repository.dart';

class SaveArticleUseCase implements UseCase<void, Article>{
  final ArticlesRepository _articlesRepository;

  SaveArticleUseCase(this._articlesRepository);

  @override
  Future<void> call({Article? params}){
    return _articlesRepository.saveArticle(params!);
  }
}
