import 'package:flutter/material.dart';

class BookCategoryPage extends StatefulWidget {
  const BookCategoryPage({super.key});

  @override
  State<BookCategoryPage> createState() => _BookCategoryPageState();
}

class _BookCategoryPageState extends State<BookCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0.0), // 将TabBar与顶部的间距设为0
            child: TabBar(
              tabs: [
                Tab(text: '男生频道'),
                Tab(text: '女生频道'),
                Tab(text: '综合频道'),
              ],
            ),
          )),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ));
  }
}
