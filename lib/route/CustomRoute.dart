import 'package:chensino/page/chapterContent.dart';
import 'package:chensino/page/novelDetail.dart';
import 'package:flutter/material.dart';

import '../controller/auth.dart';
import '../page/chapterPage.dart';
import '../page/errorPage.dart';
import '../page/index.dart';
import '../page/bookPage.dart';
import '../page/loginPage.dart';
import '../page/webview/webView.dart';

class CustomRoute {
  static MaterialPageRoute buildRoute(RouteSettings settings) {
    // 定义命名路由映射表
    final Map<String, WidgetBuilder> routes = {
      '/': (context) => const HomePage(),
      '/login': (context) => const LoginPage(),
      '/list': (context) => const BookListPage(),
      '/webview': (context) => const WebViewExample(),
      '/detail': (context) => const NovelDetailPage(),
      '/chapterList': (context) => const ChapterListPage(),
      '/chapter': (context) => const ChapterPage(),
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

  static List<String> getWhiteList() {
    // 定义白名单
    final List<String> whiteList = [
      '/',
      '/login',
      '/list',
      '/webview',
      '/detail',
      '/chapterList',
      '/chapter',
    ];
    return whiteList;
  }

  static bool isInWhiteList(String routeName) {
    return getWhiteList().contains(routeName);
  }

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    // 获取路由名称
    final String name = settings.name ?? Navigator.defaultRouteName;

    // 检查路由是否在白名单中
    print("iniiiii------>" + CustomRoute.isInWhiteList(name).toString());
    if (CustomRoute.isInWhiteList(name)) {
      // 如果在白名单中，直接跳转
      return buildRoute(settings);
    } else {
      // 否则检查用户是否已登录
      if (AuthManager.isAuthenticated) {
        // 用户已登录，允许跳转
        return CustomRoute.buildRoute(settings);
      } else {
        // 用户未登录，跳转到登录页
        return MaterialPageRoute(builder: (context) => const LoginPage());
      }
    }
  }
}
