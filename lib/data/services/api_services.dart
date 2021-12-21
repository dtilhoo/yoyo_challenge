import 'dart:io';

import 'package:flutter_challenge/data/models/article_feed.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class ApiService {
  static Future<ArticleFeed> getArticleFeeds() async {
    Xml2Json xml2Json = Xml2Json();
    Map<String, String> headers = {'content-Type': 'text/xml'};
    try {
      final response = await http.get(
        Uri.parse('https://feeds.24.com/articles/Fin24/Tech/rss'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        String data = response.body;
        String validXml = data.replaceFirst('ï»¿', '');
        xml2Json.parse(validXml);
        String jsonString = xml2Json.toBadgerfish();
        return articleFeedFromJson(jsonString);
      } else {
        throw response.statusCode;
      }
    } on SocketException catch (_) {
      throw ('No internet connection');
    } on Exception catch (err) {
      throw Exception(err);
    }
  }
}
