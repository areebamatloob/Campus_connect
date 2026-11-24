import 'package:flutter/material.dart';
import '../viewmodels/attendance_viewmodel.dart';

class AttendanceScreen extends StatefulWidget {
  final AttendanceViewModel viewModel;

  const AttendanceScreen({super.key, required this.viewModel});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Connect - Attendance'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: AnimatedBuilder(
        animation: widget.viewModel,
        builder: (context, _) {
          final attendance = widget.viewModel.attendance;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          '${attendance.percentage}%',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Chip(
                          label: Text(
                            attendance.status,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: attendance.percentage >= 75
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter New Attendance (0-100)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: widget.viewModel.isSaving
                      ? null
                      : () async {
                    final value = int.tryParse(_controller.text.trim());

                    if (value == null || value < 0 || value > 100) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a number between 0 and 100'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    await widget.viewModel.updateAttendance(value);
                  },
                  child: widget.viewModel.isSaving
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                      : const Text('Update Attendance', style: TextStyle(fontSize: 16)),
                ),
                if (widget.viewModel.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      widget.viewModel.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}