import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../data/models/article_model.dart';

class ArticleScreen extends StatefulWidget {
  final ArticleModel article;
  const ArticleScreen( {super.key, required this.article});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState(){
   super.initState();
   _initWebView();
  }


  void _initWebView() {
    if (Platform.isAndroid) {
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (progress == 100) setState(() => _isLoading = false);
          },
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(widget.article.link));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
         title: 'Thời tiết hôm nay',
         onBack: () => context.go('/home'),
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (_isLoading)
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primaryGreen),
                  ),
                ),
            ],
          ),
    );
  }
}
