import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Patient {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final String cep;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String notes;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.cep,
    required this.address,
    required this.notes,
  });
}

class PatientAdapter extends TypeAdapter<Patient> {
  @override
  final int typeId = 0;

  @override
  Patient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      final key = reader.readByte();
      fields[key] = reader.read();
    }
    return Patient(
      id: fields[0] as int,
      name: fields[1] as String,
      age: fields[2] as int,
      cep: fields[3] as String,
      address: fields[4] as String,
      notes: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Patient obj) {
    writer.writeByte(6);
    writer.writeByte(0);
    writer.write(obj.id);
    writer.writeByte(1);
    writer.write(obj.name);
    writer.writeByte(2);
    writer.write(obj.age);
    writer.writeByte(3);
    writer.write(obj.cep);
    writer.writeByte(4);
    writer.write(obj.address);
    writer.writeByte(5);
    writer.write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
