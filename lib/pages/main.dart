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
  int _activeIndex = 0;

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
        brightness: vm.darkMode ? Brightness.dark : Brightness.light,
      ),
      backgroundColor: _backgroundColorTransition.value,
      drawer: Theme(
        data: ThemeData(
          brightness: vm.darkMode ? Brightness.dark : Brightness.light,
        ),
        child: Drawer(
          semanticLabel: 'Menu',
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                padding: const EdgeInsets.all(
                  0.0,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/header.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: vm.darkMode ? Color(0x99000000) : Color(0x99FFFFFF),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Sonidos'),
                onTap: () => Navigator.of(context).pushNamed('/sounds'),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Acerca de'),
              ),
            ],
          ),
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
