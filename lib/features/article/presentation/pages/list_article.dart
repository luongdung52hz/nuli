import 'package:flutter/material.dart';
import 'package:nuli_app/features/article/presentation/pages/widgets/article_card.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../controller/article_controller.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ArticleController>().loadNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ArticleController>();

    if (controller.isLoading) {

      return const Center(child: CircularProgressIndicator(color: AppColors.primaryGreen));
    }

    if (controller.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              controller.error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.loadNews(),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    if (controller.news.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article_outlined, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('Chưa có tin tức'),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric( vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Báo Hôm Nay',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${controller.news.length} bài viết',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        //  ListView với safety checks
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 3),
            itemCount: controller.news.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              // Double check index
              if (index < 0 || index >= controller.news.length) {
                return const SizedBox.shrink();
              }

              try {
                final article = controller.news[index];
                return SizedBox(
                  width: 270,
                  child: ArticleCard(article),
                );
              } catch (e) {
                return SizedBox(
                  width: 270,
                  child: Card(
                    child: Center(
                      child: Text('Lỗi: $e'),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}