import 'package:design/src/data/models/source_model.dart';
import 'package:design/src/domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    // int? id,
    SourceModel? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) : super(
          // id: id,
          source: source,
          title: title,
          author: author,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      // id: json["id"] as int,
      source: SourceModel.fromJson(json["source"] as Map<String, dynamic>),
      author: json["author"] as String?,
      title: json["title"] as String?,
      description: json["description"] as String?,
      url: json["url"] as String,
      urlToImage: json["urlToImage"] as String?,
      publishedAt: json["publishedAt"] as String,
      content: json["content"] as String?,
    );
  }
}
