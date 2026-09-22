import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class StockInputScreen extends StatefulWidget {
  const StockInputScreen({super.key});

  @override
  State<StockInputScreen> createState() => _StockInputScreenState();
}

class _StockInputScreenState extends State<StockInputScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedUnit = 'gram';
  final _units = ['gram', 'kilogram', 'ml', 'liter', 'pcs', 'botol', 'lainnya'];
  
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  double _totalValue = 0;

  void _calculateTotal() {
    final price = double.tryParse(_priceController.text) ?? 0;
    final qty = double.tryParse(_qtyController.text) ?? 0;
    setState(() {
      _totalValue = price * qty;
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Tambah Stok'),
        backgroundColor: AppTheme.backgroundLight,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.margin),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informasi Bahan',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.onSurface,
                ),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nama Bahan',
                  hintText: 'Contoh: Biji Kopi Arabika',
                ),
                validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: AppTheme.spaceLg),
              
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _qtyController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah',
                      ),
                      onChanged: (_) => _calculateTotal(),
                      validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spaceMd),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: _selectedUnit,
                      decoration: const InputDecoration(labelText: 'Satuan'),
                      items: _units.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedUnit = val);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spaceLg),
              
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga per satuan (Rp)',
                  hintText: 'Contoh: 150000',
                ),
                onChanged: (_) => _calculateTotal(),
                validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: AppTheme.spaceLg),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Supplier (Opsional)',
                  hintText: 'Contoh: Toko Maju Jaya',
                ),
              ),
              const SizedBox(height: AppTheme.spaceXl),
              
              Container(
                padding: const EdgeInsets.all(AppTheme.spaceLg),
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Nilai Stok:',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      'Rp ${_totalValue.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spaceXl * 2),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.margin),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Stok berhasil ditambahkan')),
                );
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Simpan Stok', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
