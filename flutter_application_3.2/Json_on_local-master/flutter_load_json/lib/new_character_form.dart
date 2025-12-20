import 'package:flutter/material.dart';
import 'zelda_character_model.dart';

class AddCharacterFormPage extends StatefulWidget {
  const AddCharacterFormPage({super.key});

  @override
  _AddCharacterFormPageState createState() => _AddCharacterFormPageState();
}

class _AddCharacterFormPageState extends State<AddCharacterFormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController raceController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  String gender = 'Unknown';
  final List<String> genderOptions = ['Male', 'Female', 'Unknown'];

void submitCharacter(BuildContext context) {
  if (nameController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text('You forgot to insert the character name'),
    ));
  } else {
    var newCharacter = Character(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text,
      race: raceController.text.isNotEmpty ? raceController.text : 'Unknown',
      image: imageController.text.isNotEmpty
          ? imageController.text
          : 'https://static.wikia.nocookie.net/zelda_gamepedia_en/images/8/85/Link_BotW.png',
      game: 'Breath of the Wild', // exemple
    );
    Navigator.of(context).pop(newCharacter);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Add Zelda character', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF24282F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color(0xFF24282F),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
        child: Column(
          children: [
            // NAME
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Character Name',
                  labelStyle: TextStyle(color: Color(0xFF97CE4C)),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF97CE4C))),
                ),
              ),
            ),

            // RACE
                        // IMAGE URL
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                            controller: imageController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Image URL (optional)',
                              labelStyle: TextStyle(color: Color(0xFF97CE4C)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF97CE4C))),
                            ),
                          ),
                        ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: raceController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Race',
                  labelStyle: TextStyle(color: Color(0xFF97CE4C)),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF97CE4C))),
                ),
              ),
            ),

            // GENDER
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: DropdownButtonFormField<String>(
                value: gender,
                dropdownColor: const Color(0xFF3C3E44),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  labelStyle: TextStyle(color: Color(0xFF97CE4C)),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF97CE4C))),
                ),
                items: genderOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    gender = newValue!;
                  });
                },
              ),
            ),

            // BUTTON
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF97CE4C),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => submitCharacter(context),
                  child: const Text('Submit Character'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
