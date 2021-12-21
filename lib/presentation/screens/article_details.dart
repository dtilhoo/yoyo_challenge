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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.content.title ?? '',
        ),
      ),
      body: Stack(children: [
        WebView(
          initialUrl: widget.content.link,
          javascriptMode: JavascriptMode.unrestricted,
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
            : Stack(),
      ]),
    );
  }
}
