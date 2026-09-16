import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _tab = 'active';
  
  final List<Map<String, dynamic>> _activeBookings = [
    {
      'id': '1',
      'title': 'Kopi Pagi Bareng Tim',
      'place': 'Selasar Kopi & Ruang Diskusi',
      'date': 'Besok, 09.00 - 11.00',
      'members': 4,
      'image':
          'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=400&h=250&fit=crop',
      'status': 'upcoming',
    },
    {
      'id': '2',
      'title': 'Rapat Kerja Freelancer',
      'place': 'Warkop Warmindo 24/7',
      'date': 'Minggu, 15.00 - 17.00',
      'members': 3,
      'image':
          'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=400&h=250&fit=crop',
      'status': 'upcoming',
    },
  ];

  final List<Map<String, dynamic>> _pastBookings = [
    {
      'id': '3',
      'title': 'Hangout Santai Sabtu',
      'place': 'Dapur Rooftop Senja',
      'date': 'Sabtu, 18.00 - 20.00',
      'members': 5,
      'image':
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&h=250&fit=crop',
      'status': 'completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bookings = _tab == 'active' ? _activeBookings : _pastBookings;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Tab selector
            _buildTabBar(context),

            // Content
            Expanded(
              child: bookings.isEmpty
                  ? _buildEmptyState(context)
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(AppTheme.margin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Results header
                          _buildResultsHeader(context, bookings.length),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Booking cards
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bookings.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: AppTheme.spaceMd),
                            itemBuilder: (context, index) {
                              final booking = bookings[index];
                              return _buildBookingCard(context, booking);
                            },
                          ),
                          const SizedBox(height: AppTheme.spaceMd),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBookingForm(context),
        backgroundColor: AppTheme.primary,
        foregroundColor: AppTheme.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text('Buat Janji'),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.margin,
        vertical: AppTheme.spaceMd,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.85),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jadwal Nongkrongan',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Kelola janji nongkrong bareng teman',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildTab(context, 'active', 'Akan Datang'),
          const SizedBox(width: AppTheme.spaceMd),
          _buildTab(context, 'past', 'Riwayat'),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String value, String label) {
    final isActive = _tab == value;
    return GestureDetector(
      onTap: () => setState(() => _tab = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceMd,
          vertical: AppTheme.spaceSm,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppTheme.primary : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildResultsHeader(BuildContext context, int count) {
    return Text(
      'Menampilkan $count jadwal',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppTheme.onSurface,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _tab == 'active'
                  ? Icons.calendar_today_outlined
                  : Icons.history,
              size: 44,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Text(
            _tab == 'active'
                ? 'Belum Ada Janji'
                : 'Riwayat Kosong',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceXs),
          Text(
            _tab == 'active'
                ? 'Buat jadwal nongkrong pertamamu'
                : 'Belum ada riwayat jadwal',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (_tab == 'active') ...[
            const SizedBox(height: AppTheme.spaceLg),
            ElevatedButton(
              onPressed: () => _showBookingForm(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spaceMd,
                  vertical: AppTheme.spaceXs,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
              ),
              child: const Text('Buat Janji'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, Map<String, dynamic> booking) {
    return GestureDetector(
      onTap: () {
        // Navigate to booking detail
      },
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: AppTheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with status badge
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainer,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusXl),
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppTheme.radiusXl),
                    ),
                    child: Image.network(
                      booking['image'],
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppTheme.surfaceContainer,
                          child: const Center(
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppTheme.surfaceContainer,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: AppTheme.outline,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: AppTheme.spaceSm,
                    right: AppTheme.spaceSm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.tertiary.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        boxShadow: [AppTheme.shadowMd],
                      ),
                      child: Text(
                        booking['status'] == 'upcoming'
                            ? 'Akan Datang'
                            : 'Selesai',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onTertiary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    booking['title'],
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppTheme.spaceXs),

                  // Place
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppTheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          booking['place'],
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spaceSm),

                  // Date and Members
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppTheme.secondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          booking['date'],
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spaceSm),

                  // Members
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 16,
                        color: AppTheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${booking['members']} peserta',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spaceMd),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Edit booking
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.primary,
                            side: BorderSide(
                              color: AppTheme.outline,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spaceSm,
                              vertical: AppTheme.spaceXs,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusFull),
                            ),
                          ),
                          child: const Text('Edit'),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spaceSm),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // View detail
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: AppTheme.onPrimary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spaceSm,
                              vertical: AppTheme.spaceXs,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusFull),
                            ),
                          ),
                          child: const Text('Lihat'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _BookingFormSheet(),
    );
  }
}

class _BookingFormSheet extends StatefulWidget {
  const _BookingFormSheet();

