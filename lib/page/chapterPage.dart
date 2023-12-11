import 'dart:convert';

import 'package:chensino/entity/chapter_entity.dart';
import 'package:chensino/http/api.dart';
import 'package:chensino/http/httpUtil.dart';
import 'package:flutter/material.dart';

class ChapterListPage extends StatefulWidget {
  const ChapterListPage({super.key});

  @override
  State<ChapterListPage> createState() => _ChapterListPageState();
}

class _ChapterListPageState extends State<ChapterListPage> {
  late String bookId ;
  final List<Chapter> _chapters = List.empty(growable: true);

  ///加载数据，返回chapterListResponseEntity
  void queryChapterList(String bookId) async {
    //1. 获取数据
    final response = await HttpUtil.instance
        .get("${Api.SEARCH_CHAPTER_LIST}?bookId=$bookId");
    Map<String, dynamic> map = json.decode(response.toString());
    List<Chapter> chapters = ChapterListResponseEntity.fromJson(map).data;
    setState(() {
      _chapters.addAll(chapters);
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // 获取传递的参数，并进行操作
      final String param = ModalRoute.of(context)?.settings.arguments as String;
      setState(() {
        bookId = param;
        queryChapterList(bookId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('章节列表'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_chapters[index].chapterName),
            subtitle: Text(_chapters[index].chapterWordCount ?? ''),
            trailing: Text(_chapters[index].chapterUpdateTime ?? ''),
            onTap: () => {
              //进入详情页
              Navigator.of(context)
                  .pushNamed('/chapter', arguments: _chapters[index].id)
            },
          );
        },
        itemCount: _chapters.length,
      ),
    );
  }
}
