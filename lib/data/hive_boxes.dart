import 'package:hive/hive.dart';
import '../models/patient.dart';
import '../models/report.dart';

Box<Patient> getPatientsBox() => Hive.box<Patient>('patients');
Box<Report> getReportsBox() => Hive.box<Report>('reports');
