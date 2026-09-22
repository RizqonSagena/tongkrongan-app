import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  String _selectedStatus = 'all';
  String? _expandedOrderId;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#ORD-001',
      'customer': 'Ahmad Pratama',
      'items': 'Kopi Susu + Kue Tart (2x)',
      'amount': 'Rp 45.000',
      'time': '10 menit lalu',
      'status': 'preparing',
      'stage': 2, // 1=pending, 2=preparing, 3=ready, 4=completed
      'notes': 'Extra hot, sugar sedikit',
    },
    {
      'id': '#ORD-002',
      'customer': 'Siti Nurhaliza',
      'items': 'Nasi Goreng Spesial + Es Jeruk',
      'amount': 'Rp 65.000',
      'time': '25 menit lalu',
      'status': 'completed',
      'stage': 4,
      'notes': 'Sudah diambil',
    },
    {
      'id': '#ORD-003',
      'customer': 'Bambang Irawan',
      'items': 'Espresso Double + Croissant',
      'amount': 'Rp 52.000',
      'time': '5 menit lalu',
      'status': 'pending',
      'stage': 1,
      'notes': 'Ceklist pesanan',
    },
    {
      'id': '#ORD-004',
      'customer': 'Rina Oktaviana',
      'items': 'Iced Americano + Sandwich',
      'amount': 'Rp 48.000',
      'time': '18 menit lalu',
      'status': 'ready',
      'stage': 3,
      'notes': 'Siap diambil',
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
    final filteredOrders = _filterOrders();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Status Filter Tabs
            _buildStatusTabs(context),

            // Orders List
            Expanded(
              child: filteredOrders.isEmpty
                  ? _buildEmptyState(context)
                  : ListView.separated(
                      padding: const EdgeInsets.all(AppTheme.margin),
                      itemCount: filteredOrders.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppTheme.spaceMd),
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return _buildOrderCard(context, order);
                      },
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
                      'Detail Pesanan',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Selasar Kopi & Ruang Diskusi',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help_outline),
                color: AppTheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTabs(BuildContext context) {
    final statuses = [
      {'label': 'Semua', 'value': 'all'},
      {'label': 'Pending', 'value': 'pending'},
      {'label': 'Persiapan', 'value': 'preparing'},
      {'label': 'Siap', 'value': 'ready'},
      {'label': 'Selesai', 'value': 'completed'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.margin,
        vertical: AppTheme.spaceSm,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            statuses.length,
            (index) {
              final status = statuses[index];
              final isSelected = _selectedStatus == status['value'];

              return Padding(
                padding:
                    EdgeInsets.only(right: index < statuses.length - 1 ? 8 : 0),
                child: GestureDetector(
                  onTap: () =>
                      setState(() => _selectedStatus = status['value'] as String),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primary
                          : AppTheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      boxShadow: isSelected ? [AppTheme.shadowSm] : null,
                    ),
                    child: Text(
                      status['label'] as String,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isSelected
                            ? AppTheme.onPrimary
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
      ),
    );
  }

  List<Map<String, dynamic>> _filterOrders() {
    if (_selectedStatus == 'all') {
      return _orders;
    }
    return _orders.where((o) => o['status'] == _selectedStatus).toList();
  }

  void _updateOrderStatus(String orderId, String newStatus, int newStage) {
    setState(() {
      final index = _orders.indexWhere((o) => o['id'] == orderId);
      if (index != -1) {
        _orders[index]['status'] = newStatus;
        _orders[index]['stage'] = newStage;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Status pesanan diperbarui menjadi ${_getStatusLabel(newStatus)}'),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
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
              Icons.shopping_cart_outlined,
              size: 44,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Text(
            'Tidak Ada Pesanan',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceXs),
          Text(
            'Belum ada pesanan untuk status ini',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    final isExpanded = _expandedOrderId == order['id'];
    final statusColor = _getStatusColor(order['status']);

    return GestureDetector(
      onTap: () => setState(() {
        _expandedOrderId = isExpanded ? null : order['id'];
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          border: Border.all(
            color: isExpanded
                ? AppTheme.primary.withValues(alpha: 0.3)
                : AppTheme.outlineVariant,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          boxShadow: isExpanded ? [AppTheme.shadowSm] : null,
        ),
        child: Column(
          children: [
            // Order Header
            Padding(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order ID and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order['id'],
                        style:
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.onSurface,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (order['status'] == 'pending')
                              AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                },
                              )
                            else
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            const SizedBox(width: 6),
                            Text(
                              _getStatusLabel(order['status']),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spaceSm),

                  // Customer Name
                  Text(
                    order['customer'],
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Items
                  Text(
                    order['items'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppTheme.spaceSm),

                  // Amount and Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order['amount'],
                        style:
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        order['time'],
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Expanded Details
            if (isExpanded)
              Column(
                children: [
                  Divider(color: AppTheme.outlineVariant),
                  Padding(
                    padding: const EdgeInsets.all(AppTheme.spaceMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stage Progression
                        Text(
                          'Tahap Pesanan',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spaceSm),
                        _buildStageProgress(context, order['stage']),
                        const SizedBox(height: AppTheme.spaceMd),

                        // Notes
                        Text(
                          'Catatan',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(AppTheme.spaceSm),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                          ),
                          child: Text(
                            order['notes'],
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppTheme.spaceMd),

                        // Action Buttons
                        if (order['status'] == 'pending')
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppTheme.error,
                                    side: BorderSide(color: AppTheme.error),
                                  ),
                                  child: const Text('Tolak'),
                                ),
                              ),
                              const SizedBox(width: AppTheme.spaceSm),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _updateOrderStatus(order['id'], 'preparing', 2),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primary,
                                  ),
                                  child: const Text('Terima'),
                                ),
                              ),
                            ],
                          )
                        else if (order['status'] == 'preparing')
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _updateOrderStatus(order['id'], 'ready', 3),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.tertiary,
                                  ),
                                  child: const Text('Tandai Siap'),
                                ),
                              ),
                            ],
                          )
                        else if (order['status'] == 'ready')
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _updateOrderStatus(order['id'], 'completed', 4),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.secondary,
                                  ),
                                  child: const Text('Selesaikan'),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageProgress(BuildContext context, int stage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStageCircle(context, '1', 'Dipesan', stage >= 1),
        _buildStageConnector(stage > 1),
        _buildStageCircle(context, '2', 'Persiapan', stage >= 2),
        _buildStageConnector(stage > 2),
        _buildStageCircle(context, '3', 'Siap', stage >= 3),
        _buildStageConnector(stage > 3),
        _buildStageCircle(context, '4', 'Selesai', stage >= 4),
      ],
    );
  }

  Widget _buildStageCircle(
      BuildContext context, String number, String label, bool isComplete) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 28,
            height: 28,
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
              color: isComplete ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStageConnector(bool isComplete) {
    return Expanded(
      child: Container(
        height: 2,
        color: isComplete ? AppTheme.primary : AppTheme.outlineVariant,
        margin: const EdgeInsets.only(bottom: 16),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return AppTheme.secondary;
      case 'preparing':
        return AppTheme.primary;
      case 'ready':
        return AppTheme.tertiary;
      case 'completed':
        return AppTheme.tertiary;
      default:
        return AppTheme.outline;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'preparing':
        return 'Persiapan';
      case 'ready':
        return 'Siap';
      case 'completed':
        return 'Selesai';
      default:
        return status;
    }
  }
}