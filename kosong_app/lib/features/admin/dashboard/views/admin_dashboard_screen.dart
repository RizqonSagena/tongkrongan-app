import 'package:flutter/material.dart';

import 'dart:ui';

import '../../../../core/themes/app_theme.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> _recentActivities = [
    {
      'icon': Icons.store_mall_directory,
      'title': 'Kedai Baru Ditambahkan',
      'subtitle': 'Warkop Bersih Rezeki',
      'time': '10 menit lalu',
      'status': 'Aktif',
      'color': AppTheme.tertiary,
    },
    {
      'icon': Icons.assignment_returned,
      'title': 'Update Katalog Menu',
      'subtitle': 'Otomatis sinkron - 15 menit lalu',
      'time': '15 menit lalu',
      'status': 'Katalog',
      'color': AppTheme.primary,
    },
    {
      'icon': Icons.campaign,
      'title': 'Banner Promo Live',
      'subtitle': 'Dipublikasikan ke Explore - 32 menit lalu',
      'time': '32 menit lalu',
      'status': 'Tayang',
      'color': AppTheme.secondary,
    },
  ];

  final List<Map<String, dynamic>> _priorityTasks = [
    {
      'number': '4',
      'label': 'Listing Kedai Ba...',
      'description': 'Verifikasi dokumen',
      'color': AppTheme.secondary.withValues(alpha: 0.15),
      'textColor': AppTheme.secondary,
    },
    {
      'number': '3',
      'label': 'Reservasi / Jad...',
      'description': 'Koordinasi kedai',
      'color': AppTheme.tertiary.withValues(alpha: 0.15),
      'textColor': AppTheme.tertiary,
    },
    {
      'number': '7',
      'label': 'Konten & Promo',
      'description': 'Kurasi publikasi',
      'color': AppTheme.secondary.withValues(alpha: 0.15),
      'textColor': AppTheme.secondary,
    },
    {
      'number': '5',
      'label': 'Chat Pelanggan',
      'description': 'Eskalasi admin',
      'color': AppTheme.error.withValues(alpha: 0.15),
      'textColor': AppTheme.error,
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: false);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(context),

              // Main Content
              Padding(
                padding: const EdgeInsets.all(AppTheme.margin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status & Greeting
                    _buildStatusGreeting(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // KPI Cards Grid
                    _buildKPIGrid(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Quick Actions
                    _buildQuickActions(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Priority Tasks
                    _buildPriorityTasks(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // High Priority Section
                    _buildHighPrioritySection(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Recent Activity
                    _buildRecentActivity(context),
                  ],
                ),
              ),
            ],
          ),
        ),
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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Icon(
                  Icons.play_circle_filled,
                  color: AppTheme.onSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OPERATOR PORTAL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Dashboard',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusGreeting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.tertiary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          ),
          child: Text(
            '● STATUS JARINGAN NORMAL',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.tertiary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Text(
          'Selamat Datang, Admin Operasional',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Pusat Kontrol & Kurasi Ekosistem Tongkrongan',
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: AppTheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildKPIGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildKPICard(
            context,
            '🏪',
            'Total',
            '142',
            'Mitra Kedai\n128 aktif, 14 review',
          ),
        ),
        const SizedBox(width: AppTheme.spaceSm),
        Expanded(
          child: _buildKPICard(
            context,
            '✅',
            'Live',
            '128',
            'Kedai Aktif\nTerkurasi & Online',
          ),
        ),
      ],
    );
  }

  Widget _buildKPICard(
    BuildContext context,
    String emoji,
    String label,
    String value,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: AppTheme.onSurfaceVariant),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondary,
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceSm),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Tambah Kedai Baru'),
          ),
        ),
        const SizedBox(width: AppTheme.spaceSm),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondary,
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceSm),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Tambah Menu/Produk'),
          ),
        ),
      ],
    );
  }

  Widget _buildPriorityTasks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Perlu Diproses',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            Text(
              '4 Pintasan',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceMd),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppTheme.spaceSm,
          crossAxisSpacing: AppTheme.spaceSm,
          childAspectRatio: 1.2,
          children: List.generate(
            _priorityTasks.length,
            (index) => _buildTaskCard(context, _priorityTasks[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(BuildContext context, Map<String, dynamic> task) {
    return Container(
      decoration: BoxDecoration(
        color: task['color'],
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      padding: const EdgeInsets.all(AppTheme.spaceSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: task['textColor'],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                task['number'],
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task['label'],
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
              ),
              Text(
                task['description'],
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: AppTheme.onSurfaceVariant, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHighPrioritySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Perlu Diproses Segera',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            Icon(Icons.flash_on, color: AppTheme.error, size: 18),
          ],
        ),
        const SizedBox(height: AppTheme.spaceMd),
        Text(
          'Tindakan prioritas operator hari ini',
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: AppTheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppTheme.spaceMd),
        Container(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          decoration: BoxDecoration(
            color: AppTheme.secondary.withValues(alpha: 0.1),
            border: Border.all(
              color: AppTheme.secondary.withValues(alpha: 0.2),
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.secondary,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    ),
                    child: Icon(Icons.storefront, color: AppTheme.onSecondary),
                  ),
                  const SizedBox(width: AppTheme.spaceSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pendaftaran Baru',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.onSurface,
                              ),
                        ),
                        Text(
                          'Verifikasi Kedai Baru: Kopi Titik Temu Tebet',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spaceSm),
              Container(
                padding: const EdgeInsets.all(AppTheme.spaceSm),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Text(
                  '📍 Menunggu Cek Foto & Titik GPS\n🕐 Diajukan 25 menit lalu',
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: AppTheme.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: AppTheme.spaceSm),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondary,
                  ),
                  child: const Text('Periksa Listing'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Aktivitas Operasional Terbaru',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            Text(
              'Realtime',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.tertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceMd),
        ...List.generate(
          _recentActivities.length,
          (index) => _buildActivityItem(context, _recentActivities[index]),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    Map<String, dynamic> activity,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spaceMd),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          border: Border.all(color: AppTheme.outlineVariant),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spaceSm),
              decoration: BoxDecoration(
                color: activity['color'].withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(activity['icon'], color: activity['color'], size: 20),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['title'],
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    activity['subtitle'],
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: AppTheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: activity['color'].withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Text(
                    activity['status'],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: activity['color'],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity['time'],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
