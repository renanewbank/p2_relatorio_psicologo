import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/hive_boxes.dart';
import '../../models/patient.dart';
import '../../models/report.dart';
import 'report_detail_page.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  Patient? _selectedPatient;
  DateTime? _selectedDate;
  bool _isPresential = true;
  double _mood = 5.0;
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _saveReport() async {
    if (_selectedPatient == null || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione paciente e data')),
      );
      return;
    }
    final id = DateTime.now().millisecondsSinceEpoch;
    final report = Report(
      id: id,
      patientId: _selectedPatient!.id,
      date: _selectedDate!,
      isPresential: _isPresential,
      mood: _mood,
      notes: _notesCtrl.text.trim(),
    );
    final box = getReportsBox();
    await box.put(id.toString(), report);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Relatório salvo com sucesso')),
    );
    setState(() {
      _selectedDate = null;
      _isPresential = true;
      _mood = 5.0;
      _notesCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final patientsBox = getPatientsBox();
    final reportsBox = getReportsBox();
    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: patientsBox.listenable(),
              builder: (context, Box<Patient> b, _) {
                final patients = b.values.toList().cast<Patient>();
                return DropdownButton<Patient>(
                  value: _selectedPatient,
                  hint: const Text('Selecione paciente'),
                  isExpanded: true,
                  items: patients
                      .map(
                        (p) => DropdownMenuItem(value: p, child: Text(p.name)),
                      )
                      .toList(),
                  onChanged: (p) => setState(() => _selectedPatient = p),
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Data: ${_selectedDate != null ? _selectedDate!.toLocal().toString().split(' ')[0] : 'Nenhuma'}',
                  ),
                ),
                IconButton(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Tipo de sessão:'),
                const SizedBox(width: 8),
                Text(
                  _isPresential ? 'Presencial' : 'Online',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Switch(
                  value: _isPresential,
                  onChanged: (v) {
                    setState(() => _isPresential = v);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                Text('Humor: ${_mood.toInt()}'),
                Slider(
                  value: _mood,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: _mood.toInt().toString(),
                  onChanged: (v) => setState(() => _mood = v),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Observações'),
            TextField(controller: _notesCtrl, maxLines: 3),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _saveReport,
              child: const Text('Salvar relatório'),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: reportsBox.listenable(),
                builder: (context, Box<Report> rb, _) {
                  final reportList = rb.values.toList().cast<Report>();
                  final filtered = _selectedPatient == null
                      ? reportList
                      : reportList
                            .where((r) => r.patientId == _selectedPatient!.id)
                            .toList();
                  if (filtered.isEmpty)
                    return const Center(child: Text('Nenhum relatório'));
                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final r = filtered[index];
                      return ListTile(
                        title: Text(r.date.toLocal().toString().split(' ')[0]),
                        subtitle: Text(
                          '${r.isPresential ? 'Presencial' : 'Online'} - Humor: ${r.mood.toInt()}',
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReportDetailPage(report: r),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
