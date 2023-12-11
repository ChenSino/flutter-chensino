import 'dart:convert';

import 'package:chensino/entity/chapter_entity.dart';
import 'package:flutter/material.dart';

import '../http/api.dart';
import '../http/httpUtil.dart';

class ChapterPage extends StatefulWidget {
  const ChapterPage({super.key});

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  late final String _chapterId;

   ChapterContent _chapterContent = ChapterContent("", null, null);

  ///加载数据，返回chapterListResponseEntity
  void queryChapterContent(String chapterId) async {
    //1. 获取数据
    final response =
        await HttpUtil.instance.get("${Api.CHAPTER_CONTENT}/$chapterId");
    Map<String, dynamic> map = json.decode(response.toString());
    setState(() {
      _chapterContent = ChapterContent.fromJson(map);
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _chapterId = ModalRoute.of(context)!.settings.arguments as String;
      queryChapterContent(_chapterId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(_chapterContent.chapterInfo?.chapterName??"")
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _chapterContent.bookContent??"",
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ));
  }
}
