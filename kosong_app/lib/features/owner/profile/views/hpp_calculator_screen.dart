import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/themes/app_theme.dart';

class HppCalculatorScreen extends StatefulWidget {
  final String? menuId;
  const HppCalculatorScreen({super.key, this.menuId});

  @override
  State<HppCalculatorScreen> createState() => _HppCalculatorScreenState();
}

class _HppCalculatorScreenState extends State<HppCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _menuNameController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _kopiCostController = TextEditingController();
  final _susuCostController = TextEditingController();
  final _gulaArenCostController = TextEditingController();
  final _packagingCostController = TextEditingController();
  final _additionalCostController = TextEditingController();

  int _hpp = 0;
  int _profit = 0;
  double _margin = 0.0;
  bool _hppExceedsPrice = false;

  // Dummy lookup data - siap dihubungkan ke backend
  final Map<String, Map<String, dynamic>> _menuData = {
    'menu-001': {
      'name': 'Es Kopi Selasar Aren',
      'sellingPrice': 18000,
      'kopiCost': 3000,
      'susuCost': 2500,
      'gulaArenCost': 1000,
      'packagingCost': 1000,
      'additionalCost': 500,
    },
    'menu-002': {
      'name': 'Nasi Kulit Sambal Matah',
      'sellingPrice': 25000,
      'kopiCost': 8000,
      'susuCost': 0,
      'gulaArenCost': 4000,
      'packagingCost': 1500,
      'additionalCost': 500,
    },
    'menu-003': {
      'name': 'Teh Bunga Telang',
      'sellingPrice': 15000,
      'kopiCost': 0,
      'susuCost': 0,
      'gulaArenCost': 0,
      'packagingCost': 0,
      'additionalCost': 0,
    },
    'menu-004': {
      'name': 'Roti Bakar Cokelat',
      'sellingPrice': 18000,
      'kopiCost': 0,
      'susuCost': 0,
      'gulaArenCost': 0,
      'packagingCost': 0,
      'additionalCost': 0,
    },
  };

  @override
  void initState() {
    super.initState();
    _loadMenuData();
  }

  void _loadMenuData() {
    if (widget.menuId != null && _menuData.containsKey(widget.menuId)) {
      final data = _menuData[widget.menuId]!;
      _menuNameController.text = data['name'] as String;
      _sellingPriceController.text = (data['sellingPrice'] as int).toString();
      _kopiCostController.text = (data['kopiCost'] as int).toString();
      _susuCostController.text = (data['susuCost'] as int).toString();
      _gulaArenCostController.text = (data['gulaArenCost'] as int).toString();
      _packagingCostController.text = (data['packagingCost'] as int).toString();
      _additionalCostController.text = (data['additionalCost'] as int).toString();
      _calculate();
    }
  }

  void _calculate() {
    final kopi = int.tryParse(_kopiCostController.text) ?? 0;
    final susu = int.tryParse(_susuCostController.text) ?? 0;
    final gulaAren = int.tryParse(_gulaArenCostController.text) ?? 0;
    final packaging = int.tryParse(_packagingCostController.text) ?? 0;
    final additional = int.tryParse(_additionalCostController.text) ?? 0;
    final sellingPrice = int.tryParse(_sellingPriceController.text) ?? 0;

    setState(() {
      _hpp = kopi + susu + gulaAren + packaging + additional;
      _profit = sellingPrice - _hpp;
      _margin = sellingPrice > 0 ? (_profit / sellingPrice) * 100 : 0.0;
      _hppExceedsPrice = _hpp > sellingPrice && sellingPrice > 0;
    });
  }

  void _saveHpp() {
    if (!_formKey.currentState!.validate()) return;

    final sellingPrice = int.tryParse(_sellingPriceController.text) ?? 0;
    final result = {
      'sellingPrice': sellingPrice,
      'kopiCost': int.tryParse(_kopiCostController.text) ?? 0,
      'susuCost': int.tryParse(_susuCostController.text) ?? 0,
      'gulaArenCost': int.tryParse(_gulaArenCostController.text) ?? 0,
      'packagingCost': int.tryParse(_packagingCostController.text) ?? 0,
      'additionalCost': int.tryParse(_additionalCostController.text) ?? 0,
      'hpp': _hpp,
      'profit': _profit,
      'margin': _margin,
      'hasHpp': true,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('HPP berhasil disimpan'),
        backgroundColor: AppTheme.tertiary,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context, result);
  }

  @override
  void dispose() {
    _menuNameController.dispose();
    _sellingPriceController.dispose();
    _kopiCostController.dispose();
    _susuCostController.dispose();
    _gulaArenCostController.dispose();
    _packagingCostController.dispose();
    _additionalCostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung HPP'),
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.onSurface,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu Name
              Text(
                'Nama Menu',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: AppTheme.spaceSm),
              TextFormField(
                controller: _menuNameController,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Nama menu',
                ),
              ),
              const SizedBox(height: AppTheme.spaceLg),

              // Selling Price
              Text(
                'Harga Jual',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: AppTheme.spaceSm),
              TextFormField(
                controller: _sellingPriceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  prefixText: 'Rp ',
                  hintText: '0',
                ),
                onChanged: (_) => _calculate(),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Harga jual wajib diisi';
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spaceLg),

              // Components
              Text(
                'Bahan Baku Khusus (Opsional)',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: AppTheme.spaceSm),
              
              TextFormField(
                controller: _kopiCostController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Bahan 1 (Kopi/Lainnya)',
                  prefixText: 'Rp ',
                  hintText: '0',
                ),
                onChanged: (_) => _calculate(),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              
              TextFormField(
                controller: _susuCostController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Bahan 2 (Susu/Lainnya)',
                  prefixText: 'Rp ',
                  hintText: '0',
                ),
                onChanged: (_) => _calculate(),
              ),
              const SizedBox(height: AppTheme.spaceMd),

              TextFormField(
                controller: _gulaArenCostController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Bahan 3 (Gula Aren/Lainnya)',
                  prefixText: 'Rp ',
                  hintText: '0',
                ),
                onChanged: (_) => _calculate(),
              ),
              const SizedBox(height: AppTheme.spaceLg),

              // Packaging Cost
              Text(
                'Biaya Kemasan',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: AppTheme.spaceSm),
              TextFormField(
                controller: _packagingCostController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  prefixText: 'Rp ',
                  hintText: '0',
                ),
                onChanged: (_) => _calculate(),
              ),
              const SizedBox(height: AppTheme.spaceMd),

              // Additional Cost
              Text(
                'Biaya Tambahan',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: AppTheme.spaceSm),
              TextFormField(
                controller: _additionalCostController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  prefixText: 'Rp ',
                  hintText: '0',
                ),
                onChanged: (_) => _calculate(),
              ),
              const SizedBox(height: AppTheme.spaceXl),

              // HPP Warning
              if (_hppExceedsPrice)
                Container(
                  padding: const EdgeInsets.all(AppTheme.spaceMd),
                  margin: const EdgeInsets.only(bottom: AppTheme.spaceMd),
                  decoration: BoxDecoration(
                    color: AppTheme.errorContainer,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(color: AppTheme.error.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber, color: AppTheme.error),
                      const SizedBox(width: AppTheme.spaceSm),
                      Expanded(
                        child: Text(
                          'Perhatian: HPP lebih tinggi daripada harga jual.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.onErrorContainer,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Calculation Results
              Container(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  border: Border.all(color: AppTheme.outlineVariant),
                ),
                child: Column(
                  children: [
                    _buildResultRow(context, 'HPP', 'Rp ${_formatCurrency(_hpp)}', AppTheme.primary),
                    Divider(color: AppTheme.outlineVariant),
                    _buildResultRow(
                      context,
                      'Keuntungan',
                      _hpp > 0 ? 'Rp ${_formatCurrency(_profit)}' : '-',
                      _profit >= 0 ? AppTheme.tertiary : AppTheme.error,
                    ),
                    Divider(color: AppTheme.outlineVariant),
                    _buildResultRow(
                      context,
                      'Margin',
                      _hpp > 0 ? '${_margin.toStringAsFixed(1)}%' : '-',
                      AppTheme.secondary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spaceLg),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveHpp,
                  child: const Text('Simpan HPP'),
                ),
              ),
              const SizedBox(height: AppTheme.spaceMd),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(BuildContext context, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    final isNegative = amount < 0;
    final absAmount = amount.abs();
    final str = absAmount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return isNegative ? '-${buffer.toString()}' : buffer.toString();
  }
}
