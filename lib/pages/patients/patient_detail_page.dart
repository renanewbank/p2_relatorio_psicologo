import 'package:flutter/material.dart';
import '../../models/patient.dart';

class PatientDetailPage extends StatelessWidget {
  final Patient patient;

  const PatientDetailPage({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Paciente')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${patient.name}'),
            const SizedBox(height: 8),
            Text('Idade: ${patient.age}'),
            const SizedBox(height: 8),
            Text('CEP: ${patient.cep}'),
            const SizedBox(height: 8),
            Text('Endereço: ${patient.address}'),
            const SizedBox(height: 8),
            Text('Observações:'),
            Text(patient.notes),
          ],
        ),
      ),
    );
  }
}
