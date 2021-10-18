import 'package:design/src/domain/entities/article.dart';
import 'package:design/src/injector.dart';
import 'package:design/src/presentation/blocs/local_articles/local_articles_bloc.dart';
import 'package:design/src/presentation/widgets/articles_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

class SavedArticlesView extends HookWidget {
  const SavedArticlesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          injector<LocalArticlesBloc>()..add(const GetAllSavedArticles()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
      title: const Text(
        "Saved Articles",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalArticlesBloc, LocalArticlesState>(
      builder: (context, localState) {
        if (localState is LocalArticlesLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (localState is LocalArticlesDone) {
          return _buildArticlesList(localState.articles);
        }
        return Container();
      },
    );
  }

  Widget _buildArticlesList(List<Article> articles) {
    if (articles.isEmpty) {
      return const Center(
        child: Text(
          "NO SAVED ARTICLES",
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => _onRemoveArticle(context, article),
          onArticlePressed: (article) => _onArticlePressed(context, article),
        );
      },
    );
  }

  void _onRemoveArticle(BuildContext context, Article article) {
    BlocProvider.of<LocalArticlesBloc>(context).add(RemoveArticle(article));
  }

  void _onArticlePressed(BuildContext context, Article article) {
    Navigator.of(context).pushNamed("/article-details", arguments: article);
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.of(context).pop();
  }
}
