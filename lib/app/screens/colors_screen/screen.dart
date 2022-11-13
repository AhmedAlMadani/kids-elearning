import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/values/colors.dart';
import '../../core/values/fonts.dart';
import '../../global/extensions.dart';

class ColorsScreen extends StatefulWidget {
  const ColorsScreen({Key? key, required this.colors}) : super(key: key);
  final List<dynamic> colors;

  @override
  State<ColorsScreen> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> with SingleTickerProviderStateMixin {
  Map<String, dynamic> selected = {};
  late TabController _tabController;
  late AudioPlayer player;

  playSelected() async {
    if (selected["sound"] != "") {
      await player.setAsset('assets/sounds/${selected['sound']}');
      player.setVolume(3);
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
      selected = widget.colors[index];
    });
    playSelected();
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    playClick();
    _tabController = TabController(vsync: this, length: widget.colors.length);
    _tabController.addListener(() {
      setSelected(_tabController.index);
    });
  }

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
      body: DefaultTabController(
        length: widget.colors.length,
        child: TabBarView(
          controller: _tabController,
          children: [
            ...widget.colors.map((color) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: CircleAvatar(
                      radius: (MediaQuery.of(context).size.width / 2) - 64,
                      backgroundColor: HexColor.fromHex(color['color']),
                    ),
                  ),
                  AutoSizeText(
                    color['primary'],
                    style: const TextStyle(
                      fontFamily: Fonts.english2,
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
