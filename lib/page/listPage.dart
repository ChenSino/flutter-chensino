import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List'),
        ),
        body: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text('List Tile'),
              subtitle: Text('List Tile'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text('List Tile'),
              subtitle: Text('List Tile'),
              trailing: Icon(Icons.keyboard_arrow_right),
            )
          ],
        )
    );
  }
}
