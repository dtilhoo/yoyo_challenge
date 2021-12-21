import 'package:flutter/material.dart';
import 'package:flutter_challenge/data/models/article_feed.dart';
import 'package:flutter_challenge/data/services/api_services.dart';
import 'package:flutter_challenge/presentation/widgets/article_widget.dart';
import 'package:flutter_challenge/presentation/widgets/retry_fetch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Item> _data = [];
bool _isLoading = false;
bool _hasError = false;
String _errorMessage = '';

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _getArticleFeed();
    super.initState();
  }

  Future _getArticleFeed() async {
    _isLoading = true;
    await ApiService.getArticleFeeds().then((value) {
      setState(() {
        _data = value.rss!.channel!.item!;
        _isLoading = false;
        _hasError = false;
      });
    }).catchError((err) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = err.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Yoyo challenge"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? ErrorMessage(
                  errorMessage: _errorMessage, onRetryPressed: _getArticleFeed)
              : RefreshIndicator(
                  onRefresh: _getArticleFeed,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return ArticleWidget(
                        content: _data[index],
                        imageUrl: _data[index].enclosure?.url ?? '',
                        title: _data[index].title ?? 'No title',
                        description:
                            _data[index].description ?? 'No description',
                      );
                    },
                  ),
                ),
    );
  }
}
