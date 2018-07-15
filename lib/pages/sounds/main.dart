import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:soundboard/redux/core/app/model.dart';

class SoundsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SoundsPageViewModel>(
      converter: (store) => _SoundsPageViewModel(
            appState: store.state,
          ),
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, _SoundsPageViewModel vm) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor:
            vm.darkMode ? Colors.black : Theme.of(context).primaryColor,
        title: Text(
          'Sonidos',
          style: TextStyle(
            color: vm.darkMode ? Colors.greenAccent.shade700 : Colors.white,
          ),
        ),
      ),
      backgroundColor: vm.darkMode ? Colors.black : Colors.white,
    );
  }
}

class _SoundsPageViewModel {
  final AppState appState;

  _SoundsPageViewModel({
    this.appState,
  });

  bool get darkMode => appState.darkMode;
}
