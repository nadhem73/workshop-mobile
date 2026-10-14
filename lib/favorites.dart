import 'package:flutter/foundation.dart';
import 'Film.dart';
import 'database_helper.dart';

// Liste des films favoris partagée dans toute l'application
// (copie en mémoire de la table SQLite "favorites")
final ValueNotifier<List<Film>> favoritesNotifier = ValueNotifier<List<Film>>([]);

bool isFavorite(Film film) => favoritesNotifier.value.contains(film);

// Charge les favoris enregistrés dans la base au démarrage
Future<void> loadFavorites() async {
  favoritesNotifier.value = await DatabaseHelper.instance.getFavorites();
}

Future<void> toggleFavorite(Film film) async {
  final favorites = List<Film>.from(favoritesNotifier.value);
  if (favorites.contains(film)) {
    favorites.remove(film);
    await DatabaseHelper.instance.deleteFavorite(film);
  } else {
    favorites.add(film);
    await DatabaseHelper.instance.insertFavorite(film);
  }
  favoritesNotifier.value = favorites;
}
