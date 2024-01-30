// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storedetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoredetailsAdapter extends TypeAdapter<Storedetails> {
  @override
  final int typeId = 1;

  @override
  Storedetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Storedetails(
      lang: fields[0] as String,
      mode: fields[1] as bool,
      whatsappfolderpath: fields[2] as String,
      selectedOrNot: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Storedetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.lang)
      ..writeByte(1)
      ..write(obj.mode)
      ..writeByte(2)
      ..write(obj.whatsappfolderpath)
      ..writeByte(3)
      ..write(obj.selectedOrNot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoredetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
