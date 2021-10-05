import 'package:design/src/data/models/breaking_news_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../../../core/utils/constants.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class NewsApiService{
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET("/top-headlines")
  Future<HttpResponse<BreakingNewsResponseModel>> getBreakingNewsArticles({
    @Query("apiKey") String apiKey,
    @Query("country") String country,
    @Query("category") String category,
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  });
} 