import 'dart:convert';

class Pets {
  Pets({
    required this.count,
    required this.entries,
  });

  final int count;
  final List<Entry> entries;

  Pets copyWith({
    required int count,
    required List<Entry> entries,
  }) =>
      Pets(
        count: count,
        entries: entries,
      );

  factory Pets.fromJson(String str) => Pets.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pets.fromMap(Map<String, dynamic> json) => Pets(
        count: json["count"],
        entries: List<Entry>.from(json["entries"].map((x) => Entry.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "entries": List<dynamic>.from(entries.map((x) => x.toMap())),
      };
}

class Entry {
  Entry({
    required this.api,
    required this.description,
    required this.auth,
    required this.https,
    required this.cors,
    required this.link,
    required this.category,
  });

  final String api;
  final String description;
  final String auth;
  final bool https;
  final String cors;
  final String link;
  final String category;

  Entry copyWith({
    required String api,
    required String description,
    required String auth,
    required bool https,
    required String cors,
    required String link,
    required String category,
  }) =>
      Entry(
        api: api,
        description: description,
        auth: auth,
        https: https,
        cors: cors,
        link: link,
        category: category,
      );

  factory Entry.fromJson(String str) => Entry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Entry.fromMap(Map<String, dynamic> json) => Entry(
        api: json["API"],
        description: json["Description"],
        auth: json["Auth"],
        https: json["HTTPS"],
        cors: json["Cors"],
        link: json["Link"],
        category: json["Category"],
      );

  Map<String, dynamic> toMap() => {
        "API": api,
        "Description": description,
        "Auth": auth,
        "HTTPS": https,
        "Cors": cors,
        "Link": link,
        "Category": category,
      };
}
