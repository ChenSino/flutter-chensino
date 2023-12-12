import 'package:chensino/page/categoryPage.dart';
import 'package:chensino/page/loginPage.dart';
import 'package:chensino/page/userProfile.dart';
import 'package:chensino/route/CustomRoute.dart';
import 'package:flutter/material.dart';

import './page/index.dart';
import './page/bookPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {



    return PreferredSize(
      preferredSize:  const Size.fromHeight(0.0),
      child:  MaterialApp(
        navigatorKey: navigatorKey,
        title: '洛星星小说阅读器',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) => CustomRoute.onGenerateRoute(settings),
        home: const LoginPage(),
        debugShowCheckedModeBanner: false,
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const BookListPage(),
    const BookCategoryPage(),
    const HomePage(),
    const UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(widget.title),
        ),
        titleTextStyle: const TextStyle(
            fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: '书城',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: '分类',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '书架',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        currentIndex: _currentIndex,
        // unselectedItemColor: Colors.black.withOpacity(0.5),
        selectedItemColor: Colors.blue,
        iconSize: 18,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      body: _pages[_currentIndex],
    );
  }
}
