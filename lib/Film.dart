class Film {
  final String title;
  final String description;
  final String image;
  final int price;

  const Film(this.title, this.image, this.description, this.price);

  // Alias for French compatibility
  int get prix => price;

  // Deux films sont égaux s'ils ont le même titre (clé dans la base SQLite)
  @override
  bool operator ==(Object other) => other is Film && other.title == title;

  @override
  int get hashCode => title.hashCode;
}
