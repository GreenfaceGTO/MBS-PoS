// ----------------------------------------------------------------
import 'package:mbspos/service/utils/global_enums.dart';

/// kelas yang digunakan untuk mempassing argument ke halaman lain
// ----------------------------------------------------------------
class ArgsModel {
  final FormMode formMode;
  final dynamic tipe;
  final dynamic data;

  ArgsModel({this.formMode = FormMode.input, this.tipe, this.data});

  factory ArgsModel.fromMap(Map<dynamic, dynamic> map) =>
      ArgsModel(formMode: map['mode'], tipe: map['tipe'], data: map['data']);

  Map<String, dynamic> toMap() =>
      {"mode": formMode, "tipe": tipe, "data": data};
}
