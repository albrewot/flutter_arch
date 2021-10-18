import 'package:design/src/core/bloc/bloc_with_state.dart';
import 'package:design/src/domain/entities/article.dart';
import 'package:design/src/domain/usecases/get_saved_articles_usecase.dart';
import 'package:design/src/domain/usecases/remove_article_usecase.dart';
import 'package:design/src/domain/usecases/save_article_usecase.dart';
import 'package:equatable/equatable.dart';
part './local_articles_events.dart';
part './local_articles_states.dart';

class LocalArticlesBloc
    extends BlocWithState<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticlesBloc(
    this._getSavedArticlesUseCase,
    this._removeArticleUseCase,
    this._saveArticleUseCase,
  ) : super(
          const LocalArticlesLoading(),
        );

  @override
  Stream<LocalArticlesState> mapEventToState(LocalArticlesEvent event) async*{
    if(event is GetAllSavedArticles){
      yield* _getAllSavedArticles();
    }
    if(event is SaveArticle){
      await _saveArticleUseCase(params: event.article);
      yield* _getAllSavedArticles();
    }
    if(event is RemoveArticle){
      await _removeArticleUseCase(params: event.article);
      yield* _getAllSavedArticles();
    }
  }

  Stream<LocalArticlesState> _getAllSavedArticles() async*{
    final articles = await _getSavedArticlesUseCase();
    yield LocalArticlesDone(articles);
  }
}
