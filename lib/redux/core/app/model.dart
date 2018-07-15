import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool darkMode;

  AppState({
    this.darkMode = false,
  });

  AppState copyWith({
    bool darkMode,
  }) {
    return AppState(
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
