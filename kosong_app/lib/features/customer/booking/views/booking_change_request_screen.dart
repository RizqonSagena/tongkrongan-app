import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/models/booking_model.dart';
import '../../../../core/data/mock_bookings.dart';

class BookingChangeRequestScreen extends StatefulWidget {
  final String bookingId;

  const BookingChangeRequestScreen({super.key, required this.bookingId});

  @override
  State<BookingChangeRequestScreen> createState() => _BookingChangeRequestScreenState();
}

class _BookingChangeRequestScreenState extends State<BookingChangeRequestScreen> {
  late Booking booking;
  
  String _selectedDate = '';
  String _selectedStartTime = '';
  String _selectedEndTime = '';
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    booking = mockBookings.firstWhere((b) => b.id == widget.bookingId);
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submitRequest() {
    if (_selectedDate.isEmpty || _selectedStartTime.isEmpty || _selectedEndTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap lengkapi tanggal dan waktu yang baru.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajukan Perubahan Jadwal?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Jadwal Lama:'),
            Text('${booking.date}, ${booking.startTime} - ${booking.endTime}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Jadwal Baru:'),
            Text('$_selectedDate, $_selectedStartTime - $_selectedEndTime', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performSubmit();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: AppTheme.onPrimary),
            child: const Text('Ajukan'),
          ),
        ],
      ),
    );
  }

  void _performSubmit() {
    setState(() {
      booking.changeRequest = ChangeRequest(
        id: DateTime.now().toString(),
        bookingId: booking.id,
        oldDate: booking.date,
        oldStartTime: booking.startTime,
        oldEndTime: booking.endTime,
        newDate: _selectedDate,
        newStartTime: _selectedStartTime,
        newEndTime: _selectedEndTime,
        reason: _reasonController.text,
        status: 'pending',
        createdAt: DateTime.now(),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permintaan perubahan jadwal sedang menunggu persetujuan owner.')),
    );

    Navigator.of(context).pop(); // Go back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Ajukan Perubahan Jadwal'),
        backgroundColor: AppTheme.surfaceContainerLowest,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current booking info
            Text(booking.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: AppTheme.primary),
                const SizedBox(width: 4),
                Text(booking.placeName, style: const TextStyle(color: AppTheme.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppTheme.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Jadwal saat ini:', style: TextStyle(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                      Text('${booking.date}, ${booking.startTime} - ${booking.endTime}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            const Text('Jadwal Baru', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            _buildDateField(context),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildTimeField(
                    context,
                    label: 'Waktu Mulai',
                    value: _selectedStartTime,
                    onChanged: (val) => setState(() => _selectedStartTime = val),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTimeField(
                    context,
                    label: 'Waktu Selesai',
                    value: _selectedEndTime,
                    onChanged: (val) => setState(() => _selectedEndTime = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text('Alasan Perubahan (Opsional)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Tulis alasan perubahan jadwal...',
                filled: true,
                fillColor: AppTheme.surfaceContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Ajukan Perubahan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
            );
            if (picked != null) {
              setState(() => _selectedDate = picked.toString().split(' ')[0]);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: AppTheme.secondary, size: 20),
                const SizedBox(width: 8),
                Text(
                  _selectedDate.isEmpty ? 'Pilih Tanggal' : _selectedDate,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(BuildContext context, {required String label, required String value, required Function(String) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) {
              // ignore: use_build_context_synchronously
              onChanged(picked.format(context));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: AppTheme.secondary, size: 20),
                const SizedBox(width: 8),
                Text(
                  value.isEmpty ? '--:--' : value,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
