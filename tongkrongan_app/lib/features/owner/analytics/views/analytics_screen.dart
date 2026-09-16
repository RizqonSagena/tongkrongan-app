import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedPeriod = 'today';
  String _selectedTimeRange = '16:00-21:00';

  final List<Map<String, dynamic>> _topProducts = [
    {
      'image': 'https://images.unsplash.com/photo-1559056199-641a0ac8b3f7?w=200&h=200&fit=crop',
      'name': 'Es Kopi Selasar Aren',
      'qty': '310 cup/minggu',
      'status': 'Margin 6%',
      'rating': 4.8,
    },
    {
      'image': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=200&h=200&fit=crop',
      'name': 'Nasi Kulit Sambal Matah',
      'qty': '112 porsi/minggu',
      'status': 'Margin 56%',
      'rating': 4.6,
    },
  ];

  final List<Map<String, dynamic>> _slowMovingItems = [
    {
      'image': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=200&h=200&fit=crop',
      'name': 'Teh Bunga Telang Dingin',
      'qty': 'Hanya 6 cup/minggu',
      'note': 'Pertanyaan Diskusi',
    },
    {
      'image': 'https://images.unsplash.com/photo-1588137378633-dea1336ce1e2?w=200&h=200&fit=crop',
      'name': 'Singkong Goreng Keju',
      'qty': '12 porsi/minggu (⬇️ bawah rata-rata snack)',
      'note': 'Ubah Resep',
    },
  ];

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
                    // Title & Subtitle
                    Text(
                      'Analitik Performa Bisnis',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Wawasan mendalam pertumbuhan omzet, tren penjualan ramai, dan performa meja',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Period Filter Tabs
                    _buildPeriodTabs(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Revenue Card
                    _buildRevenueCard(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // KPI Grid
                    _buildKPIGrid(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Tips Card
                    _buildTipsCard(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Peak Hours Section
                    _buildPeakHoursSection(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Category Breakdown
                    _buildCategoryBreakdown(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Top Sellers
                    _buildTopSellersSection(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Slow-Moving Items
                    _buildSlowMovingSection(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Export Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download),
                        label: const Text('Unduh Laporan Lengkap (PDF / Excel)'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spaceMd,
                            vertical: AppTheme.spaceSm,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceMd),
                    Text(
                      'Dilaporkan otomatis setiap 15 menit dari karir POS Selasar Kopi',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
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
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: AppTheme.onSurface,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LAPORAN MITRA KEDAI',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Selasar Kopi & Ruang Diskusi',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.dashboard, color: AppTheme.secondary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodTabs(BuildContext context) {
    final periods = [
      {'label': 'Hari Ini vs Kemarin', 'value': 'today'},
      {'label': 'Minggu Ini vs Pekan Lalu', 'value': 'week'},
      {'label': 'Bulan Ini', 'value': 'month'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          periods.length,
          (index) {
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
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.secondary : AppTheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                    boxShadow: isSelected ? [AppTheme.shadowSm] : null,
                  ),
                  child: Text(
                    period['label'] as String,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isSelected
                          ? AppTheme.onSecondary
                          : AppTheme.onSurfaceVariant,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRevenueCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.secondary, AppTheme.error],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: [AppTheme.shadowMd],
      ),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'OMZET PEKAN INI',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSecondary.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.trending_up,
                color: AppTheme.onSecondary.withValues(alpha: 0.6),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Text(
            'Rp 26.450.000',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppTheme.onSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.onSecondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 12,
                      color: AppTheme.onSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+18.5% vs pekan lalu',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.onSecondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Text(
                  'Target tercapai 108%',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKPIGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              border: Border.all(color: AppTheme.outlineVariant),
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.people, color: AppTheme.primary, size: 24),
                const SizedBox(height: AppTheme.spaceXs),
                Text(
                  'Total Pelanggan',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '342 Nota',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '↑ 14 nota',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spaceSm),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              border: Border.all(color: AppTheme.outlineVariant),
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.star, color: AppTheme.secondary, size: 24),
                const SizedBox(height: AppTheme.spaceXs),
                Text(
                  'Rata-rata Keramahan',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp 77.300',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '↑ Rp 4.200',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTipsCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondary.withValues(alpha: 0.15),
        border: Border.all(color: AppTheme.secondary.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
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
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.lightbulb, color: AppTheme.onSecondary, size: 20),
              ),
              const SizedBox(width: AppTheme.spaceSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OMZET PEKAN INI',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Rp 26.450.000',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Container(
            padding: const EdgeInsets.all(AppTheme.spaceSm),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wawasan Cerdas AI Tongkrongan - OTOMATIS',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tips Owner: Pelanggan yang memesan di Puncak 80% memesan Kopi Selasar Aren. Arean Buat Paket Bundling Jami Mak-Siang dengan Makanan ala Jumlah Kopi Minggu Ini hingga 65%.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
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
              child: const Text('Aktifkan Paket Otomatis'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeakHoursSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tren Jam Ramai',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.tertiary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: AppTheme.tertiary),
                  const SizedBox(width: 4),
                  Text(
                    'Peak 16:00 - 21:00',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Text(
          'Aktualitas Sesuai ± 30 Menit',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppTheme.spaceMd),
        Container(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            border: Border.all(color: AppTheme.outlineVariant),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          ),
          child: Column(
            children: [
              // Bar chart
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildChartBar(context, '09:00', 0.15),
                  _buildChartBar(context, '12:00', 0.35),
                  _buildChartBar(context, '15:00', 0.55),
                  _buildChartBar(context, '18:00', 0.88),
                  _buildChartBar(context, '21:00', 0.75),
                  _buildChartBar(context, '23:00', 0.25),
                ],
              ),
              const SizedBox(height: AppTheme.spaceSm),
              Divider(color: AppTheme.outlineVariant),
              const SizedBox(height: AppTheme.spaceSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildChartLegend('Sepi/Sedang', AppTheme.outlineVariant),
                  const SizedBox(width: AppTheme.spaceMd),
                  _buildChartLegend('Ramai', AppTheme.secondary),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChartBar(BuildContext context, String time, double height) {
    return Column(
      children: [
        Container(
          width: 20,
          height: 80 * height,
          decoration: BoxDecoration(
            color: height > 0.7 ? AppTheme.secondary : AppTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppTheme.onSurfaceVariant,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }

  Widget _buildCategoryBreakdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kategori Terlaris',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            Text(
              'Total Rp 26,4 π',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceMd),
        _buildCategoryRow(context, 'Kopi & Minuman Dingin', '58%', 'Rp 15,3 π'),
        const SizedBox(height: AppTheme.spaceSm),
        _buildCategoryRow(context, 'Makanan Berat', '27%', 'Rp 7,1 π'),
        const SizedBox(height: AppTheme.spaceSm),
        _buildCategoryRow(context, 'Snack & Roti Bakar', '15%', 'Rp 4,0 π'),
      ],
    );
  }

  Widget _buildCategoryRow(
    BuildContext context,
    String label,
    String percentage,
    String amount,
  ) {
    final percent = int.parse(percentage.replaceAll('%', ''));
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: percent > 50
                          ? AppTheme.secondary
                          : percent > 20
                              ? AppTheme.secondary.withValues(alpha: 0.5)
                              : AppTheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                child: LinearProgressIndicator(
                  value: percent / 100,
                  minHeight: 6,
                  backgroundColor: AppTheme.surfaceContainer,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    percent > 50
                        ? AppTheme.secondary
                        : percent > 20
                            ? AppTheme.secondary.withValues(alpha: 0.6)
                            : AppTheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppTheme.spaceSm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              percentage,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            Text(
              amount,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopSellersSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Analisis Menu',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Lihat Semua >',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceMd),
        Text(
          'JUARA PENJUALAN (BEST SELLERS)',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppTheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        ..._topProducts.map((product) => _buildProductRow(context, product)),
      ],
    );
  }

  Widget _buildProductRow(
    BuildContext context,
    Map<String, dynamic> product,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceSm),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          border: Border.all(color: AppTheme.outlineVariant),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              child: Image.network(
                product['image'],
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 48,
                  height: 48,
                  color: AppTheme.surfaceContainer,
                  child: Icon(Icons.image, color: AppTheme.onSurfaceVariant),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product['qty'],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.trending_up, size: 12, color: AppTheme.tertiary),
                    const SizedBox(width: 2),
                    Text(
                      'Laris',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.tertiary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  product['status'],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlowMovingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '⚠️ PERLU EVALUASI (SLOW-MOVING ITEMS)',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppTheme.error,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        ..._slowMovingItems.map((item) => _buildSlowMovingRow(context, item)),
      ],
    );
  }

  Widget _buildSlowMovingRow(BuildContext context, Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceSm),
        decoration: BoxDecoration(
          color: AppTheme.error.withValues(alpha: 0.05),
          border: Border.all(color: AppTheme.error.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              child: Image.network(
                item['image'],
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 48,
                  height: 48,
                  color: AppTheme.surfaceContainer,
                  child: Icon(Icons.image, color: AppTheme.onSurfaceVariant),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item['qty'],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.error.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Text(
                    item['note'],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.error,
                      fontWeight: FontWeight.w700,
                    ),
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