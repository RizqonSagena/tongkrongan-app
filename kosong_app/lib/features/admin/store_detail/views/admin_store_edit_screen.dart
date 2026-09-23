import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/data/admin_store_data.dart';

class AdminStoreEditScreen extends StatefulWidget {
  final Map<String, dynamic> store;
  const AdminStoreEditScreen({super.key, required this.store});

  @override
  State<AdminStoreEditScreen> createState() => _AdminStoreEditScreenState();
}

class _AdminStoreEditScreenState extends State<AdminStoreEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ownerController;
  late TextEditingController _descController;
  late TextEditingController _addressController;
  late TextEditingController _areaController;
  late TextEditingController _phoneController;
  late TextEditingController _openTimeController;
  late TextEditingController _closeTimeController;
  late TextEditingController _openDaysController;
  late TextEditingController _capacityController;
  late TextEditingController _facilitiesController;

  String _selectedCategory = 'Coffee Shop';
  String _currentImage = '';

  final List<String> _categories = [
    'Coffee Shop',
    'Specialty Coffee',
    'Rooftop Cafe',
    'Warkop',
    'Bakery',
    'Restoran',
    'Lainnya',
  ];

  final List<String> _dummyImages = [
    'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1521017973422-fbb20404019c?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=400&h=300&fit=crop',
    'https://images.unsplash.com/photo-1453614512568-c4024d13c247?w=400&h=300&fit=crop',
  ];

  @override
  void initState() {
    super.initState();
    final store = widget.store;
    _nameController = TextEditingController(text: store['name'] ?? '');
    _ownerController = TextEditingController(text: store['owner'] ?? '');
    _descController = TextEditingController(text: store['description'] ?? '');
    _addressController = TextEditingController(text: store['address'] ?? '');
    _areaController = TextEditingController(text: store['area'] ?? '');
    _phoneController = TextEditingController(text: store['phone'] ?? '');
    _openTimeController = TextEditingController(text: store['openTime'] ?? '');
    _closeTimeController = TextEditingController(text: store['closeTime'] ?? '');
    _openDaysController = TextEditingController(text: store['openDays'] ?? '');
    _capacityController = TextEditingController(text: store['capacity'] ?? '');
    _facilitiesController = TextEditingController(text: store['facilities'] ?? '');

    _currentImage = store['image'] ?? _dummyImages[0];

    final cat = store['category'] ?? store['type'] ?? 'Coffee Shop';
    _selectedCategory = _categories.contains(cat) ? cat : 'Lainnya';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ownerController.dispose();
    _descController.dispose();
    _addressController.dispose();
    _areaController.dispose();
    _phoneController.dispose();
    _openTimeController.dispose();
    _closeTimeController.dispose();
    _openDaysController.dispose();
    _capacityController.dispose();
    _facilitiesController.dispose();
    super.dispose();
  }

  void _showImagePicker() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pilih Foto Kedai'),
        content: SizedBox(
          width: 300,
          height: 300,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _dummyImages.length,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () {
                setState(() => _currentImage = _dummyImages[i]);
                Navigator.pop(ctx);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  _dummyImages[i],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppTheme.surfaceContainer,
                    child: Icon(Icons.image, color: AppTheme.onSurfaceVariant),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    final idx = AdminStoreData.stores
        .indexWhere((s) => s['id'] == widget.store['id']);
    if (idx != -1) {
      AdminStoreData.stores[idx] = {
        ...AdminStoreData.stores[idx],
        'name': _nameController.text,
        'owner': _ownerController.text,
        'category': _selectedCategory,
        'type': _selectedCategory,
        'description': _descController.text,
        'address': _addressController.text,
        'location': _areaController.text,
        'area': _areaController.text,
        'phone': _phoneController.text,
        'openTime': _openTimeController.text,
        'closeTime': _closeTimeController.text,
        'openDays': _openDaysController.text,
        'capacity': _capacityController.text,
        'facilities': _facilitiesController.text,
        'image': _currentImage,
      };
    }
    Navigator.pop(context, true);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Foto Kedai
                    _buildPhotoSection(context),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Informasi Dasar
                    _buildSectionTitle(context, 'Informasi Dasar'),
                    const SizedBox(height: AppTheme.spaceMd),
                    _buildCard(
                      context,
                      Column(
                        children: [
                          _buildTextField(
                            context,
                            controller: _nameController,
                            label: 'Nama Kedai',
                            hint: 'Masukkan nama kedai',
                            icon: Icons.store,
                          ),
                          const SizedBox(height: AppTheme.spaceMd),
                          _buildTextField(
                            context,
                            controller: _ownerController,
                            label: 'Nama Owner',
                            hint: 'Masukkan nama owner',
                            icon: Icons.person,
                          ),
                          const SizedBox(height: AppTheme.spaceMd),
                          _buildCategoryDropdown(context),
                          const SizedBox(height: AppTheme.spaceMd),
                          _buildTextField(
                            context,
                            controller: _descController,
                            label: 'Deskripsi',
                            hint: 'Deskripsikan kedai ini...',
                            icon: Icons.description,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Lokasi
                    _buildSectionTitle(context, 'Lokasi'),
                    const SizedBox(height: AppTheme.spaceMd),
                    _buildCard(
                      context,
                      Column(
                        children: [
                          _buildTextField(
                            context,
                            controller: _addressController,
                            label: 'Alamat Lengkap',
                            hint: 'Jl. ...',
                            icon: Icons.location_on,
                          ),
                          const SizedBox(height: AppTheme.spaceMd),
                          _buildTextField(
                            context,
                            controller: _areaController,
                            label: 'Area / Lokasi',
                            hint: 'Contoh: Tebet, Jakarta Selatan',
                            icon: Icons.map,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Kontak
                    _buildSectionTitle(context, 'Informasi Kontak'),
                    const SizedBox(height: AppTheme.spaceMd),
                    _buildCard(
                      context,
                      _buildTextField(
                        context,
                        controller: _phoneController,
                        label: 'Nomor Telepon',
                        hint: '+62 8xx xxxx xxxx',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Operasional
                    _buildSectionTitle(context, 'Jam Operasional'),
                    const SizedBox(height: AppTheme.spaceMd),
                    _buildCard(
                      context,
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  context,
                                  controller: _openTimeController,
                                  label: 'Jam Buka',
                                  hint: '08:00',
                                  icon: Icons.access_time,
                                ),
                              ),
                              const SizedBox(width: AppTheme.spaceMd),
                              Expanded(
                                child: _buildTextField(
                                  context,
                                  controller: _closeTimeController,
                                  label: 'Jam Tutup',
                                  hint: '22:00',
                                  icon: Icons.access_time_filled,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.spaceMd),
                          _buildTextField(
                            context,
                            controller: _openDaysController,
                            label: 'Hari Operasional',
                            hint: 'Contoh: Senin - Minggu',
                            icon: Icons.calendar_today,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Fasilitas
                    _buildSectionTitle(context, 'Fasilitas & Kapasitas'),
                    const SizedBox(height: AppTheme.spaceMd),
                    _buildCard(
                      context,
                      Column(
                        children: [
                          _buildTextField(
                            context,
                            controller: _capacityController,
                            label: 'Kapasitas',
                            hint: 'Contoh: 40 orang',
                            icon: Icons.people,
                          ),
                          const SizedBox(height: AppTheme.spaceMd),
                          _buildTextField(
                            context,
                            controller: _facilitiesController,
                            label: 'Fasilitas',
                            hint: 'Contoh: WiFi, AC, Parkir',
                            icon: Icons.star,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Action Buttons
                    _buildActionButtons(context),
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
          Expanded(
            child: Text(
              'Edit Informasi Kedai',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Foto Kedai'),
        const SizedBox(height: AppTheme.spaceMd),
        _buildCard(
          context,
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                child: Image.network(
                  _currentImage,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 160,
                      color: AppTheme.surfaceContainer,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppTheme.secondary,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 160,
                    color: AppTheme.surfaceContainer,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.storefront,
                            size: 48, color: AppTheme.onSurfaceVariant),
                        const SizedBox(height: 8),
                        Text(
                          'Foto tidak tersedia',
                          style: TextStyle(
                              color: AppTheme.onSurfaceVariant, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spaceMd),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _showImagePicker,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Ganti Foto'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.secondary,
                    side: const BorderSide(color: AppTheme.secondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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

  Widget _buildCard(BuildContext context, Widget child) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: child,
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppTheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18, color: AppTheme.onSurfaceVariant),
            filled: true,
            fillColor: AppTheme.surfaceContainer,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppTheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: _categories
                  .map(
                    (cat) => DropdownMenuItem(
                      value: cat,
                      child: Text(
                        cat,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedCategory = val);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ),
        const SizedBox(width: AppTheme.spaceMd),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _saveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondary,
              foregroundColor: AppTheme.onSecondary,
              padding:
                  const EdgeInsets.symmetric(vertical: AppTheme.spaceSm),
            ),
            child: const Text('Simpan Perubahan'),
          ),
        ),
      ],
    );
  }
}
