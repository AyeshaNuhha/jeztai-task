class DashboardItem {
  final String companyName;
  final int employeeCount;
  final int cameraCount;
  final int attendancePercentage;
  final int lastDateAttendancePercentage;
  final List<dynamic> last5AttendancePercentages;
  final String todayDate;
  final int todaysTotalImgs;
  final String todaysFormatTotal;
  final String totalImagesProcessed;
  final bool pp;

  DashboardItem({
    required this.companyName,
    required this.employeeCount,
    required this.cameraCount,
    required this.attendancePercentage,
    required this.lastDateAttendancePercentage,
    required this.last5AttendancePercentages,
    required this.todayDate,
    required this.todaysTotalImgs,
    required this.todaysFormatTotal,
    required this.totalImagesProcessed,
    required this.pp,
  });

  factory DashboardItem.fromJson(Map<String, dynamic> json) {
    return DashboardItem(
      companyName: json['company_name'] ?? '',
      employeeCount: json['employee_count'] ?? 0,
      cameraCount: json['camera_count'] ?? 0,
      attendancePercentage: json['attendance_percentage'] ?? 0,
      lastDateAttendancePercentage: json['last_date_attendance_percentage'] ?? 0,
      last5AttendancePercentages: json['last_5_attendance_percentages'] ?? [],
      todayDate: json['today_date'] ?? '',
      todaysTotalImgs: json['Todays_Total_Imgs'] ?? 0,
      todaysFormatTotal: json['Todays_Format_Total'] ?? '',
      totalImagesProcessed: json['Total_Images_Processed'] ?? '',
      pp: json['pp'] ?? false,
    );
  }
}
