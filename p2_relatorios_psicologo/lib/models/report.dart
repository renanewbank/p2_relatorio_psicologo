import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Report {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int patientId;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final bool isPresential;
  @HiveField(4)
  final double mood;
  @HiveField(5)
  final String notes;

  Report({
    required this.id,
    required this.patientId,
    required this.date,
    required this.isPresential,
    required this.mood,
    required this.notes,
  });
}

class ReportAdapter extends TypeAdapter<Report> {
  @override
  final int typeId = 1;

  @override
  Report read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      final key = reader.readByte();
      fields[key] = reader.read();
    }
    return Report(
      id: fields[0] as int,
      patientId: fields[1] as int,
      date: fields[2] as DateTime,
      isPresential: fields[3] as bool,
      mood: fields[4] as double,
      notes: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Report obj) {
    writer.writeByte(6);
    writer.writeByte(0);
    writer.write(obj.id);
    writer.writeByte(1);
    writer.write(obj.patientId);
    writer.writeByte(2);
    writer.write(obj.date);
    writer.writeByte(3);
    writer.write(obj.isPresential);
    writer.writeByte(4);
    writer.write(obj.mood);
    writer.writeByte(5);
    writer.write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
