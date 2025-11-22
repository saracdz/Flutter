// Llibreries necessàries per a Flutter i per al formulari
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Punt d'entrada de l'app
void main() {
  runApp(const MyApp());
}

// Widget principal de l'aplicació
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormBuilder Demo',   // Títol de l'app
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),    // Pantalla principal
    );
  }
}

// Pantalla on es mostra el formulari
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Clau per controlar, validar i recuperar les dades del formulari
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Builder"), // Títol superior
      ),

      // 
      // COS PRINCIPAL AMB TOTS ELS CAMPS 
      // 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,  // Assigna la clau al formulari
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Títol gran del formulari
                const FormTitle(title: "FORMULARI VEHICLES"),

                // Subtítol
                const FormLabelGroup(label: "Velocitat del vehicle"),

                // GROUP 1 = RadioGroup (Seleccionar UNA opció)
                FormBuilderRadioGroup(
                  name: "vehicle_speed_radio",
                  decoration: const InputDecoration(
                    labelText: "Selecciona la velocitat actual",
                  ),
                  options: const [
                    FormBuilderFieldOption(value: "Alta"),
                    FormBuilderFieldOption(value: "Mitjana"),
                    FormBuilderFieldOption(value: "Baixa"),
                  ],
                  onChanged: (value) => debugPrint("Radio → $value"),
                ),

                const SizedBox(height: 20),

                // GROUP 2 = Camps de text
                const FormLabelGroup(label: "Comentaris"),
                FormBuilderTextField(
                  name: "vehicle_comment",
                  decoration: const InputDecoration(
                    labelText: "Escriu alguna remarca",
                  ),
                ),

                const SizedBox(height: 20),

                // GROUP 3 = Dropdown (Seleccionar UNA opció)
                const FormLabelGroup(label: "Velocitat alta del vehicle"),
                FormBuilderDropdown(
                  name: "vehicle_speed_dropdown",
                  decoration: const InputDecoration(
                    labelText: "Selecciona un nivell",
                  ),
                  items: const [
                    DropdownMenuItem(value: "High", child: Text("High")),
                    DropdownMenuItem(value: "Medium", child: Text("Medium")),
                    DropdownMenuItem(value: "Low", child: Text("Low")),
                  ],
                ),

                const SizedBox(height: 20),

                // GROUP 4 = CheckboxGroup (Seleccionar MÉS d'una opció)
                const FormLabelGroup(label: "Velocitat última hora"),
                FormBuilderCheckboxGroup(
                  name: "vehicle_speed_checkbox",
                  options: const [
                    FormBuilderFieldOption(value: "Ràpida"),
                    FormBuilderFieldOption(value: "Normal"),
                    FormBuilderFieldOption(value: "Lenta"),
                  ],
                  onChanged: (value) =>
                      debugPrint("Checkbox → ${value.toString()}"),
                ),
              ],
            ),
          ),
        ),
      ),

      // 
      //  BOTÓ FLOTANT QUE ENVIA EL FORMULARI 
      // 
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          // Guarda i valida totes les dades del formulari
          _formKey.currentState?.saveAndValidate();

          // Recupera totes les dades en format mapa
          String? formString = _formKey.currentState?.value.toString();

          // Mostra les dades en un AlertDialog
          alertDialog(context, formString!);
        },
      ),
    );
  }
}

//
//  FUNCIÓ QUE MOSTRA LA FINESTRA POPUP AMB LES DADES 
// 
void alertDialog(BuildContext context, String formString) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Submission Completed"),  // Títol del Popup
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 40, color: Colors.green),
            const SizedBox(height: 10),
            Text(formString),  // Mostra totes les dades introduïdes
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Tancar el popup
            child: const Text("Tancar"),
          ),
        ],
      );
    },
  );
}

// 
// WIDGETS PERSONALITZATS PER TITOLS I SUBTITOLS 
// 

class FormTitle extends StatelessWidget {
  final String title;

  const FormTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class FormLabelGroup extends StatelessWidget {
  final String label;

  const FormLabelGroup({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}

