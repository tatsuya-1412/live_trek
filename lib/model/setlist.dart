import 'package:flutter/material.dart';
import 'package:live_trek/db/setlist.dart';

class SetlistNotifier extends ChangeNotifier {
  final List<Setlist> _setlists = [];

  List<Setlist> get setlists => _setlists;
  final dbHelper = SetlistDatabaseHelper.instance;

  SetlistNotifier() {
    syncDb();
  }

  void syncDb() async {
    dbHelper.read().then(
      (val) => _setlists
      ..clear()
      ..addAll(val),
    );
    notifyListeners();
  }

  void toggle(Setlist live) {
    if (isExist(live.id)) {
      delete(live.id);
    } else {
      add(live);
    }
  }

  bool isExist(String id) {
    if (_setlists.indexWhere((live) => live.id == id) < 0) {
      return false;
    }
    return true;
  }

  void add(Setlist setlist) async {
    await dbHelper.insert(setlist);
    syncDb();
  }

  void delete(String id) async {
    await dbHelper.delete(id);
    syncDb();
  }

  List<Setlist> getByLiveId(String id) {
    return _setlists
      .where((setlist) => setlist.liveId == id)
      .toList()
      ..sort((a, b) => a.songOrder.compareTo(b.songOrder));
  }
}

class Setlist {
  final String id;
  final String liveId;
  final int songOrder;
  final String songTitle;
  final String artistName;
  final String notes;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'live_id': liveId,
      'song_order': songOrder,
      'song_title': songTitle,
      'artist_name': artistName,
      'notes': notes,
    };
  }

  Setlist({
    required this.id,
    required this.liveId,
    required this.songOrder,
    required this.songTitle,
    required this.artistName,
    required this.notes,
  });
}

// Setli sumikaSetli = Setli(songTitle: ['「伝言歌」', 'Lovers', 'ふっかつのじゅもん']);
// Setli vanillasSetli = Setli(songTitle: ['エマ', 'SUMMER BREEZE', '青いの。']);
// Setli beaverSetli = Setli(songTitle: ['ひたむき', '東京流星群', '青い春']);