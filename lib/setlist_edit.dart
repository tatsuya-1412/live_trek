import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:live_trek/model/setlist.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SetlistEdit extends StatefulWidget {
  const SetlistEdit({super.key, required this.liveId});
  final String liveId;
  @override
  State<SetlistEdit> createState() => _SetlistEditState();
}

class _SetlistEditState extends State<SetlistEdit> {

  List<SetlistItem> setlistItems = [];
  int inputFrameCount = 1;

  void add() {
    setState(() {
      inputFrameCount += 1;
      setlistItems.add(SetlistItem.create(inputFrameCount, "", ""));
    });
  }

  @override
  void initState() {
    setlistItems.add(SetlistItem.create(inputFrameCount, "", ""));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SetlistNotifier>(
      builder: (context, setlists, child) => Scaffold(
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
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    color: Colors.grey,
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      '楽曲名',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    color: Colors.grey,
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      'アーティスト名',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(20),
                            // Row(
                            //   children: const [
                            //     Expanded(
                            //       flex: 4,
                            //       child: TextField(
                            //         decoration: InputDecoration(
                            //           // labelText: 'TextField 1',
                            //           contentPadding: EdgeInsets.all(10),
                            //           border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(width: 5), // 適宜スペーシングを調整
                            //     Expanded(
                            //       flex: 3,
                            //       child: TextField(
                            //         decoration: InputDecoration(
                            //           // labelText: 'TextField 2',
                            //           contentPadding: EdgeInsets.all(10),
                            //           border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const Gap(10),
                            ...setlistItems.map((item) => SetlistFieldItem(item)),
                            ElevatedButton(
                              onPressed: () {
                                add();
                              },
                              child: Text('入力枠の追加'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                for (var item in setlistItems) {
                                  var uuid = Uuid();
                                  setlists.add(
                                    Setlist(
                                      id: uuid.v4(),
                                      liveId: widget.liveId,
                                      songOrder: item.order,
                                      songTitle: item.songController.text,
                                      artistName: item.artistController.text,
                                      notes: "aaa"
                                    )
                                  );
                                }},
                              child: Text('保存'),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SetlistFieldItem(
    SetlistItem setlistItem,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                controller: setlistItem.songController,
                decoration: const InputDecoration(
                  // labelText: 'TextField 1',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5), // 適宜スペーシングを調整
            Expanded(
              flex: 3,
              child: TextField(
                controller: setlistItem.artistController,
                // onChanged: (text) {
                //   var uuid = Uuid();
                //   setlists.add(
                //     Setlist(
                //       id: uuid.v4(),
                //       liveId: liveId,
                //       songOrder: songOrder,
                //       songTitle: songTitle,
                //       artistName: artistName,
                //       notes: ""
                //     )
                //   );
                // },
                decoration: const InputDecoration(
                  // labelText: 'TextField 2',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(10),
      ],
    );
  }
}

class SetlistFieldItem extends StatelessWidget {
  final SetlistItem setlistItem;

  SetlistFieldItem({required this.setlistItem});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 4,
          child: TextField(
            decoration: InputDecoration(
              // labelText: 'TextField 1',
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        SizedBox(width: 5), // 適宜スペーシングを調整
        Expanded(
          flex: 3,
          child: TextField(
            decoration: InputDecoration(
              // labelText: 'TextField 2',
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SetlistItem {
  final int order;
  final TextEditingController songController;
  final TextEditingController artistController;
  final String songTitle;
  final String artistName;

  SetlistItem({
    required this.order,
    required this.songController,
    required this.artistController,
    required this.songTitle,
    required this.artistName,
  });

  factory SetlistItem.create(int order, String songTitle, String artistName) {
    return SetlistItem(
      order: order,
      songTitle: songTitle,
      artistName: artistName,
      songController: TextEditingController(text: songTitle),
      artistController: TextEditingController(text: artistName),
    );
  }
}