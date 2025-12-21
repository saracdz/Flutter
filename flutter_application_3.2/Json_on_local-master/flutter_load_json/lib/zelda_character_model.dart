class Character {
  final String id;
  final String name;
  final String race;
  final String image;
  final String game;

  Character({
    required this.id,
    required this.name,
    required this.race,
    required this.image,
    required this.game,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    // El Zelda API no devuelve imagen ni game para characters.
    // Dejamos imagen vacía para mostrar iniciales por defecto.
    return Character(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? 'Unknown').toString(),
      race: (json['race'] ?? 'Unknown').toString(),
      image: '', // Vacío para forzar iniciales
      game: (json['game'] ?? 'Unknown').toString(),
    );
  }
}
