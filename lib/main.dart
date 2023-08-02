import 'package:flutter/material.dart';
import 'package:live_trek/live_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Trek',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const TopPage(),
    );
  }
}

class TopPage extends StatefulWidget {
  const TopPage({super.key});
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentBnbIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentBnbIndex,
          children: const <Widget>[
            Center(child: Text('Live Trek')),
            LiveList(),
            Center(child: Text('Settings')),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentBnbIndex = index;
          });
        },
        currentIndex: currentBnbIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ホーム'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue_music),
            label: 'ライブ履歴'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定'
          ),
        ],
      ),
    );
  }
}
