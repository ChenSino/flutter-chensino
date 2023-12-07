import 'package:flutter/material.dart';

// 定义认证状态管理类
class AuthManager {
  static bool isAuthenticated = false;
}

// 路由拦截器
class RouteInterceptor {
  static void handleUnauthenticatedRequest(BuildContext context, VoidCallback apiCall) {
    if (!AuthManager.isAuthenticated) {
      Navigator.pushNamed(context, '/login'); // 重定向到登录页
    } else {
      apiCall(); // 用户已登录，执行API调用
    }
  }
}

// 在需要拦截的地方调用路由拦截器
void makeApiCall(BuildContext context) {
  RouteInterceptor.handleUnauthenticatedRequest(context, () {
    // 进行API调用
  });
}
