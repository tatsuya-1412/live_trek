import 'package:flutter/material.dart';
import 'package:live_trek/db/live.dart';

class LiveNotifier extends ChangeNotifier {
  final List<Live> _lives = [];

  List<Live> get lives => _lives;
  final dbHelper = LiveDatabaseHelper.instance;

  LiveNotifier() {
    syncDb();
  }

  void syncDb() async {
    await dbHelper.read().then(
      (val) => _lives
      ..clear()
      ..addAll(val),
    );
    notifyListeners();
  }

  void toggle(Live live) {
    if (isExist(live.id)) {
      delete(live.id);
    } else {
      add(live);
    }
  }

  bool isExist(String id) {
    if (_lives.indexWhere((live) => live.id == id) < 0) {
      return false;
    }
    return true;
  }

  void add(Live live) async {
    await dbHelper.insert(live);
    syncDb();
  }

  void delete(String id) async {
    await dbHelper.delete(id);
    syncDb();
  }
}

class Live {
  final String id;
  final String title;
  final String artist;
  final DateTime performanceDate;
  final String venue;
  final DateTime openTime;
  final DateTime startTime;
  final String imageUrl;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'performance_date': performanceDate.toString(),
      'venue': venue,
      'open_time': openTime.toString(),
      'start_time': startTime.toString(),
      'image_url': imageUrl,
    };
  }

  Live({
    required this.id,
    required this.title,
    required this.artist,
    required this.performanceDate,
    required this.venue,
    required this.openTime,
    required this.startTime,
    required this.imageUrl,
  });
}

// List<Live> lives = [
//   Live(id: '001', liveName: '花鳥風月', artistName: 'sumika', date: '2023/8/1', location: 'ぴあアリーナMM', openTime: '13:00', startTime: '15:00', imageUrl: 'images/sumika_live.jpeg', setli: sumikaSetli),
//   Live(id: '002', liveName: 'My Favorite Things', artistName: 'go!go!vanillas', date: '2023/8/11', location: 'Zepp Haneda', openTime: '13:00', startTime: '15:00', imageUrl: 'images/vanillas_live.jpeg', setli: vanillasSetli),
//   Live(id: '003', liveName: '真夏の富士Q', artistName: 'SUPER BEAVER', date: '2023/8/31', location: '富士急ハイランド', openTime: '13:00', startTime: '15:00', imageUrl: 'images/beaver_live.jpeg', setli: beaverSetli),
// ];