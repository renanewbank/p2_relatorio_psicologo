import 'package:flutter/material.dart';
import '../../models/report.dart';
import '../../data/hive_boxes.dart';

class ReportDetailPage extends StatelessWidget {
  final Report report;

  const ReportDetailPage({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patientsBox = getPatientsBox();
    final patient = patientsBox.values.cast().firstWhere((p) => p.id == report.patientId, orElse: () => null);
    final patientName = patient != null ? patient.name : 'Desconhecido';
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe do Relatório')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Paciente: $patientName'),
          const SizedBox(height: 8),
          Text('Data: ${report.date.toLocal().toString().split(' ')[0]}'),
          const SizedBox(height: 8),
          Text('Tipo: ${report.isPresential ? 'Presencial' : 'Online'}'),
          const SizedBox(height: 8),
          Text('Humor: ${report.mood.toInt()}'),
          const SizedBox(height: 8),
          const Text('Observações:'),
          Text(report.notes),
        ]),
      ),
    );
  }
}
