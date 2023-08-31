import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_trek/model/setlist.dart';
import 'package:live_trek/setlist_edit.dart';
import 'package:provider/provider.dart';

class SetlistList extends StatefulWidget {
  const SetlistList({super.key, required this.liveId});
  final String liveId;
  @override
  State<SetlistList> createState() => _SetlistListState();
}

class _SetlistListState extends State<SetlistList> {
  List<Setlist> setlistsByLiveId = [];

  @override
  void initState() {
    setlistsByLiveId = Provider.of<SetlistNotifier>(context, listen: false).getByLiveId(widget.liveId);
  }

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
                    icon: const Icon(Icons.edit_note),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => SetlistEdit(liveId: widget.liveId, setlistsByLiveId: setlistsByLiveId),
                          )
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<SetlistNotifier>(
                builder: (context, setlists, child) {
                  setlistsByLiveId = setlists.getByLiveId(widget.liveId);
                  return setlistsByLiveId.isEmpty
                      ? Text('no data')
                      : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      itemCount: setlistsByLiveId.length,
                      itemBuilder: (context, index) {
                        return SetliListItem(index: (index + 1).toString(),
                            songTitle: setlistsByLiveId[index].songTitle);
                      }
                  );
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