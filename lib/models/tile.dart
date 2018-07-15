import 'package:meta/meta.dart';

@immutable
class TouchyTileModel {
  final String imagePath;
  final String soundPath;

  TouchyTileModel({
    this.imagePath,
    this.soundPath,
  });
}
