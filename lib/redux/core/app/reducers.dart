import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'actions.dart';
import 'model.dart';

typedef AppState AppStateReducer(AppState state, action);

AppState _darkModeReducer(AppState state, ToggleDarkMode action) {
  return state.copyWith(darkMode: !state.darkMode);
}

AppStateReducer appStateReducer = combineReducers<AppState>([
  TypedReducer<AppState, ToggleDarkMode>(_darkModeReducer),
]);
