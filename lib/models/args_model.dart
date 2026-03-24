class ArgsModel {
  final String mode;
  final dynamic tipe;
  final dynamic data;

  ArgsModel({required this.mode, this.tipe, this.data});

  factory ArgsModel.fromMap(Map<dynamic, dynamic> map) =>
      ArgsModel(mode: map['mode'], tipe: map['tipe'], data: map['data']);

  Map<String, dynamic> toMap() => {"mode": mode, "tipe": tipe, "data": data};
}
