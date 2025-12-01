import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/hive_boxes.dart';
import '../../models/patient.dart';
import 'patient_form_page.dart';
import 'patient_detail_page.dart';

class PatientsPage extends StatelessWidget {
  const PatientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = getPatientsBox();
    return Scaffold(
      appBar: AppBar(title: const Text('Pacientes')),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Patient> b, _) {
          final patients = b.values.toList().cast<Patient>();
          if (patients.isEmpty) return const Center(child: Text('Nenhum paciente cadastrado'));
          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final p = patients[index];
              return ListTile(
                title: Text(p.name),
                subtitle: Text('Idade: ${p.age}'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PatientDetailPage(patient: p)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PatientFormPage()),
        ),
      ),
    );
  }
}
