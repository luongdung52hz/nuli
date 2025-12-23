import 'package:xml/xml.dart' as xml;

class NewArticle{
  final String title;
  final String description;
  final String url;
  final String publishedAt;
  final String imageUrl;

  NewArticle({
  required this.title,
  required this.description,
  required this.url,
  required this.publishedAt,
  this.imageUrl = '',
  });
  factory NewArticle.fromJson(Map<String, dynamic> json){
    return NewArticle(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        url: json['url']??'',
        publishedAt: json['publishedAt']?? '',
        imageUrl: json['urltoImage']??'',
    );
  }
  factory NewArticle.fromRssXml(xml.XmlNode node){
    final titleNode = node.findAllElements('title').firstOrNull;
    final descNode = node.findAllElements('description').firstOrNull;
    final linkNode = node.findAllElements('link').firstOrNull;
    final pubDateNode = node.findAllElements('pubDate').firstOrNull;
    final enclosureNode = node.findAllElements('enclosure').firstOrNull;

    return NewArticle(
        title: titleNode?.innerText ?? 'No Title',
        description: descNode?.innerText ?? 'No Description',
        url: linkNode?.innerText ?? '#',
        publishedAt: pubDateNode?.innerText ?? DateTime.now().toIso8601String(),
      imageUrl: enclosureNode?.getAttribute('url') ?? '',
    );
  }

}

