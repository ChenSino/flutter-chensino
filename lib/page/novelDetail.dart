import 'package:flutter/material.dart';

class NovelDetailPage extends StatefulWidget {
  const NovelDetailPage({super.key});

  @override
  State<NovelDetailPage> createState() => _NovelDetailPageState();
}

class _NovelDetailPageState extends State<NovelDetailPage> {
  late String bookId;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      // 获取传递的参数，并进行操作
      final String param = ModalRoute.of(context)?.settings.arguments as String;
      print("paraml...==>$param");
      setState(() {
        bookId = param;
      });
    });
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.red,
                    height: 200,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.green,
                    height: 200,
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.blue,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text('收藏'),
                    ),
                  ),
                ),
                Container(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.blue,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        print("跳转到章节列表");
                        //跳转到章节列表，并传递book_id参数
                        Navigator.of(context).pushNamed(
                          '/chapterList',
                          arguments: bookId,
                        );
                      },
                      child: Text('开始阅读'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
