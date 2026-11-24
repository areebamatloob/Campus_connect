import 'package:flutter/foundation.dart';
import '../data/attendance_repository.dart';
import '../models/attendance.dart';

class AttendanceViewModel extends ChangeNotifier {
  final AttendanceRepository repository;

  AttendanceViewModel(this.repository);

  // State to track if data is being saved
  bool _isSaving = false;
  bool get isSaving => _isSaving;

  // State to track errors
  String? _error;
  String? get error => _error;

  // Getter to fetch current attendance
  Attendance get attendance => repository.getAttendance();

  // Function triggered when user taps the update button
  Future<void> updateAttendance(int value) async {
    _isSaving = true;
    _error = null;
    notifyListeners(); // Notify UI to show loading state

    try {
      await repository.updateAttendance(value);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isSaving = false;
      notifyListeners(); // Notify UI to update with new data or error
    }
  }
}