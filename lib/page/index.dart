import 'package:flutter/material.dart';

/**
 * 首页组件
 */
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledButton(
              onPressed: () {
                // 按钮点击事件处理逻辑
                Navigator.pushNamed(context, '/list');
              }, child: const Text('测试跳转列表'),
            ),
             const Divider(),
            FilledButton(
              onPressed: () {
                // 按钮点击事件处理逻辑
                Navigator.pushNamed(context, '/login');
              }, child: const Text('跳转到登录'),
            )
          ],
        ),
      ),
    );
  }
}
