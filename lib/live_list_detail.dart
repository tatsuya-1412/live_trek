import 'package:flutter/material.dart';
import 'package:live_trek/model/live.dart';
import 'package:gap/gap.dart';
import 'package:live_trek/setlist_list.dart';

class LiveListDetail extends StatefulWidget {
  const LiveListDetail({super.key, required this.live});
  final Live? live;
  @override
  State<LiveListDetail> createState() => _LiveListDetailState();
}

class _LiveListDetailState extends State<LiveListDetail> {
  String memoText = '';

  String getDate(DateTime datetime) {
    return "${datetime.year}-${datetime.month}-${datetime.day}";
  }

  String getTime(DateTime datetime) {
    return "${datetime.hour}:${datetime.minute}";
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
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.3,
                    child: Image.asset(
                      widget.live!.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          widget.live!.title,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            const Icon(Icons.person),
                            Text(
                              widget.live!.artist,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            const Icon(Icons.date_range),
                            Text(
                              getDate(widget.live!.performanceDate),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            Text(
                              widget.live!.venue,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            const Icon(Icons.access_time_outlined),
                            Text(
                              getTime(widget.live!.openTime),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            const Icon(Icons.access_time_outlined),
                            Text(
                              getTime(widget.live!.startTime),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Container(
                          width: 340,
                          height: 120,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('メモ:', style: TextStyle(fontSize: 16)),
                              const Gap(5),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    memoText,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Gap(16),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => SetlistList(liveId: widget.live!.id),
                              )
                            );
                          },
                          icon: Icon(Icons.music_note),
                          label: Text('セットリスト'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
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
    );
  }
}