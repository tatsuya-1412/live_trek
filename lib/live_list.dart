import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_trek/live_list_create.dart';
import 'package:live_trek/live_list_item.dart';
import 'package:live_trek/model/live.dart';

class LiveList extends StatefulWidget {
  const LiveList({super.key});
  @override
  State<LiveList> createState() => _LiveListState();
}

class _LiveListState extends State<LiveList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 42,
          alignment: Alignment.topRight,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
          ),
          child: IconButton(
            padding: const EdgeInsets.all(10),
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const LiveListCreate(),
                )
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            itemCount: 3,
            itemBuilder: (context, index) {
              return LiveListItem(live: lives[index],);
            }
          ),
        ),
      ],
    );
  }
}