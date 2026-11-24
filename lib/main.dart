import 'package:flutter/material.dart';
import 'data/attendance_repository.dart';
import 'viewmgit initodels/attendance_viewmodel.dart';
import 'views/attendance_screen.dart';

void main() {
  // 1. Initialize Data Layer
  final repository = AttendanceRepository();

  // 2. Initialize ViewModel Layer with Repository
  final viewModel = AttendanceViewModel(repository);

  // 3. Start App and pass ViewModel to the View (Screen)
  runApp(CampusConnectApp(viewModel: viewModel));
}

class CampusConnectApp extends StatelessWidget {
  final AttendanceViewModel viewModel;

  const CampusConnectApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: AttendanceScreen(viewModel: viewModel),
    );
  }
}