import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _noteController = TextEditingController();

  String _selectedCategory = 'Minuman';
  bool _isAvailable = true;
  bool _showPreview = false;

  final List<String> _categories = ['Minuman', 'Makanan', 'Pastry', 'Snack'];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.margin),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Preview section
                      if (_showPreview) ...[
                        _buildPreviewSection(context),
                        const SizedBox(height: AppTheme.spaceLg),
                      ],

                      _buildSectionTitle(context, 'Informasi Menu'),
                      const SizedBox(height: AppTheme.spaceMd),

                      // Nama Menu
                      _buildLabel(context, 'Nama Menu *'),
                      const SizedBox(height: AppTheme.spaceSm),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Contoh: Es Kopi Susu Premium',
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Wajib diisi' : null,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: AppTheme.spaceMd),

                      // Kategori
                      _buildLabel(context, 'Kategori *'),
                      const SizedBox(height: AppTheme.spaceSm),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLowest,
                          border: Border.all(color: AppTheme.outlineVariant),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusMd),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            isExpanded: true,
                            items: _categories
                                .map((c) => DropdownMenuItem(
                                      value: c,
                                      child: Text(c),
                                    ))
                                .toList(),
                            onChanged: (v) {
                              if (v != null) {
                                setState(() => _selectedCategory = v);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spaceMd),

                      // Harga
                      _buildLabel(context, 'Harga *'),
                      const SizedBox(height: AppTheme.spaceSm),
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Contoh: 18000',
                          prefixText: 'Rp ',
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Wajib diisi' : null,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: AppTheme.spaceMd),

                      // Deskripsi
                      _buildLabel(context, 'Deskripsi'),
                      const SizedBox(height: AppTheme.spaceSm),
                      TextFormField(
                        controller: _descController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Deskripsi singkat menu...',
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: AppTheme.spaceMd),

                      // Status tersedia
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spaceMd,
                          vertical: AppTheme.spaceSm,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLowest,
                          border: Border.all(color: AppTheme.outlineVariant),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusMd),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status Tersedia',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.onSurface,
                                  ),
                                ),
                                Text(
                                  _isAvailable
                                      ? 'Menu aktif dan bisa dipesan'
                                      : 'Menu tidak tersedia',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                    color: AppTheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: _isAvailable,
                              activeThumbColor: AppTheme.tertiary,
                              onChanged: (v) =>
                                  setState(() => _isAvailable = v),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppTheme.spaceMd),

                      // Catatan
                      _buildLabel(context, 'Catatan'),
                      const SizedBox(height: AppTheme.spaceSm),
                      TextFormField(
                        controller: _noteController,
                        decoration: const InputDecoration(
                          hintText: 'Catatan internal untuk tim...',
                        ),
                      ),
                      const SizedBox(height: AppTheme.spaceLg),

                      // Preview button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              setState(() => _showPreview = !_showPreview),
                          icon: Icon(
                            _showPreview
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          label: Text(
                            _showPreview ? 'Sembunyikan Preview' : 'Preview',
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spaceSm),

                      // Simpan button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondary,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppTheme.spaceSm,
                            ),
                          ),
                          child: const Text('Simpan Menu'),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spaceLg),
                    ],
                  ),
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
        color: AppTheme.surface.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: AppTheme.onSurface),
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Text(
            'Tambah Menu',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppTheme.onSurface,
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppTheme.onSurface,
      ),
    );
  }

  Widget _buildPreviewSection(BuildContext context) {
    final String name =
        _nameController.text.isEmpty ? 'Nama Menu' : _nameController.text;
    final String price =
        _priceController.text.isEmpty ? '-' : 'Rp ${_priceController.text}';

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.secondary.withValues(alpha: 0.05),
        border: Border.all(color: AppTheme.secondary.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '👀 Preview Menu',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.secondary,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    _selectedCategory,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Text(
                price,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.secondary,
                ),
              ),
            ],
          ),
          if (_descController.text.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spaceSm),
            Text(
              _descController.text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: AppTheme.spaceSm),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _isAvailable ? AppTheme.tertiary : AppTheme.error,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                _isAvailable ? 'Tersedia' : 'Tidak Tersedia',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: _isAvailable ? AppTheme.tertiary : AppTheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Simpan Menu'),
        content: Text(
          'Simpan "${_nameController.text}" ke katalog dengan harga Rp ${_priceController.text}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondary,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${_nameController.text} berhasil disimpan!',
                  ),
                  backgroundColor: AppTheme.tertiary,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
