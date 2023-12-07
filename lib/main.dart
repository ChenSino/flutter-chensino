import 'package:chensino/page/errorPage.dart';
import 'package:chensino/page/loginPage.dart';
import 'package:chensino/page/userProfile.dart';
import 'package:chensino/page/webview/webView.dart';
import 'package:flutter/material.dart';
import './page/index.dart';
import './page/listPage.dart';
import 'controller/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isInWhiteList(String routeName) {
      // 在这里实现白名单逻辑，判断路由是否在白名单中
      // 返回true表示在白名单中，false表示不在白名单中
      // 这里可以根据具体需求来实现白名单逻辑
      return false;
    }

    MaterialPageRoute buildRoute(RouteSettings settings) {
      // 定义命名路由映射表
      final Map<String, WidgetBuilder> routes = {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/list': (context) => const ListPage(),
        '/webview': (context) => const WebViewExample(),
      };
      // 获取路由名称
      final String name = settings.name ?? Navigator.defaultRouteName;
      // 根据settings构建对应的页面路由
      // 这里根据settings.name来返回对应的页面路由
      // 返回一个MaterialPageRoute对象
      // 查找路由是否注册
      final WidgetBuilder? builder = routes[name];

      // 如果找到对应的路由
      if (builder != null) {
        return MaterialPageRoute(builder: builder, settings: settings);
      }

      // 如果未找到对应的路由，则跳转到错误页面
      return MaterialPageRoute(builder: (context) => const ErrorPage());
    }

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: '洛星星',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        // 获取路由名称
        final String name = settings.name ?? Navigator.defaultRouteName;

        // 检查路由是否在白名单中
        if (_isInWhiteList(name)) {
          // 如果在白名单中，直接跳转
          return buildRoute(settings);
        } else {
          // 否则检查用户是否已登录
          if (AuthManager.isAuthenticated) {
            // 用户已登录，允许跳转
            return buildRoute(settings);
          } else {
            // 用户未登录，跳转到登录页
            return MaterialPageRoute(builder: (context) => const LoginPage());
          }
        }
      },
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
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
    const HomePage(),
    const ListPage(),
    const UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        toolbarHeight: 60,
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
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '列表',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      body: _pages[_currentIndex],
    );
  }
}
