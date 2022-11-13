import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiddo/app/core/values/fonts.dart';
import 'package:kiddo/app/widgets/number_widgets/numberGridItem.dart';
import 'package:kiddo/app/widgets/number_widgets/numberItem.dart';

import '../../core/values/colors.dart';
import '../../global/utils.dart';

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({Key? key, required this.numbers}) : super(key: key);
  final List<dynamic> numbers;

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> selected = {};
  late TabController _tabController;

  late AudioPlayer player;

  playSelected() async {
    if (selected["sound"] != "") {
      await player.setAsset('assets/sounds/${selected['sound']}');
      if (selected["language"] == "bn") {
        player.setVolume(3);
      }
      Timer(const Duration(milliseconds: 500), () {
        player.play();
      });
    }
  }

  playClick() async {
    await player.setAsset('assets/sounds/click.mp3');
    player.play();
    Timer(const Duration(milliseconds: 1000), () {
      setSelected(0);
    });
  }

  setSelected(int index) {
    setState(() {
      selected = widget.numbers[index];
    });
    playSelected();
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    playClick();
    _tabController = TabController(vsync: this, length: widget.numbers.length);
    _tabController.addListener(() {
      setSelected(_tabController.index);
    });
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 32,
            color: textDark,
          ),
        ),
      ),
      backgroundColor: background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 172 - 200,
            child: DefaultTabController(
              length: widget.numbers.length,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ...widget.numbers.map((number) {
                    return NumberItem(selected: number);
                  }).toList(),
                ],
              ),
            ),
          ),
          Container(
            height: 172,
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            color: backgroundLight,
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              crossAxisCount: 2,
              children: [
                // moviesTitles.map((title) => Tab(text: title)).toList()
                ...widget.numbers.map((number) {
                  return InkWell(
                    onTap: () {
                      _tabController.index = number['id'] - 1;
                    },
                    child: NumberGridItem(
                      number: number,
                      selected: selected,
                    ),
                  );
                }).toList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
