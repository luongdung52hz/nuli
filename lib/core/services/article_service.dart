import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nuli_app/core/constants/app_constans.dart';
import 'package:xml/xml.dart';
import 'package:html/parser.dart' as html_parser;

import '../../features/article/data/models/article_model.dart';

class ArticleService {
  Future<List<ArticleModel>> fetchNews(String url, String source) async {
    try {
      debugPrint('[RSS][INFO] Fetching: $source');
      debugPrint('[RSS][INFO] URL: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          'Accept': 'application/rss+xml, application/xml, text/xml, */*',
          'Accept-Encoding': 'gzip, deflate',
          'Cache-Control': 'no-cache',
        },
      ).timeout(
        AppConstants.requestTimeout,
        onTimeout: () => throw Exception('Timeout fetching RSS'),
      );

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }

      //  Kiểm tra content type
      final contentType = response.headers['content-type'] ?? '';
      if (contentType.contains('text/html')) {
        throw Exception('Server returned HTML instead of RSS/XML');
      }

      final document = XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      debugPrint('[RSS][INFO] Items count: ${items.length}');

      if (items.isEmpty) {
        debugPrint('[RSS][WARN] No items found in feed');
        return [];
      }

      return items.map((item) {
        return ArticleModel(
          title: _safeGetText(item, 'title'),
          description: _extractPlainText( item.getElement('description')?.innerText ??''),
          link: _safeGetText(item, 'link'),
          imageUrl: _extractImage(item),
          publishedAt: _parseDate(item.getElement('pubDate')?.innerText),
          source: source,
          category: _detectCategory(item),
        );
      }).take(10).toList();
    } catch (e, stack) {
      debugPrint('[RSS][EXCEPTION] $source');
      debugPrint('[RSS][ERROR] $e');
      debugPrint('[RSS][STACK] $stack');
      rethrow;
    }
  }

  //  Helper method để lấy text an toàn
  String _safeGetText(XmlElement item, String tagName) {
    try {
      final element = item.getElement(tagName);
      if (element == null) return '';

      final text = element.innerText.trim();

      // Giới hạn độ dài
      if (tagName == 'title' && text.length > 200) {
        return text.substring(0, 200);
      } else if (tagName == 'description' && text.length > 500) {
        return text.substring(0, 500);
      }

      return text;
    } catch (e) {
      debugPrint('[RSS][WARN] Error getting $tagName: $e');
      return '';
    }
  }

  //  Method chính để extract image
  String _extractImage(XmlElement item) {
    try {
      // 1. Thử media:content
      final mediaContent = item.getElement('media:content');
      if (mediaContent != null) {
        final url = mediaContent.getAttribute('url');
        if (url != null && url.isNotEmpty) {
          return url;
        }
      }

      final imageElement = item.getElement('image');
      if(imageElement != null){
        final url = imageElement.getAttribute('url');
        if (url != null && url.isNotEmpty){
          return url;
        }
      }


      // 2. Thử enclosure
      final enclosure = item.getElement('enclosure');
      if (enclosure != null) {
        final url = enclosure.getAttribute('url');
        if (url != null && url.isNotEmpty) {
          return url;
        }
      }

      // 3. Thử tìm trong description
      final description = item.getElement('description')?.innerText;
      if (description != null && description.isNotEmpty) {
        final imageUrl = _extractImageFromHtml(description);
        if (imageUrl != null && imageUrl.isNotEmpty) {
          return imageUrl;
        }
      }

      // 4. Thử media:thumbnail
      final mediaThumbnail = item.getElement('media:thumbnail');
      if (mediaThumbnail != null) {
        final url = mediaThumbnail.getAttribute('url');
        if (url != null && url.isNotEmpty) {
          return url;
        }
      }

      return '';
    } catch (e) {
      debugPrint('[RSS][WARN] Image extraction error: $e');
      return '';
    }
  }

  String _extractPlainText(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text.trim() ?? '';
  }

  // Extract image từ HTML string
  String? _extractImageFromHtml(String htmlString) {
    try {
      final imgRegex = RegExp(r'<img[^>]+src=["' + "'" + r']([^"' + "'" + r']+)["' + "'" + r']',
        caseSensitive: false,
      );
      final match = imgRegex.firstMatch(htmlString);
      if (match != null && match.groupCount > 0) {
        return match.group(1);
      }

      // Method 2: HTML parser (chính xác hơn)
      if (htmlString.contains('<img')) {
        final document = html_parser.parse(htmlString);
        final img = document.querySelector('img');
        if (img != null) {
          return img.attributes['src'];
        }
      }

      return null;
    } catch (e) {
      debugPrint('[RSS][WARN] HTML image parse error: $e');
      return null;
    }
  }

  //  Parse date an toàn
  DateTime _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return DateTime.now();
    }

    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      try {

        final cleaned = dateStr
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim();

        return DateTime.parse(cleaned);
      } catch (e2) {
        debugPrint('[RSS][WARN] Date parse error: $dateStr - $e2');
        return DateTime.now();
      }
    }
  }

  // Detect category
  String _detectCategory(XmlElement item) {
    try {
      final category = item.getElement('category')?.innerText.trim();
      return category?.isNotEmpty == true ? category! : 'Nông nghiệp';
    } catch (e) {
      debugPrint('[RSS][WARN] Category parse error: $e');
      return 'Nông nghiệp';
    }
  }
}