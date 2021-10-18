part of "./local_articles_bloc.dart";

abstract class LocalArticlesState extends Equatable {
  final List<Article> articles;
  const LocalArticlesState({List<Article>? articles})
      : articles = articles ?? const <Article>[];

  @override
  List<Object> get props => [articles];
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticlesState {
  const LocalArticlesDone(List<Article> articles) : super(articles: articles);
}
