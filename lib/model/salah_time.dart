class SalahTime {
  String fajr;
  String dhuhr;
  String asr;
  String maghrib;
  String isha;

  SalahTime({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory SalahTime.fromJson(Map<String, dynamic> json) {
    return SalahTime(
      fajr: json['Fajr'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
    );
  }
}
