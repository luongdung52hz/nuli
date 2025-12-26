import 'package:flutter/foundation.dart';
import '../../../../core/services/article_service.dart';
import '../models/article_model.dart';

class ArticleRepository {
  final ArticleService service;

  ArticleRepository(this.service);

  Future<List<ArticleModel>> getAllNews() async {
    final List<ArticleModel> allNews = [];

    try {
      debugPrint('[NEWS][INFO] Load Tuổi  Trẻ');
      allNews.addAll(await service.fetchNews(
        'https://tuoitre.vn/rss/nong-nghiep.rss',
        'Tuổi Trẻ',
      ));
    } catch (e) {
      debugPrint('[NEWS][ERROR] Tuổi Trẻ failed: $e');
    }


    try {
      debugPrint('[NEWS][INFO] Load VnExpress');
      allNews.addAll(await service.fetchNews(

          'https://vnexpress.net/rss/nong-nghiep.rss',
          'VnExpress'
      ));
    } catch (e) {
      debugPrint('[NEWS][ERROR] VnExpress failed: $e');
    }

    try {
      debugPrint('[NEWS][INFO] Load Dân Việt');
      allNews.addAll(await service.fetchNews(

          'https://danviet.vn/kinh-te.rss',
          'Dân Việt'
      ));
    } catch (e) {
      debugPrint('[NEWS][ERROR] Dân Việt failed: $e');
    }


    allNews.sort(
          (a, b) => b.publishedAt.day
      ,
    );

    return allNews;
  }
}
