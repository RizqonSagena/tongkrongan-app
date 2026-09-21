import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/models/booking_model.dart';
import '../../../../core/data/mock_bookings.dart';

class BookingDetailScreen extends StatelessWidget {
  final String bookingId;

  const BookingDetailScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final booking = mockBookings.firstWhere((b) => b.id == bookingId);

    return Scaffold(
      backgroundColor: AppTheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Detail Booking'),
        backgroundColor: AppTheme.surfaceContainerLowest,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
            _buildStatusHeader(context, booking),
            const SizedBox(height: AppTheme.spaceLg),

            // Basic Info
            Text(
              booking.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.onSurface,
                  ),
            ),
            const SizedBox(height: AppTheme.spaceMd),

            _buildInfoRow(Icons.location_on, 'Tempat', booking.placeName),
            _buildInfoRow(Icons.calendar_today, 'Tanggal', booking.date),
            _buildInfoRow(Icons.access_time, 'Waktu', '${booking.startTime} - ${booking.endTime}'),
            _buildInfoRow(Icons.people, 'Peserta', '${booking.participantCount} Orang'),
            const SizedBox(height: AppTheme.spaceLg),

            // Change Request Section if exists
            if (booking.changeRequest != null)
              _buildChangeRequestSection(context, booking.changeRequest!),

            const SizedBox(height: AppTheme.spaceXl),

            // Action Buttons
            _buildActionButtons(context, booking),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader(BuildContext context, Booking booking) {
    String text;
    Color color;
    IconData icon;

    if (booking.status == 'completed') {
      text = 'Selesai';
      color = AppTheme.primary;
      icon = Icons.check_circle;
    } else if (booking.status == 'cancelled') {
      text = 'Dibatalkan';
      color = AppTheme.error;
      icon = Icons.cancel;
    } else if (booking.changeRequest != null && booking.changeRequest!.status == 'pending') {
      text = 'Menunggu Persetujuan';
      color = Colors.orange;
      icon = Icons.hourglass_empty;
    } else {
      text = 'Akan Datang';
      color = AppTheme.tertiary;
      icon = Icons.event;
    }

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: AppTheme.spaceSm),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppTheme.secondary),
          const SizedBox(width: AppTheme.spaceSm),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeRequestSection(BuildContext context, ChangeRequest cr) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi Perubahan Jadwal',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.onSurface,
            ),
          ),
          const Divider(),
          const SizedBox(height: AppTheme.spaceSm),
          _buildInfoRow(Icons.history, 'Jadwal Lama', '${cr.oldDate}, ${cr.oldStartTime} - ${cr.oldEndTime}'),
          _buildInfoRow(Icons.update, 'Jadwal Baru', '${cr.newDate}, ${cr.newStartTime} - ${cr.newEndTime}'),
          if (cr.reason != null && cr.reason!.isNotEmpty)
            _buildInfoRow(Icons.notes, 'Alasan', cr.reason!),
          
          const SizedBox(height: AppTheme.spaceMd),
          Text(
            'Status: ${cr.status.toUpperCase()}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: cr.status == 'pending' ? Colors.orange : (cr.status == 'approved' ? AppTheme.primary : AppTheme.error),
            ),
          ),
          
          if (cr.ownerResponse != null) ...[
            const SizedBox(height: AppTheme.spaceSm),
            Text(
              'Balasan Owner: ${cr.ownerResponse}',
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Booking booking) {
    return Column(
      children: [
        if (booking.status == 'upcoming')
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/booking-change-request', arguments: booking.id).then((_) {
                  // Hack to rebuild
                  (context as Element).markNeedsBuild();
                });
              },
              icon: const Icon(Icons.edit_calendar),
              label: const Text('Ajukan Perubahan Jadwal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        const SizedBox(height: AppTheme.spaceMd),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // In a real app, this would route to a chat specifically with the owner
                  // For now, route to chat screen (which will list chats)
                  Navigator.of(context).pushNamed('/chat');
                },
                icon: const Icon(Icons.chat),
                label: const Text('Hubungi Owner'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/chat');
                },
                icon: const Icon(Icons.support_agent),
                label: const Text('Hubungi Admin'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
