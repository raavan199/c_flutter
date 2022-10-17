class TotalCalculation {
  int? totalAttendance;
  int? totalAbsent;
  double? totalLeave;

  TotalCalculation({this.totalAttendance, this.totalAbsent, this.totalLeave});

  factory TotalCalculation.fromJsonForRowQuery(Map<String, dynamic> json) =>
      TotalCalculation(
        totalAttendance: json['TotalAttendance'] as int?,
        totalAbsent: json['TotalAbsent'] as int?,
        totalLeave: (json['TotalLeave'] as num?)?.toDouble(),
      );
}
