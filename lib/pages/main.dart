import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:soundboard/redux/core/app/actions.dart';
import 'package:soundboard/redux/core/app/model.dart';
import 'package:soundboard/widgets/touchy.dart';
import 'package:audioplayers/audio_cache.dart';

class HomePage extends StatefulWidget {
  static final AudioCache player = AudioCache();

  @override
  HomePageState createState() {
    player.loadAll([
      'wena.mp3',
      'karmona_saquen_las_guamas.mp3',
    ]);
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _backgroundColorTransition;
  Animation<Color> _appBarColorTransition;
  Animation<Color> _titleColorTransition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    _backgroundColorTransition = ColorTween(
      begin: Colors.white,
      end: Colors.black,
    ).animate(_controller);
    _appBarColorTransition = ColorTween(
      begin: Colors.green,
      end: Colors.black,
    ).animate(_controller);
    _titleColorTransition = ColorTween(
      begin: Colors.white,
      end: Colors.greenAccent.shade700,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _HomePageViewModel>(
      converter: (store) => _HomePageViewModel(
            state: store.state,
            toggleDarkMode: () {
              store.dispatch(ToggleDarkMode());
            },
          ),
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, _HomePageViewModel vm) {
    vm.darkMode ? _controller.forward() : _controller.reverse();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Soundboard',
          style: TextStyle(
            color: _titleColorTransition.value,
          ),
        ),
        backgroundColor: _appBarColorTransition.value,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              vm.darkMode ? Icons.brightness_high : Icons.brightness_low,
            ),
            onPressed: vm.toggleDarkMode,
          ),
        ],
      ),
      backgroundColor: _backgroundColorTransition.value,
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6.0,
            mainAxisSpacing: 6.0,
            childAspectRatio: 1.0,
          ),
          children: <Widget>[
            TouchySticker(
              imageAssetPath: 'assets/wena.png',
              onTap: () {
                HomePage.player.play(
                  'wena.mp3',
                  volume: 1.0,
                );
              },
            ),
            TouchySticker(
              imageAssetPath: 'assets/karmona.png',
              onTap: () {
                HomePage.player.play(
                  'karmona_saquen_las_guamas.mp3',
                  volume: 1.0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _HomePageViewModel {
  final AppState state;
  final Function toggleDarkMode;

  _HomePageViewModel({
    this.state,
    this.toggleDarkMode,
  });

  bool get darkMode => state.darkMode;
}
