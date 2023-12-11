import 'dart:core';

import 'package:chensino/entity/book_entity.dart';

///根据剪贴板json生成Chapter实体类
class Chapter {
  late String id;
  late String? bookId;
  late String? chapterNum;
  late String chapterName;
  late String? chapterWordCount;
  late String? chapterUpdateTime;
  late String? isVip;

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['bookId'];
    chapterNum = json['chapterNum'];
    chapterName = json['chapterName'];
    chapterWordCount = json['chapterWordCount'];
    chapterUpdateTime = json['chapterUpdateTime'];
    isVip = json['isVip'];
  }
}
///章节详情
class ChapterContent{
  late String bookContent;
  late Chapter? chapterInfo;
  late Book? bookInfo;


  ChapterContent(this.bookContent, this.chapterInfo, this.bookInfo);

  ChapterContent.fromJson(Map<String, dynamic> json) {
    bookContent = json['data']['bookContent'];
    chapterInfo = Chapter.fromJson(json['data']['chapterInfo']);
    // bookInfo = Book.fromJson(json['data']['bookInfo']);
  }
}

///http响应
class ChapterListResponseEntity {
  late String code;
  late String message;
  late bool ok;
  late List<Chapter> data = [];

  ChapterListResponseEntity(
      {required this.code,
      required this.message,
      required this.ok,
      required this.data});

  ChapterListResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    ok = json['ok'];
    if (json['data'] != null) {
      for (var chapter in (json['data'] as List)) {
        data.add(Chapter.fromJson(chapter));
      }
    }
  }
}

class ChapterContentResponseEntity {
  late String code;
  late String message;
  late bool ok;
  late ChapterContent data;

  ChapterContentResponseEntity(
      {required this.code,
      required this.message,
      required this.ok,
      required this.data});

  ChapterContentResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    ok = json['ok'];
    data = ChapterContent.fromJson(json['data']);
  }
}