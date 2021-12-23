import 'package:flutter/material.dart';

import '../../data/models/article_feed.dart';
import '../screens/article_details.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.content,
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final String description;
  final Item content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(
              content: content,
            ),
          ),
        );
      },
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.hide_image_outlined),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}
