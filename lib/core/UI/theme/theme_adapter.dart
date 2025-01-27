import 'package:hive/hive.dart';
import 'package:receptico/core/UI/theme/theme_provider.dart';

class EThemeAdapter extends TypeAdapter<ETheme> {
  @override
  final typeId = 1;

  @override
  ETheme read(BinaryReader reader) {
    final index = reader.readByte();
    return ETheme.values[index];
  }

  @override
  void write(BinaryWriter writer, ETheme obj) {
    writer.writeByte(obj.index);
  }
}
