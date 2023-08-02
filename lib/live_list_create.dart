import 'package:flutter/material.dart';

class LiveListCreate extends StatefulWidget {
  const LiveListCreate({super.key});
  @override
  State<LiveListCreate> createState() => _LiveListCreateState();
}

class _LiveListCreateState extends State<LiveListCreate> {
  var _nameController = TextEditingController();
  var _dateController = TextEditingController();
  var _locationController = TextEditingController();
  var _memoController = TextEditingController();
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
              child: Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Text('ライブ情報', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text('ライブ名')
                        ),
                        Expanded(
                          flex: 7,
                          child: TextField(
                            controller: _nameController,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                            flex: 3,
                            child: Text('日付')
                        ),
                        Expanded(
                          flex: 7,
                          child: TextField(
                            controller: _dateController,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                            flex: 3,
                            child: Text('場所')
                        ),
                        Expanded(
                          flex: 7,
                          child: TextField(
                            controller: _locationController,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                            flex: 3,
                            child: Text('メモ')
                        ),
                        Expanded(
                          flex: 7,
                          child: TextField(
                            controller: _memoController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              )
            )
          ],
        )
      )
    );

  }
}