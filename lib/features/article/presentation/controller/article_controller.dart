import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../data/models/article_model.dart';
import '../../data/repositories/article_repository.dart';

class ArticleController extends ChangeNotifier {
  final ArticleRepository repository;

  ArticleController(this.repository);

  bool isLoading = false;
  String? error;
  List<ArticleModel> _allNews = [];
  String selectedCategory = 'Tất cả';

  List<ArticleModel> get news {
    if (selectedCategory == 'Tất cả') return _allNews;
    return _allNews
        .where((e) => e.category == selectedCategory)
        .toList();
  }

  Future<void> loadNews() async {
    isLoading = true;
    notifyListeners();

    try {
      error = null;
      _allNews = await repository.getAllNews();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

}
