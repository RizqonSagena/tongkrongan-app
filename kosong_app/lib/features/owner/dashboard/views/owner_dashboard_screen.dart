import 'package:flutter/material.dart';

import 'dart:ui';

import '../../../../core/themes/app_theme.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/main_layout.dart';

class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen>
    with SingleTickerProviderStateMixin {
  String _selectedPeriod = 'today';
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
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
        child: Column(
          children: [
            // Header with backdrop blur
            _buildHeader(context),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.margin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Hero Section
                    _buildWelcomeHero(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Period Filter Chips (Horizontal Scroll)
                    _buildPeriodFilters(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Urgent Action Dispatch Card
                    _buildDispatchCard(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Live Order Workflow Progression
                    _buildWorkflowProgression(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // KPI Cards Grid
                    _buildKPIGrid(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Quick Stats Section
                    _buildQuickStats(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // HPP & Stok Opt-In Section
                    _buildHPPOptInCard(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Minat Pelanggan Section
                    _buildCustomerInterest(context),
                    const SizedBox(height: AppTheme.spaceLg),
                  ],
                ),
              ),
            ),
          ],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Mitra Kedai',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppTheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Buka',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.tertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Morning bakery',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Dashboard',
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: AppTheme.onSurfaceVariant),
                  ),
                ],
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          final mainState = context
                              .findAncestorStateOfType<MainLayoutState>();
                          if (mainState != null) {
                            mainState.switchToTab(3); // Chat tab
                          }
                        },
                        icon: const Icon(Icons.chat_bubble_outline),
                        color: AppTheme.onSurface,
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppTheme.error,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.surface,
                              width: 1.5,
                            ),
                          ),
                          child: const Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.ownerNotifications,
                          );
                        },
                        icon: const Icon(Icons.notifications_outlined),
                        color: AppTheme.onSurface,
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppTheme.error,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.surface,
                              width: 1.5,
                            ),
                          ),
                          child: const Text(
                            '4',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      final mainState = context
                          .findAncestorStateOfType<MainLayoutState>();
                      if (mainState != null) {
                        mainState.switchToTab(4); // Profile tab
                      }
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [AppTheme.shadowSm],
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppTheme.onPrimary,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHero(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Dashboard Pemilik',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppTheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Live POS',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.tertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Selamat datang, Mas Dimas! 👋',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Morning bakery - Tanjung pinang',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.verified, size: 16, color: AppTheme.primary),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [AppTheme.shadowSm],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.surfaceContainer,
                      child: Icon(
                        Icons.person,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPeriodFilters(BuildContext context) {
    final periods = [
      {'label': 'Hari Ini', 'value': 'today'},
      {'label': 'Minggu Ini', 'value': 'week'},
      {'label': 'Bulan Ini', 'value': 'month'},
      {'label': 'Kustom', 'value': 'custom'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(periods.length, (index) {
          final period = periods[index];
          final isSelected = _selectedPeriod == period['value'];

          return Padding(
            padding: EdgeInsets.only(right: index < periods.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () =>
                  setState(() => _selectedPeriod = period['value'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primary
                      : AppTheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  boxShadow: isSelected ? [AppTheme.shadowSm] : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (period['value'] == 'custom')
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: isSelected
                              ? AppTheme.onPrimary
                              : AppTheme.onSurfaceVariant,
                        ),
                      ),
                    Text(
                      period['label'] as String,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: isSelected
                            ? AppTheme.onPrimary
                            : AppTheme.onSurfaceVariant,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDispatchCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Switch to Orders tab (index 2)
        final mainState = context.findAncestorStateOfType<MainLayoutState>();
        if (mainState != null) {
          mainState.switchToTab(2);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        decoration: BoxDecoration(
          color: AppTheme.primaryFixed,
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
          boxShadow: [AppTheme.shadowSm],
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [AppTheme.shadowSm],
                  ),
                  child: const Icon(
                    Icons.notifications_active,
                    color: AppTheme.onPrimary,
                    size: 22,
                  ),
                ),
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.primary.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ada 3 Pesanan Baru!',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.onPrimaryFixed,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Segera proses untuk kepuasan pelanggan',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onPrimaryFixed.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Icon(Icons.arrow_forward, color: AppTheme.onPrimaryFixed),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkflowProgression(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: [AppTheme.shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.sync_alt, size: 16, color: AppTheme.primary),
              const SizedBox(width: 6),
              Text(
                'Alur Otomasi Kedai',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Text(
                  'Dapur Siap ⚡',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.tertiary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          // Workflow steps
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWorkflowStep(context, '1', 'Order Masuk', true),
              _buildWorkflowConnector(true),
              _buildWorkflowStep(context, '2', 'Auto Terverif', true),
              _buildWorkflowConnector(true),
              _buildWorkflowStep(context, '3', 'Barista/Dapur', false),
              _buildWorkflowConnector(false),
              _buildWorkflowStep(context, '4', 'Selesai', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowStep(
    BuildContext context,
    String number,
    String label,
    bool isComplete,
  ) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isComplete ? AppTheme.primary : AppTheme.surfaceContainer,
              shape: BoxShape.circle,
              boxShadow: isComplete ? [AppTheme.shadowSm] : null,
            ),
            child: Center(
              child: Text(
                number,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isComplete
                      ? AppTheme.onPrimary
                      : AppTheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isComplete
                  ? AppTheme.onSurface
                  : AppTheme.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowConnector(bool isComplete) {
    return Expanded(
      child: Container(
        height: 2,
        color: isComplete ? AppTheme.primary : AppTheme.outlineVariant,
        margin: const EdgeInsets.only(bottom: 24),
      ),
    );
  }

  Widget _buildKPIGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KPI Hari Ini',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceMd),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppTheme.spaceMd,
          crossAxisSpacing: AppTheme.spaceMd,
          childAspectRatio: 1.2,
          children: [
            GestureDetector(
              onTap: () {
                // Switch to Analytics tab (index 1)
                final mainState = context
                    .findAncestorStateOfType<MainLayoutState>();
                if (mainState != null) {
                  mainState.switchToTab(1);
                }
              },
              child: _buildKPICard(
                context,
                '245',
                'Pengunjung',
                Icons.people,
                AppTheme.primary,
                '↑ 12% vs kemarin',
              ),
            ),
            GestureDetector(
              onTap: () {
                // To Orders
                Navigator.pushNamed(context, AppRouter.ownerOrders);
              },
              child: _buildKPICard(
                context,
                '42',
                'Pesanan',
                Icons.shopping_cart,
                AppTheme.secondary,
                '↑ 8% vs kemarin',
              ),
            ),
            GestureDetector(
              onTap: () {
                // Switch to Analytics tab (index 1)
                final mainState = context
                    .findAncestorStateOfType<MainLayoutState>();
                if (mainState != null) {
                  mainState.switchToTab(1);
                }
              },
              child: _buildKPICard(
                context,
                'Rp 3.2M',
                'Penjualan',
                Icons.trending_up,
                AppTheme.tertiary,
                '↑ 15% vs kemarin',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.ownerRatingReviews);
              },
              child: _buildKPICard(
                context,
                '4.8/5.0',
                'Rating',
                Icons.star,
                AppTheme.primaryContainer,
                'Dari 342 review',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKPICard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant, width: 1),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(color: color, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: AppTheme.onSurfaceVariant, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistik Cepat',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceMd),
        Container(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(color: AppTheme.outlineVariant, width: 1),
          ),
          child: Column(
            children: [
              _buildStatRow(
                context,
                'Rata-rata waktu tunggu',
                '8 menit',
                AppTheme.primary,
              ),
              Divider(color: AppTheme.outlineVariant),
              _buildStatRow(
                context,
                'Kepuasan pelanggan',
                '94%',
                AppTheme.tertiary,
              ),
              Divider(color: AppTheme.outlineVariant),
              _buildStatRow(
                context,
                'Pesanan tepat waktu',
                '96%',
                AppTheme.secondary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: AppTheme.onSurfaceVariant),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildHPPOptInCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.05),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: AppTheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kelola HPP & Stok',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.tertiary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Opsional',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Text(
            'Pantau stok bahan, biaya produksi, harga jual, dan estimasi keuntungan usaha Anda.',
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: AppTheme.onSurfaceVariant, height: 1.5),
          ),
          const SizedBox(height: AppTheme.spaceLg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to HPP Stock Dashboard
                Navigator.pushNamed(context, '/owner/stock-dashboard');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                ),
              ),
              child: const Text(
                'Mulai Kelola',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInterest(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.ownerCustomerInterest);
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        decoration: BoxDecoration(
          color: AppTheme.secondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: AppTheme.secondary.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: AppTheme.onSecondary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppTheme.spaceMd),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Minat Pelanggan',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    Text(
                      'Lihat tren kunjungan',
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: AppTheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: AppTheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
