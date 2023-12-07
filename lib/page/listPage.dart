import 'dart:convert';

import 'package:chensino/http/api.dart';

import 'package:chensino/http/httpUtil.dart';
import 'package:flutter/material.dart';
import '../entity/book_entity.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Book> books = [];

  ///加载数据
  Future<List<Book>> fetchBookList(
      { int pageNum = 1,
       int pageSize = 10,
      String keyword = '',
      String sort = 'create_time',
      bool fetchAll = true}) async {
    //1. 获取数据
    final response = await HttpUtil.instance.get(
        "${Api.SEARCH_BOOK_LIST}?pageNum=$pageNum&pageSize=$pageSize&fetchAll=$fetchAll&sort=$sort&keyword=$keyword");
    Map<String, dynamic> map = json.decode(response.toString());
    BookListResponseEntity projectEntity = BookListResponseEntity.fromJson(map);
    setState(() {
      books = projectEntity.data;
    });
    return projectEntity.data;
  }

  @override
  void initState() {
    super.initState();
    fetchBookList(pageNum: 1, pageSize: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索'),
        actions:  [
          Row(
            children: [
              SizedBox(
                width: 200.0,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '查找小说',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    // 执行搜索操作
                    if (value.isNotEmpty) {
                      print('搜索内容：$value');
                      fetchBookList(keyword: value);
                    }else{
                      fetchBookList();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            // leading: Image.network(chapters[index].imageUrl),
            title: Text(books[index].bookName ?? ''),
            subtitle: Text(books[index].bookDesc ?? '',
                style: const TextStyle(color: Colors.grey, fontSize: 10)),
            trailing: Text(books[index].authorName),
            onTap: () {
              // 弹窗丧偶

            },
          );
        },
      ),
    );
  }
}
