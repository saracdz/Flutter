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
    // Usamos un placeholder para imagen y 'Unknown' para game.
    const String placeholderImage =
        'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/8/85/Link_BotW.png';

    return Character(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? 'Unknown').toString(),
      race: (json['race'] ?? 'Unknown').toString(),
      image: (json['image'] ?? placeholderImage).toString(),
      game: (json['game'] ?? 'Unknown').toString(),
    );
  }
}
