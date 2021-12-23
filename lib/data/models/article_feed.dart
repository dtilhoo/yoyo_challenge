import 'dart:convert';

import 'package:flutter_challenge/data/provider/db_provider.dart';

ArticleFeed articleFeedFromJson(String str) {
  var jsonData = ArticleFeed.fromJson(json.decode(str));
  DBProvider.db.deleteAllArticles();
  (jsonData.rss!.channel!.item as List<Item>).map((article) {
    DBProvider.db.createArticle(article);
  }).toList();
  return jsonData;
}

String articleFeedToJson(ArticleFeed data) => json.encode(data.toJson());

class ArticleFeed {
  ArticleFeed({
    this.rss,
  });

  Rss? rss;

  factory ArticleFeed.fromJson(Map<String, dynamic> json) => ArticleFeed(
        rss: json["rss"] == null ? null : Rss.fromJson(json["rss"]),
      );

  Map<String, dynamic> toJson() => {
        "rss": rss == null ? null : rss!.toJson(),
      };
}

class Rss {
  Rss({
    this.channel,
  });

  Channel? channel;

  factory Rss.fromJson(Map<String, dynamic> json) => Rss(
        channel:
            json["channel"] == null ? null : Channel.fromJson(json["channel"]),
      );

  Map<String, dynamic> toJson() => {
        "channel": channel == null ? null : channel!.toJson(),
      };
}

class Channel {
  Channel({
    this.title,
    this.link,
    this.docs,
    this.pubDate,
    this.item,
  });

  String? title;
  String? link;
  String? docs;
  String? pubDate;
  List<Item>? item;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        title: json["title"]["\$"] ?? '',
        link: json["link"]["\$"] ?? '',
        docs: json["docs"]["\$"] ?? '',
        pubDate: json["pubDate"]["\$"] ?? '',
        item: json["item"] == null
            ? null
            : List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title ?? '',
        "link": link ?? '',
        "docs": docs ?? '',
        "pubDate": pubDate ?? '',
        "item": item == null
            ? null
            : List<dynamic>.from(item!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.title,
    this.description,
    this.link,
    this.imageUrl,
  });

  String? title;
  String? description;
  String? link;
  String? imageUrl;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"]["\$"] ?? '',
        description: json["description"]["\$"] ?? '',
        link: json["link"]["\$"] ?? '',
        imageUrl: json["enclosure"]["@url"] ?? '',
      );

  static Item fromSqlJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        description: json["description"],
        link: json["link"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "title": title ?? '',
        "description": description ?? '',
        "link": link ?? '',
        "imageUrl": imageUrl ?? '',
      };
}
