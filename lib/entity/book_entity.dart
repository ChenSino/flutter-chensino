import 'dart:core';

/// 书籍实体类
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

/// 书籍分页实体类
class BookPageDataEntity {
  late int pageNum;
  late int pageSize;
  late int total;
  late int pages;
  late List<Book> list;

  BookPageDataEntity.fromJson(Map<String, dynamic> json) {
    pageNum =int.parse(json['pageNum']);
    pageSize =int.parse(json['pageSize']);
    total = int.parse(json['total']);
    pages = int.parse(json['pages']);
    list = List.empty(growable: true);
    for (var book in (json['list'] as List)) {
      list.add(Book.fromJson(book));
    }
  }
}

///http响应
class BookListResponseEntity {
  late String code;
  late String message;
  late bool ok;
  late BookPageDataEntity data;

  BookListResponseEntity(
      {required this.code,
      required this.message,
      required this.ok,
      required this.data});

  BookListResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    ok = json['ok'];
    if (json['data'] != null) {
      data = BookPageDataEntity.fromJson(json['data']);
    }
  }
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
