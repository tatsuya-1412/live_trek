import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_trek/model/setli.dart';

class SetliList extends StatefulWidget {
  const SetliList({super.key, required this.setli});
  final Setli setli;
  @override
  State<SetliList> createState() => _SetliListState();
}

class _SetliListState extends State<SetliList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return SetliListItem(index: (index+1).toString(), songTitle: widget.setli.songTitle[index]);
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SetliListItem extends StatelessWidget {
  const SetliListItem({super.key, required this.index, required this.songTitle});
  final String index;
  final String songTitle;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 20,
          height: 40,
          // color: Colors.grey,
          child: Center(
            child: Text(index),
          )
        ),
        title: Text(songTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        minLeadingWidth: 20,
        trailing: const Icon(Icons.more_horiz),
        onTap: () {},
      ),
    );
  }
}