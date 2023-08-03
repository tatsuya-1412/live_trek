import 'package:live_trek/model/setli.dart';

class Live {
  final String name;
  final String date; //DateTimeにする
  final String location;
  final String imageUrl;
  final Setli setli;
  // 後々実装
  // final DateTime openTime;
  // final DateTime startTime;

  Live({
    required this.name,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.setli,
  });
}

List<Live> lives = [
  Live(name: 'sumika', date: '2023/8/1', location: 'ぴあアリーナMM', imageUrl: 'images/sumika_live.jpeg', setli: sumikaSetli),
  Live(name: 'go!go!vanillas', date: '2023/8/11', location: 'Zepp Haneda', imageUrl: 'images/vanillas_live.jpeg', setli: vanillasSetli),
  Live(name: 'SUPER BEAVER', date: '2023/8/31', location: '富士急ハイランド', imageUrl: 'images/beaver_live.jpeg', setli: beaverSetli),
];