  @override
  State<_BookingFormSheet> createState() => _BookingFormSheetState();
}

class _BookingFormSheetState extends State<_BookingFormSheet> {
  final _titleController = TextEditingController();
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _personCount = 1;
  String _selectedDate = '';
  String _selectedStartTime = '';
  String _selectedEndTime = '';
  String _selectedPurpose = 'casual';

  @override
  void dispose() {
    _titleController.dispose();
    _placeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppTheme.radiusXl),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                left: AppTheme.margin,
                right: AppTheme.margin,
                top: AppTheme.spaceMd,
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    AppTheme.margin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  Text(
                    'Buat Janji Baru',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceMd),

                  // Title Input
                  _buildFormField(
                    context,
                    label: 'Judul Janji',
                    icon: Icons.edit,
                    controller: _titleController,
                    placeholder: 'Kopi Pagi Bareng Tim',
                  ),
                  const SizedBox(height: AppTheme.spaceMd),

                  // Place Input
                  _buildFormField(
                    context,
                    label: 'Tempat Nongkrong',
                    icon: Icons.location_on,
                    controller: _placeController,
                    placeholder: 'Selasar Kopi & Ruang Diskusi',
                  ),
                  const SizedBox(height: AppTheme.spaceMd),

                  // Date Input
                  _buildDateField(context),
                  const SizedBox(height: AppTheme.spaceMd),

                  // Time Inputs
                  Row(
                    children: [
                      Expanded(
                        child: _buildTimeField(
                          context,
                          label: 'Jam Mulai',
                          value: _selectedStartTime,
                          onChanged: (val) =>
                              setState(() => _selectedStartTime = val),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spaceSm),
                      Expanded(
                        child: _buildTimeField(
                          context,
                          label: 'Jam Selesai',
                          value: _selectedEndTime,
                          onChanged: (val) =>
                              setState(() => _selectedEndTime = val),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spaceMd),

                  // Purpose Chips
                  Text(
                    'Tujuan Nongkrong',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceXs),
                  _buildPurposeChips(context),
                  const SizedBox(height: AppTheme.spaceMd),

                  // Person Count
                  Text(
                    'Jumlah Peserta',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceXs),
                  _buildPersonCountButton(context),
                  const SizedBox(height: AppTheme.spaceMd),

                  // Description
                  _buildFormField(
                    context,
                    label: 'Catatan (Optional)',
                    icon: Icons.notes,
                    controller: _descriptionController,
                    placeholder: 'Tambahkan catatan...',
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppTheme.spaceMd),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Submit booking
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Janji berhasil dibuat!'),
                            backgroundColor: AppTheme.tertiary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusXl),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: AppTheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppTheme.spaceMd,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusFull),
                        ),
                      ),
                      child: const Text('Buat Janji'),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormField(
    BuildContext context, {
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String placeholder,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceXs),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Icon(
                icon,
                color: AppTheme.secondary,
                size: 20,
              ),
            ),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            filled: true,
            fillColor: AppTheme.surfaceContainer,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanggal',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceXs),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppTheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _selectedDate.isEmpty
                      ? 'Pilih tanggal'
                      : _selectedDate,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _selectedDate.isEmpty
                        ? AppTheme.outline
                        : AppTheme.onSurface,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: AppTheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(
    BuildContext context, {
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceXs),
        GestureDetector(
          onTap: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) {
              onChanged(picked.format(context));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.isEmpty ? 'Jam' : value,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: value.isEmpty
                        ? AppTheme.outline
                        : AppTheme.onSurface,
                  ),
                ),
                Icon(
                  Icons.schedule,
                  size: 18,
                  color: AppTheme.secondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPurposeChips(BuildContext context) {
    final purposes = [
      {'label': 'Casual', 'value': 'casual'},
      {'label': 'Rapat', 'value': 'meeting'},
      {'label': 'Event', 'value': 'event'},
    ];

    return Wrap(
      spacing: AppTheme.spaceSm,
      runSpacing: AppTheme.spaceSm,
      children: purposes.map((purpose) {
        final isSelected = _selectedPurpose == purpose['value'];
        return GestureDetector(
          onTap: () =>
              setState(() => _selectedPurpose = purpose['value'] as String),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primary : AppTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
            child: Text(
              purpose['label'] as String,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected
                    ? AppTheme.onPrimary
                    : AppTheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPersonCountButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _personCount > 1
                ? () => setState(() => _personCount--)
                : null,
            icon: const Icon(Icons.remove),
            color: AppTheme.primary,
          ),
          Text(
            '$_personCount orang',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: _personCount < 50
                ? () => setState(() => _personCount++)
                : null,
            icon: const Icon(Icons.add),
            color: AppTheme.primary,
          ),
        ],
      ),
    );
  }
}