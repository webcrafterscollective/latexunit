import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'latex.g.dart';
// Corrected: Removed 'const' and made it a function to call when needed
String genUuid() => const Uuid().v4();

@JsonSerializable()
class Latex {
  String id;
  String text;

  Latex({
    String? id, // Made 'id' nullable
    required this.text,
  }) : id = id ?? genUuid(); // Assigns a new UUID if none is provided

  Map<String, dynamic> toJson() => _$LatexToJson(this);

  factory Latex.fromJson(Map<String, dynamic> json) => _$LatexFromJson(json);
}
