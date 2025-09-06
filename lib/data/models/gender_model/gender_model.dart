class GenderModel {
  final String? name;
  final String value;

  GenderModel({this.name, required this.value});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is GenderModel &&
              runtimeType == other.runtimeType &&
              value == other.value;

  @override
  int get hashCode => value.hashCode;
}
