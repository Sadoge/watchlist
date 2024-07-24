// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TVSeriesModelAdapter extends TypeAdapter<TVSeriesModel> {
  @override
  final int typeId = 0;

  @override
  TVSeriesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TVSeriesModel(
      id: fields[0] as int,
      name: fields[1] as String,
      overview: fields[2] as String,
      posterPath: fields[3] as String?,
      voteAverage: fields[4] as double,
      status: fields[5] as String?,
      lastEpisode: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TVSeriesModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.voteAverage)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.lastEpisode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TVSeriesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
