import 'package:flutter/material.dart';
import 'zelda_character_model.dart';
import 'zelda_character_card.dart';

class CharacterList extends StatelessWidget {
  final List<Character> characters;
  final Map<String, int> ratings;
  final void Function(Character character, int rating) onRate;

  const CharacterList(
    this.characters, {
    super.key,
    required this.ratings,
    required this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final c = characters[index];
        final r = ratings[c.id] ?? 0;
        return CharacterCard(
          c,
          rating: r,
          onRate: (newRating) => onRate(c, newRating),
        );
      },
    );
  }
}
