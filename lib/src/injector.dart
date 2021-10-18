import 'package:design/src/data/datasources/local/app_database.dart';
import 'package:design/src/data/datasources/local/daos/articles_dao.dart';
import 'package:design/src/data/datasources/remote/news_api_service.dart';
import 'package:design/src/data/repositories/articles_repository_impl.dart';
import 'package:design/src/domain/repositories/article_repository.dart';
import 'package:design/src/domain/usecases/get_articles_usecase.dart';
import 'package:design/src/domain/usecases/get_saved_articles_usecase.dart';
import 'package:design/src/domain/usecases/remove_article_usecase.dart';
import 'package:design/src/domain/usecases/save_article_usecase.dart';
import 'package:design/src/presentation/blocs/local_articles/local_articles_bloc.dart';
import 'package:design/src/presentation/blocs/remote_articles/remote_articles_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<Dio>(Dio());

  injector.registerSingleton<DatabaseInstance>(DatabaseInstance());

  injector.registerSingleton<ArticlesDao>(ArticlesDao());

  //Dependencies
  injector.registerSingleton<NewsApiService>(
    NewsApiService(
      injector(),
    ),
  );
  injector.registerSingleton<ArticlesRepository>(
    ArticlesRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  //Remote Articles
  injector.registerSingleton<GetArticlesUseCase>(
    GetArticlesUseCase(
      injector(),
    ),
  );

  //Local Articles
  injector.registerSingleton<GetSavedArticlesUseCase>(
    GetSavedArticlesUseCase(
      injector(),
    ),
  );
  injector.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(
      injector(),
    ),
  );
  injector.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(
      injector(),
    ),
  );

  //Blocs
  injector.registerFactory<RemoteArticlesBloc>(
    () => RemoteArticlesBloc(
      injector(),
    ),
  );
  injector.registerFactory<LocalArticlesBloc>(
    () => LocalArticlesBloc(
      injector(),
      injector(),
      injector(),
    ),
  );
}
