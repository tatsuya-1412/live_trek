import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:live_trek/model/live.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class LiveListCreate extends StatefulWidget {
  const LiveListCreate({super.key});
  @override
  State<LiveListCreate> createState() => _LiveListCreateState();
}

class _LiveListCreateState extends State<LiveListCreate> {
  var _titleController = TextEditingController();
  var _artistController = TextEditingController();
  var _performanceDateController = TextEditingController();
  var _venueController = TextEditingController();
  var _openTimeController = TextEditingController();
  var _startTimeController = TextEditingController();
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
              child: Consumer<LiveNotifier>(
                builder: (context, lives, child) => Container(
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
                              controller: _titleController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text('アーティスト')
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: _artistController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text('公演日')
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: _performanceDateController,
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2000, 1, 1),
                                  maxTime: DateTime(2100, 12, 31),
                                  onConfirm: (date) {
                                    final month = date.month.toString().padLeft(2, '0');
                                    final day = date.day.toString().padLeft(2, '0');
                                    _performanceDateController.value = TextEditingValue(text: '${date.year}/$month/$day');
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.jp
                                );
                              },
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
                              controller: _venueController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text('開場時間')
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: _openTimeController,
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                DatePicker.showTimePicker(context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    onConfirm: (time) {
                                      final hour = time.hour.toString().padLeft(2, '0');
                                      final minute = time.minute.toString().padLeft(2, '0');
                                      _openTimeController.value = TextEditingValue(text: '$hour:$minute');
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.jp
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text('開演時間')
                          ),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: _startTimeController,
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                DatePicker.showTimePicker(context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    onConfirm: (time) {
                                      final hour = time.hour.toString().padLeft(2, '0');
                                      final minute = time.minute.toString().padLeft(2, '0');
                                      _startTimeController.value = TextEditingValue(text: '$hour:$minute');
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.jp
                                );
                              },
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
                      const Gap(20),
                      ElevatedButton.icon(
                        onPressed: () {
                          var uuid = Uuid();
                          lives.add(
                            Live(
                              id: uuid.v4(),
                              title: _titleController.text,
                              artist: _artistController.text,
                              performanceDate: DateFormat('yyyy/MM/dd').parse(_performanceDateController.text),
                              venue: _venueController.text,
                              openTime: DateFormat('HH:mm').parse(_openTimeController.text),
                              startTime: DateFormat('HH:mm').parse(_startTimeController.text),
                              imageUrl: 'images/sumika_live.jpeg',
                            )
                          );
                          // print(lives.lives);
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.create),
                        label: Text('作成'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  )
                )
              )
            )
          ],
        )
      )
    );

  }
}