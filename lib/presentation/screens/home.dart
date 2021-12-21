import 'package:flutter/material.dart';
import 'package:flutter_challenge/data/models/article_feed.dart';
import 'package:flutter_challenge/data/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Item> data = [];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final response = ApiService.getArticleFeeds();
    response.then((value) {
      setState(() {
        data = value.rss!.channel!.item!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Yoyo challenge"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ArticleWidget(
            imageUrl: data[index].enclosure?.url ??
                'https://www.thedesignwork.com/wp-content/uploads/2011/10/Random-Pictures-of-Conceptual-and-Creative-Ideas-02.jpg',
            title: data[index].title ?? 'No title',
            description: data[index].description ?? 'No description',
          );
        },
      ),
    );
  }
}

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
