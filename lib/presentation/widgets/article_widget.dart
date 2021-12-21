import 'package:flutter/material.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              height: 10,
            ),
            Center(
              child: Image.network(
                imageUrl,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.hide_image_outlined);
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
    );
  }
}
