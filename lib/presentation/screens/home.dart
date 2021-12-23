import 'package:flutter/material.dart';

import '../../data/models/article_feed.dart';
import '../../data/services/api_services.dart';
import '../../data/provider/db_provider.dart';
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
    await ApiService.getArticleFeeds().then((value) async {
      setState(() {
        _data = value.rss!.channel!.item!;
        _isLoading = false;
        _hasError = false;
      });
    }).catchError((err) {
      if (_cachedData.isNotEmpty) {
        setState(() {
          _data = _cachedData;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = err.toString();
          _hasError = true;
        });
      }
    });
  }

  Future _getCachedFeed() async {
    setState(() {
      _isLoading = true;
    });
    await DBProvider.db.getAllArticles().then((value) {
      _cachedData = value;
      _getArticleFeed();
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
                  errorMessage: _errorMessage,
                  onRetryPressed: _getCachedFeed,
                )
              : RefreshIndicator(
                  onRefresh: _getCachedFeed,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return ArticleWidget(
                        content: _data[index],
                        imageUrl: _data[index].imageUrl ?? '',
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
