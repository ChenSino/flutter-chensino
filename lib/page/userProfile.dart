import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  Widget _buildMenu(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://afatpig.oss-cn-chengdu.aliyuncs.com/blog/20220802180305.png"),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("用户朱元璋", style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text("没有撤退可言",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("我的收藏"),
            iconColor: Colors.blue,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("个人设置"),
            iconColor: Colors.blue,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            iconColor: Colors.blue,
            leading: const Icon(Icons.logout),
            title: const Text("退出登录"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              //todo 退出登录
              Navigator.of(context).pushNamed('login');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, left: 30),
          child: const Text(
            '个人简介',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20, left: 30),
          child: Text(
            '我是一名前端开发工程师，目前在深圳从事前端开发工作。',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            _buildMenu(context),
          ],
        ));
  }
}
