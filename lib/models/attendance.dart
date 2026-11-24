class Attendance {
  int percentage;

  Attendance(this.percentage);

  // Business logic: Determines status based on percentage
  String get status {
    return percentage >= 75 ? 'Eligible' : 'Short Attendance';
  }
}