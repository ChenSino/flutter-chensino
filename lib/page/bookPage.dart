import 'dart:convert';

import 'package:chensino/http/api.dart';

import 'package:chensino/http/httpUtil.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import '../entity/book_entity.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final TextEditingController _keywordController = TextEditingController();
  late EasyRefreshController _scrollController;

  int pageNum = 1; // 当前页面数
  int pageSize = 20; // 每页的数据数量
  int total = 0;
  final List<Book> _books = List.empty(growable: true);

  ///查询
  void _searchBookList() async {
    BookListResponseEntity bookListResponseEntity = await queryBookList(
        keyword: _keywordController.text, pageNum: 1, pageSize: 20);
    if (bookListResponseEntity.ok) {
      setState(() {
        //清空数据
        _books.clear();
        _books.addAll(bookListResponseEntity.data.list);
      });
    }
  }

  ///加载数据，返回BookListResponseEntity
  Future<BookListResponseEntity> queryBookList(
      {required int pageNum,
      required int pageSize,
      String keyword = '',
      String sort = 'create_time',
      bool fetchAll = true}) async {
    //1. 获取数据
    final response = await HttpUtil.instance.get(
        "${Api.SEARCH_BOOK_LIST}?pageNum=$pageNum&pageSize=$pageSize&fetchAll=$fetchAll&sort=$sort&keyword=$keyword");
    Map<String, dynamic> map = json.decode(response.toString());
    return BookListResponseEntity.fromJson(map);
  }

  ///初始化第一页数据
  void initData() async {
    BookListResponseEntity bookListResponseEntity =
        await queryBookList(pageNum: 1, pageSize: 20);
    if (bookListResponseEntity.ok) {
      setState(() {
        total = bookListResponseEntity.data.total;
        //清空数据
        _books.clear();
        _books.addAll(bookListResponseEntity.data.list);
      });
    }
  }

  ///加载更多
  void _loadMore() async {
    setState(() {
      pageNum++;
    });
    //1. 获取数据
    BookListResponseEntity bookListResponseEntity =
        await queryBookList(pageNum: pageNum, pageSize: pageSize);
    if (bookListResponseEntity.ok) {
      setState(() {
        _books.addAll(bookListResponseEntity.data.list);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    _searchBookList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              SizedBox(
                width: 200.0,
                child: TextField(
                  controller: _keywordController,
                  decoration: const InputDecoration(
                    hintText: '输入书名、作者名查找',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    // 执行搜索操作
                    _loadMore();
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () => _searchBookList(), child: const Text("搜索"))
            ],
          ),
        ],
      ),
      body: EasyRefresh(
        controller: _scrollController,
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        onRefresh: () async {
          _searchBookList();
          if (!mounted) {
            return;
          }
          _scrollController.finishRefresh();
          _scrollController.resetFooter();
        },
        onLoad: () async {
          _loadMore();
          if (!mounted) {
            return;
          }
          _scrollController.finishLoad(_books.length >= total
              ? IndicatorResult.noMore
              : IndicatorResult.success);
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_books[index].bookName),
              subtitle: Text(_books[index].bookDesc ?? ''),
              trailing: Text(_books[index].authorName),
              onTap: () => {
                //进入详情页
                Navigator.of(context).pushNamed('/detail', arguments: _books[index].id)
              },
            );
          },
          itemCount: _books.length,
        ),
      ),
    );
  }
}
