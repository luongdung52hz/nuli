class ArticleModel {
  final String title;
  final String description;
  final String link;
  final String imageUrl;
  final DateTime publishedAt;
  final String source;
  final String category;

  ArticleModel({
    required this.title,
    required this.description,
    required this.link,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
    required this.category,
  });
}
