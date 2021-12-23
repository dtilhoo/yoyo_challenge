import 'package:flutter/material.dart';

import '../../data/models/article_feed.dart';
import '../../data/services/api_services.dart';
import '../../data/services/db_provider.dart';
import '../widgets/article_widget.dart';
import '../widgets/retry_fetch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Item> _data = [];
List<Item> _cachedData = [];
bool _isLoading = false;
bool _hasError = false;
String _errorMessage = '';

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _getCachedFeed();
    super.initState();
  }

  Future _getArticleFeed() async {
    _isLoading = true;
    await ApiService.getArticleFeeds().then((value) async {
      setState(() {
        _data = value.rss!.channel!.item!;
        _isLoading = false;
        _hasError = false;
      });
    }).catchError((err) {
      if (_cachedData.isNotEmpty) {
        setState(() {
          _isLoading = false;
          _data = _cachedData;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = err.toString();
        });
      }
    });
  }

  Future _getCachedFeed() async {
    await DBProvider.db.getAllArticles().then((value) {
      _cachedData = value;
      _getArticleFeed();
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
