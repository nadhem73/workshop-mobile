class Film {
  final String title;
  final String description;
  final String image;
  final int price;

  const Film(this.title, this.image, this.description, this.price);

  // Alias for French compatibility
  int get prix => price;
}