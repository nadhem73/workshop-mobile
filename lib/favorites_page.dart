import 'package:flutter/material.dart';
import 'Film.dart';
import 'favorites.dart';
import 'film_detail.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6C63FF);
    const backgroundColor = Color(0xFFF8F9FA);
    const textPrimary = Color(0xFF1A1A2E);
    const textSecondary = Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Mes favoris',
          style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        iconTheme: const IconThemeData(color: textPrimary),
      ),
      body: ValueListenableBuilder<List<Film>>(
        valueListenable: favoritesNotifier,
        builder: (context, favorites, _) {
          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: primaryColor.withValues(alpha: 0.4)),
                  const SizedBox(height: 16),
                  const Text(
                    'Aucun favori pour le moment',
                    style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ajoutez des films depuis leur page de détail',
                    style: TextStyle(color: textSecondary, fontSize: 14),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final film = favorites[index];
              return Card(
                elevation: 2,
                shadowColor: Colors.black12,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/${film.image}',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(Icons.movie, size: 40, color: Colors.grey),
                    ),
                  ),
                  title: Text(
                    film.title,
                    style: const TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${film.prix} DT',
                    style: const TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.redAccent),
                    tooltip: 'Retirer des favoris',
                    onPressed: () => toggleFavorite(film),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilmDetail(film: film)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
