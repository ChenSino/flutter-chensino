import 'dart:core';

class Book {
  late String id;
  late String categoryId;
  late String categoryName;
  late String? picUrl;
  late String bookName;
  late String authorId;
  late String authorName;
  late String? bookDesc;
  late String? bookStatus;
  late String? visitCount;
  late String wordCount;
  late String? commentCount;
  late String? firstChapterId;
  late String? lastChapterId;
  late String lastChapterName;
  late String? updateTime;

  /// 根据json初始化对象
  Book.fromJson(Map<String, dynamic> json) {
    //从json获取数据
    id = json['id'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    picUrl = json['picUrl'];
    bookName = json['bookName'];
    authorId = json['authorId'];
    authorName = json['authorName'];
    bookDesc = json['bookDesc'];
    bookStatus = json['bookStatus'];
    visitCount = json['visitCount'];
    wordCount = json['wordCount'];
    commentCount = json['commentCount'];
    firstChapterId = json['firstChapterId'];
    lastChapterId = json['lastChapterId'];
    lastChapterName = json['lastChapterName'];
    updateTime = json['updateTime'];
  }
}

class BookListResponseEntity {
  late String code;
  late String message;
  late bool ok;
  late List<Book> data;

  BookListResponseEntity(
      {required this.code,
      required this.message,
      required this.ok,
      required this.data});

  BookListResponseEntity.fromJson(Map<String, dynamic> json) {
    data = [];
    if (json['data'] != null) {
      for (var book in (json['data']['list'] as List)) {
        data.add(Book.fromJson(book));
      }
    }
  }
}

class ResponseEntity<T> {
  String code;
  String message;
  bool ok;
  T data;

  ResponseEntity(
      {required this.code,
      required this.message,
      required this.ok,
      required this.data});
}

class NovelList {
  late int total;
  late int pageSize;
  late int pageNum;
  late List<Novel> data;

  NovelList.build({
    required this.total,
    required this.pageSize,
    required this.pageNum,
    required this.data,
  });

  NovelList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNum = json['pageNum'];
    if (json['data'] != null) {}
  }
}

class Novel {
  String name;
  String imageUrl;
  String description;
  String category;
  int id;
  String author;

  Novel.build({
    required this.author,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.id,
  });
}

class Chapter {
  late int? id;
  late int bookId;
  late int chapterNum;
  late String chapterName;
  late String chapterWordCount;
  late String chapterUpdateTime;
  late String isVip;

  Chapter.build({
    required this.bookId,
    required this.chapterNum,
    required this.chapterName,
    required this.chapterWordCount,
    required this.chapterUpdateTime,
    required this.isVip,
    this.id,
  });

  Chapter.fromJson(Map<String, dynamic> json) {
    Chapter.build(
      bookId: json['bookId'],
      chapterNum: json['chapterNum'],
      chapterName: json['chapterName'],
      chapterWordCount: json['chapterWordCount'],
      chapterUpdateTime: json['chapterUpdateTime'],
      isVip: json['isVip'],
      id: json['id'],
    );
  }
}
