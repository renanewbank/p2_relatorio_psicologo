import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/hive_boxes.dart';
import 'models/patient.dart';
import 'models/report.dart';
import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PatientAdapter());
  Hive.registerAdapter(ReportAdapter());
  await Hive.openBox<Patient>('patients');
  await Hive.openBox<Report>('reports');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'p2_relatorios_psicologo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
