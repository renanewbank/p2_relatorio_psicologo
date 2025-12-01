import 'package:flutter/material.dart';
import '../../data/hive_boxes.dart';
import '../../models/patient.dart';
import '../../services/cep_service.dart';

class PatientFormPage extends StatefulWidget {
  const PatientFormPage({Key? key}) : super(key: key);

  @override
  State<PatientFormPage> createState() => _PatientFormPageState();
}

class _PatientFormPageState extends State<PatientFormPage> {
  final _nameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _cepCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _address = '';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _cepCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _buscarCep() async {
    final cep = _cepCtrl.text.trim();
    if (cep.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Informe o CEP')));
      return;
    }
    try {
      final addr = await fetchAddressFromCep(cep);
      setState(() => _address = addr);
    } catch (e) {
      debugPrint('Erro ao buscar CEP: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao buscar CEP')));
    }
  }

  Future<void> _salvar() async {
    try {
      final name = _nameCtrl.text.trim();
      final ageStr = _ageCtrl.text.trim();
      final cep = _cepCtrl.text.trim();
      final notes = _notesCtrl.text.trim();

      if (name.isEmpty || ageStr.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nome e idade são obrigatórios')),
        );
        return;
      }

      final age = int.tryParse(ageStr);
      if (age == null || age <= 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Idade inválida')));
        return;
      }

      final id = DateTime.now().millisecondsSinceEpoch;

      final patient = Patient(
        id: id,
        name: name,
        age: age,
        cep: cep,
        address: _address,
        notes: notes,
      );

      final box = getPatientsBox();
      await box.put(id.toString(), patient);

      debugPrint('Paciente salvo. Total na box: ${box.length}');

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Paciente salvo com sucesso')),
      );
      Navigator.pop(context);
    } catch (e, st) {
      debugPrint('Erro ao salvar paciente: $e\n$st');
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao salvar paciente')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Paciente')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Nome'),
              TextField(controller: _nameCtrl),
              const SizedBox(height: 8),
              const Text('Idade'),
              TextField(
                controller: _ageCtrl,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              const Text('CEP'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cepCtrl,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _buscarCep,
                    child: const Text('Buscar CEP'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Endereço'),
              Text(_address.isEmpty ? 'Nenhum endereço buscado' : _address),
              const SizedBox(height: 8),
              const Text('Observações'),
              TextField(controller: _notesCtrl, maxLines: 4),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
