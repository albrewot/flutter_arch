import 'package:design/src/core/bloc/bloc_with_state.dart';
import 'package:design/src/domain/entities/article.dart';
import 'package:design/src/presentation/blocs/remote_articles/remote_articles_bloc.dart';
import 'package:design/src/presentation/widgets/articles_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

class BreakinngNewsView extends HookWidget {
  const BreakinngNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    useEffect(() {
      scrollController
          .addListener(() => _onScrollListener(context, scrollController));
      return scrollController.dispose;
    }, [scrollController]);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(scrollController),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Builder(
          builder: (context) => GestureDetector(
            onTap: () => _onShowArticlesViewTapped(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Ionicons.bookmark),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(ScrollController scrollController) {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (context, remoteArticlesState) {
        if (remoteArticlesState is RemoteArticlesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (remoteArticlesState is RemoteArticleError) {
          return const Center(
            child: Icon(Ionicons.refresh),
          );
        }
        if (remoteArticlesState is RemoteArticlesDone) {
          return _buildArticle(scrollController, remoteArticlesState.articles!,
              remoteArticlesState.noMoreData!);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildArticle(ScrollController scrollController,
      List<Article> articles, bool noMoreData) {
    return ListView(
      controller: scrollController,
      children: [
        ...List<Widget>.from(
          articles.map(
            (e) => Builder(
              builder: (context) => ArticleWidget(
                  article: e,
                  onArticlePressed: (e) => _onArticlePressed(context, e)),
            ),
          ),
        ),
        if (noMoreData) ...[
          const SizedBox(),
        ] else ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: CupertinoActivityIndicator(),
          ),
        ]
      ],
    );
  }

  void _onScrollListener(
      BuildContext context, ScrollController scrollController) {
    final double maxScroll = scrollController.position.maxScrollExtent;
    final double currentScroll = scrollController.position.pixels;
    final RemoteArticlesBloc remoteArticlesBloc =
        BlocProvider.of<RemoteArticlesBloc>(context);
    final BlocProcessState state = remoteArticlesBloc.blocProcessState;

    if (currentScroll == maxScroll && state == BlocProcessState.idle) {
      remoteArticlesBloc.add(const GetRemoteArticles());
    }
  }

  void _onArticlePressed(BuildContext context, Article article) {
    Navigator.pushNamed(context, "/article-details-view", arguments: article);
  }

  void _onShowArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, "/saved-articles-view");
  }
}
