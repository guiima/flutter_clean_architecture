import 'dart:convert';

import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  ResultSearchModel(String login, int id, String avatarUrl)
      : super(login, id, avatarUrl);

  Map<String, dynamic> toMap() {
    return {
      'title': login,
      'id': id,
      'avatar_url': avatarUrl,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      map['login'] ?? '',
      map['id'] ?? '',
      map['avatar_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
