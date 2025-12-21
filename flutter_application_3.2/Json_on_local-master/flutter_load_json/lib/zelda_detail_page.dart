import 'package:flutter/material.dart';
import 'zelda_character_model.dart';

class CharacterDetailPage extends StatefulWidget {
  final Character character;
  const CharacterDetailPage(this.character, {super.key});

  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  final double characterAvatarSize = 150.0;
  bool _imageLoadFailed = false;

  String _getInitials(String name) {
    return name
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .take(2)
        .join();
  }

  Widget get characterImage {
    return GestureDetector(
      onTap: null, // Deshabilitado cuando son iniciales
      child: Hero(
        tag: widget.character.id,
        child: widget.character.image.isEmpty || _imageLoadFailed
            ? CircleAvatar(
                radius: characterAvatarSize / 2,
                backgroundColor: const Color(0xFF97CE4C),
                child: Text(
                  _getInitials(widget.character.name),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Container(
                height: characterAvatarSize,
                width: characterAvatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1.0, 2.0),
                      blurRadius: 2.0,
                      spreadRadius: -1.0,
                      color: Color(0x33000000),
                    ),
                    BoxShadow(
                      offset: Offset(2.0, 1.0),
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                      color: Color(0x24000000),
                    ),
                    BoxShadow(
                      offset: Offset(3.0, 1.0),
                      blurRadius: 4.0,
                      spreadRadius: 2.0,
                      color: Color(0x1f000000),
                    ),
                  ],
                  color: const Color(0xFF3C3E44),
                ),
                child: ClipOval(
                  child: Image.network(
                    widget.character.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      Future.microtask(
                        () => setState(() => _imageLoadFailed = true),
                      );
                      return Container(
                        color: const Color(0xFF97CE4C),
                        child: Center(
                          child: Text(
                            _getInitials(widget.character.name),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Widget get characterProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      color: const Color(0xFF24282F),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          characterImage,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.character.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Només utilitzem camps existents: race i game
          Text(
            '${widget.character.race} - ${widget.character.game}',
            style: const TextStyle(
              color: Color(0xFF97CE4C),
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24282F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF24282F),
        elevation: 0,
        title: Text(
          'Meet ${widget.character.name}',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[characterProfile],
      ),
    );
  }
}
