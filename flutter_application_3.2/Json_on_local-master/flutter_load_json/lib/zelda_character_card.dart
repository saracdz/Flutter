import 'package:flutter/material.dart';
import 'zelda_character_model.dart';
import 'zelda_detail_page.dart';

class CharacterCard extends StatefulWidget {
  final Character character;
  final int rating;
  final void Function(int rating) onRate;

  const CharacterCard(
    this.character, {
    super.key,
    required this.rating,
    required this.onRate,
  });

  @override
  _CharacterCardState createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {

  Widget get characterImage {
    return Hero(
      tag: widget.character.id,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.character.image),
          ),
        ),
      ),
    );
  }

  Widget get characterCard {
    return Positioned(
      right: 0.0,
      child: SizedBox(
        width: 290,
        height: 115,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: const Color(0xFF3C3E44),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // NAME
                Text(
                  widget.character.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // RACE
                Text(
                  widget.character.race,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
                // RATING STARS
                Row(
                  children: List.generate(5, (i) {
                    final starIndex = i + 1;
                    final filled = widget.rating >= starIndex;
                    return IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      constraints: const BoxConstraints(),
                      iconSize: 18,
                      color: const Color(0xFF97CE4C),
                      onPressed: () => widget.onRate(starIndex),
                      icon: Icon(filled ? Icons.star : Icons.star_border),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCharacterDetailPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CharacterDetailPage(widget.character);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showCharacterDetailPage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              characterCard,
              Positioned(top: 7.5, child: characterImage),
            ],
          ),
        ),
      ),
    );
  }
}
