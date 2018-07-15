import 'package:meta/meta.dart';
import 'tile.dart';

///
/// Una colección es una agrupación de diferentes sonidos
/// por una misma persona
///
@immutable
class SoundCollectionModel {
  /// Titulo a mostrar en el listado general
  final String title;

  /// Imágen a mostrar en el listado general, así como header
  /// en la página donde se listan todos los sonidos de la colección
  final String headerAssetPath;

  ///
  /// Lista de sonidos
  ///
  final List<TouchyTileModel> models;

  SoundCollectionModel({
    this.title,
    this.headerAssetPath,
    this.models,
  });
}
