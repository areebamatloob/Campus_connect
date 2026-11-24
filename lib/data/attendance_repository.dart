import '../models/attendance.dart';

class AttendanceRepository {
  // Sample data initialized to 75%
  Attendance _attendance = Attendance(75);

  // Retrieve attendance data
  Attendance getAttendance() => Attendance(_attendance.percentage);

  // Update attendance data
  Future<void> updateAttendance(int value) async {
    // Simulating a database/API delay
    await Future<void>.delayed(const Duration(milliseconds: 300));

    if (value < 0 || value > 100) {
      throw ArgumentError('Attendance must be between 0 and 100');
    }
    _attendance = Attendance(value);
  }
}