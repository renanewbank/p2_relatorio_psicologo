import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchAddressFromCep(String cep) async {
  final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');
  final url = Uri.parse('https://viacep.com.br/ws/$cleanCep/json/');
  final res = await http.get(url);
  if (res.statusCode != 200) throw Exception('Erro ao buscar CEP');
  final data = json.decode(res.body) as Map<String, dynamic>;
  if (data.containsKey('erro') && data['erro'] == true) {
    throw Exception('CEP não encontrado');
  }
  final logradouro = data['logradouro'] ?? '';
  final bairro = data['bairro'] ?? '';
  final localidade = data['localidade'] ?? '';
  final uf = data['uf'] ?? '';
  final address = [logradouro, bairro].where((s) => s.isNotEmpty).join(', ');
  final city = [localidade, uf].where((s) => s.isNotEmpty).join('/');
  final full = [if (address.isNotEmpty) address, if (city.isNotEmpty) city].join(' - ');
  return full;
}
