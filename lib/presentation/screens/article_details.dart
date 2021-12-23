import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_challenge/data/models/article_feed.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({
    Key? key,
    required this.content,
  }) : super(key: key);

  final Item content;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  bool _isLoading = true;
  bool _hasError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.content.title ?? '',
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.content.link,
            javascriptMode: JavascriptMode.unrestricted,
            onWebResourceError: (error) {
              setState(() {
                _isLoading = false;
                _hasError = true;
              });
            },
            onPageFinished: (_) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _hasError
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.error_outline,
                            size: 32.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('An error occured. Please try again later.')
                        ],
                      ),
                    )
                  : Stack(),
        ],
      ),
    );
  }
}
