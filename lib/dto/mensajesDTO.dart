// To parse this JSON data, do
//
//     final mensajesDto = mensajesDtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MensajesDto> mensajesDtoFromJson(String str) => List<MensajesDto>.from(
    json.decode(str).map((x) => MensajesDto.fromJson(x)));

String mensajesDtoToJson(List<MensajesDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MensajesDto {
  MensajesDto({
    required this.id,
    required this.login,
    required this.titulo,
    required this.texto,
    required this.fecha,
  });

  int id;
  String login;
  String titulo;
  String texto;
  DateTime fecha;

  factory MensajesDto.fromJson(Map<String, dynamic> json) => MensajesDto(
        id: json["id"],
        login: json["login"],
        titulo: json["titulo"],
        texto: json["texto"],
        fecha: DateTime.parse(json["fecha"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "login": login,
        "titulo": titulo,
        "texto": texto,
        "fecha": fecha.toIso8601String(),
      };
}
