import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:soundboard/pages/main.dart';
import 'package:soundboard/pages/sounds/main.dart';
import 'package:soundboard/redux/core/app/model.dart';
import 'package:soundboard/redux/core/app/reducers.dart';

void main() {
  final Store<AppState> store = Store<AppState>(
    appStateReducer,
    middleware: [],
    initialState: AppState(),
  );

  runApp(new MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({
    Key key,
    this.store,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'SoundBoard',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomePage(),
        routes: {
          '/sounds': (BuildContext context) => SoundsPage(),
        },
      ),
    );
  }
}
