import 'dart:async';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiddo/app/global/utils.dart';

import 'package:kiddo/app/widgets/letters_widgets/letterGridItem.dart';
import 'package:kiddo/app/widgets/letters_widgets/letterItem.dart';

import '../../core/values/colors.dart';
import '../../core/values/fonts.dart';

class LettersScreen extends StatefulWidget {
  const LettersScreen({Key? key, required this.letters}) : super(key: key);
  final List<dynamic> letters;

  @override
  State<LettersScreen> createState() => _LettersScreenState();
}

class _LettersScreenState extends State<LettersScreen>
    with TickerProviderStateMixin {
  var list = [for (var i = 0; i < 26; i++) i];
  Map<String, dynamic> selected = {};
  late TabController _tabController;

  late AudioPlayer player;

  setSelected(int index) {
    setState(() {
      selected = widget.letters[index];
    });
    playSelected();
  }

  playClick() async {
    await player.setAsset('assets/sounds/click.mp3');
    player.play();
    Timer(const Duration(milliseconds: 1000), () {
      setSelected(0);
    });
  }

  playSelected() async {
    if (selected["sound"] != "") {
      await player.setAsset('assets/sounds/${selected['sound']}');
      Timer(const Duration(milliseconds: 500), () {
        player.play();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.letters.length);
    _tabController.addListener(() {
      setSelected(_tabController.index);
    });
    player = AudioPlayer();
    playClick();
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          leading: Container(
            padding: const EdgeInsets.only(left: 0),
            margin: const EdgeInsets.only(left: 16),
            child: IconButton(
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
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 0),
              margin: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () {
                  _key.currentState!.openEndDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  size: 32,
                  color: textDark,
                ),
              ),
            )
          ],
          backgroundColor: background,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        endDrawer: Drawer(
            width: 188,
            backgroundColor: backgroundLight,
            child: Container(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              height: double.infinity,
              decoration: const BoxDecoration(color: backgroundLight),
              child: GridView.count(
                // padding: const EdgeInsets.symmetric(horizontal: 32),
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                crossAxisCount: 2,
                children: [
                  ...widget.letters.map((e) {
                    return InkWell(
                      onTap: () {
                        _tabController.index = e['id'] - 1;
                        _key.currentState!.closeEndDrawer();
                      },
                      child: LetterGridItem(
                        letter: e,
                        font: Fonts.english2,
                        selected: selected,
                      ),
                    );
                  }).toList(),
                ],
              ),
            )),
        backgroundColor: background,
        body: DefaultTabController(
          length: 26,
          child: TabBarView(
            controller: _tabController,
            children: [
              ...widget.letters.map((e) {
                return InkWell(
                  onTap: playSelected,
                  child: LetterItem(selected: e),
                );
              }).toList(),
            ],
          ),
        ));
  }
}
