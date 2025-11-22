import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MyApp()); // Inicia l’app carregant el widget MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Arrel de l'aplicació
    return MaterialApp(
      title: 'SARA CONEJO DIAZ - Activitat 3',
      theme: ThemeData(
        // Tema principal de l'app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(), // Pantalla principal
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  final String title = 'SARA CONEJO DIAZ - Activitat 3';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Clau que controla i valida el formulari
  final _formKey = GlobalKey<FormBuilderState>();

  // Variable per comptar quants caràcters s'han escrit al text field
  int textLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        title: Text(widget.title),
      ),

      // Contingut scrollable per evitar overflow
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),

          // Formulari principal
          child: FormBuilder(
            key: _formKey, // Assignem la clau del formulari
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //
                // CHOICE CHIPS
                
                FormBuilderChoiceChips<String>(
                  name: 'platform_choice', // Nom intern del camp
                  initialValue: 'Flutter', // Valor per defecte
                  decoration: InputDecoration(
                    labelText: 'Tria una plataforma',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  // Opcions que pot seleccionar l’usuari
                  options: const [
                    FormBuilderChipOption(value: 'Flutter', child: Text('Flutter')),
                    FormBuilderChipOption(value: 'Android', child: Text('Android')),
                    FormBuilderChipOption(value: 'ChromeOS', child: Text('Chrome OS')),
                  ],

                  spacing: 10, // Espai entre xips
                  runSpacing: 10, // Espai vertical entre files
                  selectedColor: Colors.deepPurple[300],
                  backgroundColor: Colors.deepPurple[100],
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),

                const SizedBox(height: 20),

                // SWITCH
                //
                Container(
                  // Decoració del contenidor del switch
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // Títol i switch
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Activar notificacions",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),

                      // Switch integrat amb FormBuilder
                      FormBuilderSwitch(
                        name: 'notifications_switch',
                        title: const Text('Rebre notificacions'),
                        initialValue: false,
                        decoration: const InputDecoration(border: InputBorder.none),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                //
                // TEXT FIELD
                //
                FormBuilderTextField(
                  name: 'username_field',
                  onChanged: (value) {
                    // Actualitzem el recompte de caràcters escrits
                    setState(() {
                      textLength = value?.length ?? 0;
                    });
                  },

                  decoration: InputDecoration(
                    labelText: 'Nom d\'usuari',
                    helperText: 'Màxim 15 caràcters ($textLength/15)',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),

                  // Validacions
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),   // Obligatori
                    FormBuilderValidators.maxLength(15), // Max 15 caràcters
                  ]),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),

                const SizedBox(height: 20),

                /
                // DROPDOWN
                //
                FormBuilderDropdown(
                  name: 'dropdown_values', // Nom intern del camp
                  decoration: const InputDecoration(
                    labelText: 'Selecciona una opció',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),

                  // Llista d’opcions
                  items: ['Opció A', 'Opció B', 'Opció C']
                      .map(
                        (opt) => DropdownMenuItem(
                          value: opt,
                          child: Text(opt),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 20),

                //
                // RADIO GROUP
                //
                FormBuilderRadioGroup(
                  name: 'radio_select',
                  decoration: const InputDecoration(
                    labelText: 'Escull una resposta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  orientation: OptionsOrientation.vertical,

                  // Opcions del RadioGroup
                  options: const [
                    FormBuilderFieldOption(value: 'R1', child: Text('Resposta 1')),
                    FormBuilderFieldOption(value: 'R2', child: Text('Resposta 2')),
                    FormBuilderFieldOption(value: 'R3', child: Text('Resposta 3')),
                  ],
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),

      //
      // BOTÓ flotant per enviar el formulari
      //
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.send),
        onPressed: () {
          _formKey.currentState?.save(); // Guarda tot el formulari
          final data = _formKey.currentState?.value ?? {}; // Dades recollides

          // String amb totes les respostes
          String summary = '''
Platform: ${data['platform_choice']}
Notificacions: ${data['notifications_switch']}
Nom d'usuari: ${data['username_field']}
Dropdown: ${data['dropdown_values']}
Radio: ${data['radio_select']}
''';

          showSummaryDialog(context, summary); // Mostra les dades
        },
      ),
    );
  }
}

//
// FUNCIONS AUXILIARS
//

// Mostra un AlertDialog amb totes les respostes del formulari
void showSummaryDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Formulari enviat"),
      icon: const Icon(Icons.check_circle, color: Colors.green, size: 45),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Tancar"),
        ),
      ],
    ),
  );
}
