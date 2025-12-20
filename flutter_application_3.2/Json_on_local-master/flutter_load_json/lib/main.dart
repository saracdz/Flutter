import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'zelda_character_model.dart';
import 'zelda_list.dart';
import 'new_character_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sara Conejo Zelda App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF24282F),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF97CE4C),
          secondary: Color(0xFF00B5CC),
        ),
      ),
      home: const MyHomePage(
        title: 'Sara Conejo Zelda App',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Character> initialCharacters = [];
  bool isLoading = true;
  Map<String, int> ratings = {};
  bool sortByRating = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialCharacters();
  }

  Future<void> _fetchInitialCharacters() async {
    try {
      final url = Uri.parse('https://zelda.fanapis.com/api/characters?limit=50');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['data'];

        final fetched = results.map((json) => Character.fromJson(json)).toList();
        await _loadRatings(fetched);
        setState(() {
          initialCharacters = fetched;
          _applySorting();
          isLoading = false;
        });
      } else {
        // Si el servidor responde con error, detener el loading para mostrar la vista vacía.
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadRatings(List<Character> characters) async {
    final prefs = await SharedPreferences.getInstance();
    for (final c in characters) {
      final r = prefs.getInt('rating_${c.id}') ?? 0;
      ratings[c.id] = r;
    }
  }

  Future<void> _setRating(Character c, int r) async {
    ratings[c.id] = r;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('rating_${c.id}', r);
    setState(() {
      _applySorting();
    });
  }

  void _toggleSort() {
    setState(() {
      sortByRating = !sortByRating;
      _applySorting();
    });
  }

  void _applySorting() {
    if (sortByRating) {
      initialCharacters.sort((a, b) {
        final ra = ratings[a.id] ?? 0;
        final rb = ratings[b.id] ?? 0;
        if (rb != ra) return rb.compareTo(ra);
        return a.name.compareTo(b.name);
      });
    } else {
      initialCharacters.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  Future _showNewCharacterForm() async {
    Character? newCharacter =
        await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return const AddCharacterFormPage();
      },
    ));

    if (newCharacter != null) {
      initialCharacters.add(newCharacter);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF24282F),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            tooltip: sortByRating ? 'Ordenar por nombre' : 'Ordenar por rating',
            icon: Icon(
              sortByRating ? Icons.sort_by_alpha : Icons.star,
              color: Colors.white,
            ),
            onPressed: _toggleSort,
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _showNewCharacterForm,
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF24282F),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Color(0xFF97CE4C),
                )
              : CharacterList(
                  initialCharacters,
                  ratings: ratings,
                  onRate: _setRating,
                ),
        ),
      ),
    );
  }
}
