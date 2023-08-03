import 'package:flutter/material.dart';
import 'package:live_trek/live_list_detail.dart';
import 'package:live_trek/model/live.dart';

class LiveListItem extends StatelessWidget {
  const LiveListItem({super.key, required this.live});
  final Live? live;
  @override
  Widget build(BuildContext context) {
    if (live != null) {
      return ListTile(
        leading: Container(
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(live!.imageUrl),
              )
          ),
        ),
        title: Text(live!.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(live!.date),
        trailing: const Icon(Icons.navigate_next),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>  LiveListDetail(live: live),
            )
          );
        },
      );
    } else {
      return const ListTile(title: Text('...'));
    }
  }
}