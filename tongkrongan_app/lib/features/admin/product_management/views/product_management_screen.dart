import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  String _selectedStore = 'Selasar Kopi & Ruang Diskusi';
  String _selectedCategory = 'semua';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _products = [
    {
      'image': 'https://images.unsplash.com/photo-1559056199-641a0ac8b3f7?w=200&h=200&fit=crop',
      'category': 'KOPI & SIGNATURE',
      'name': 'Es Kopi Selasar Aren',
      'description': 'Espresso double shot, susu segar, dan gula aren organik homemade',
      'price': 'Rp 22.000',
      'status': 'tersedia',
      'isActive': true,
    },
    {
      'image': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=200&h=200&fit=crop',
      'category': 'MAKANAN BERAT',
      'name': 'Nasi Kulit Sambal Matah',
      'description': 'Nasi hangat dengan kulit ayam renyah berhumbur rempah dan...',
      'price': 'Rp 32.000',
      'status': 'tersedia',
      'isActive': true,
    },
    {
      'image': 'https://images.unsplash.com/photo-1447933601403-0c6688bcb4e8?w=200&h=200&fit=crop',
      'category': 'KOPI SINGLE ORIGIN',
      'name': 'Manual Brew V60 Ace...',
      'description': 'Notes: Floral, peach, caramel finish. Medium roast dengan teknik filter.',
      'price': 'Rp 28.000',
      'status': 'tersedia',
      'isActive': true,
    },
    {
      'image': 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=200&h=200&fit=crop',
      'category': 'SNACK / CAMILAN',
      'name': 'Roti Panggang Cokela...',
      'description': 'Stok Habis',
      'price': 'Rp 18.000',
      'status': 'nonaktif',
      'isActive': false,
      'note': 'Dinonaktifkan sementara atas permintaan owner karena persediaan bahan kopi habis.',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _filterProducts();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppTheme.margin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title & Subtitle
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.secondary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                            ),
                            child: Text(
                              '● KURASI VISUAL & INFO',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppTheme.secondary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spaceSm),
                          Text(
                            'Manajemen Katalog & Produk',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Kurasi menu, foto hidangan, harga jual, dan keterseediaan etalase publik',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Add Product Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.secondary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppTheme.spaceSm,
                                ),
                              ),
                              icon: const Icon(Icons.add),
                              label: const Text('+ Tambah Produk'),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Store Dropdown
                          _buildStoreDropdown(context),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Search Bar
                          _buildSearchBar(context),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Category Tabs
                          _buildCategoryTabs(context),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Products List
                          if (filteredProducts.isEmpty)
                            _buildEmptyState(context)
                          else
                            Column(
                              children: List.generate(
                                filteredProducts.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppTheme.spaceMd,
                                  ),
                                  child: _buildProductCard(
                                    context,
                                    filteredProducts[index],
                                  ),
                                ),
                              ),
                            ),

                          // Help Section
                          const SizedBox(height: AppTheme.spaceLg),
                          Container(
                            padding: const EdgeInsets.all(AppTheme.spaceMd),
                            decoration: BoxDecoration(
                              color: AppTheme.secondary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                              border: Border.all(
                                color: AppTheme.secondary.withValues(alpha: 0.2),
                              ),
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
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.help_outline,
                                        color: AppTheme.onSecondary,
                                      ),
                                    ),
                                    const SizedBox(width: AppTheme.spaceMd),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bantuan Unggah Menu Massal?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppTheme.onSurface,
                                            ),
                                          ),
                                          Text(
                                            'Punya daftar menu banyak dalam format Excel/CSV dari kedai mitra? Tim Data Ops Tongkrongan siap bantu proses kurasi.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                              color: AppTheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppTheme.spaceMd),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.secondary,
                                    ),
                                    icon: const Icon(Icons.table_chart),
                                    label: const Text('Hubungi Tim Data Ops'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      'OPERATOR PORTAL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Produk',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreDropdown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceSm),
      child: Row(
        children: [
          Icon(Icons.store, size: 18, color: AppTheme.onSurfaceVariant),
          const SizedBox(width: AppTheme.spaceSm),
          Expanded(
            child: DropdownButton<String>(
              value: _selectedStore,
              isExpanded: true,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: 'Selasar Kopi & Ruang Diskusi',
                  child: Text('Selasar Kopi & Ruang Diskusi'),
                ),
                DropdownMenuItem(
                  value: 'Kala Kopi & Ruang Cerita',
                  child: Text('Kala Kopi & Ruang Cerita'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedStore = value);
                }
              },
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Cari nama makanan, minuman...',
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.onSurfaceVariant,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.tune),
            color: AppTheme.onSurfaceVariant,
            onPressed: () {},
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: AppTheme.spaceSm),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context) {
    final categories = [
      {'label': 'Semua', 'value': 'semua', 'count': '50'},
      {'label': 'Kopi & Minuman', 'value': 'kopi', 'count': '18'},
      {'label': 'Makanan Berat', 'value': 'makanan', 'count': '12'},
      {'label': 'Snack', 'value': 'snack', 'count': '8'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) {
            final category = categories[index];
            final isSelected = _selectedCategory == category['value'];

            return Padding(
              padding: EdgeInsets.only(right: index < categories.length - 1 ? 8 : 0),
              child: GestureDetector(
                onTap: () =>
                    setState(() => _selectedCategory = category['value'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.secondary
                        : AppTheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                    boxShadow: isSelected ? [AppTheme.shadowSm] : null,
                  ),
                  child: Row(
                    children: [
                      Text(
                        category['label'] as String,
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isSelected
                              ? AppTheme.onSecondary
                              : AppTheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.onSecondary.withValues(alpha: 0.2)
                              : AppTheme.outlineVariant,
                          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                        ),
                        child: Text(
                          category['count'] as String,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: isSelected
                                ? AppTheme.onSecondary
                                : AppTheme.onSurface,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceLg),
        child: Column(
          children: [
            Icon(Icons.fastfood_outlined, size: 48, color: AppTheme.onSurfaceVariant),
            const SizedBox(height: AppTheme.spaceMd),
            Text('Tidak ada produk', style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Header with Image
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                child: Image.network(
                  product['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    color: AppTheme.surfaceContainer,
                    child: Icon(Icons.image, color: AppTheme.onSurfaceVariant),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.tertiary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                      child: Text(
                        product['category'],
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.tertiary,
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product['name'],
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: product['isActive']
                                ? AppTheme.tertiary.withValues(alpha: 0.15)
                                : AppTheme.outlineVariant.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                          ),
                          child: Text(
                            product['isActive'] ? '● Tersedia' : '● Nonaktif',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: product['isActive']
                                  ? AppTheme.tertiary
                                  : AppTheme.onSurfaceVariant,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product['description'],
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),

          // Price & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Harga:',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    product['price'],
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: product['isActive'],
                      onChanged: (value) {},
                      activeColor: AppTheme.tertiary,
                    ),
                  ),
                  Text(
                    product['isActive'] ? 'Etalase Aktif' : 'Nonaktif',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (product['note'] != null) ...[
            const SizedBox(height: AppTheme.spaceMd),
            Container(
              padding: const EdgeInsets.all(AppTheme.spaceSm),
              decoration: BoxDecoration(
                color: AppTheme.error.withValues(alpha: 0.1),
                border: Border.all(
                  color: AppTheme.error.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info,
                    size: 14,
                    color: AppTheme.error,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      product['note'],
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: AppTheme.spaceMd),

          // Action Buttons
          Row(
            children: [
              if (product['isActive'])
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.image_search, size: 16),
                    label: const Text(''),
                  ),
                )
              else
                const SizedBox(),
              if (product['isActive']) const SizedBox(width: AppTheme.spaceSm),
              Expanded(
                flex: product['isActive'] ? 1 : 2,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondary,
                  ),
                  child: const Text('Edit Menu'),
                ),
              ),
              if (!product['isActive']) ...[
                const SizedBox(width: AppTheme.spaceSm),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle, size: 16),
                    label: const Text('Aktifkan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.tertiary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _filterProducts() {
    var filtered = _products;

    // Filter by category
    if (_selectedCategory == 'kopi') {
      filtered = filtered
          .where((p) => p['category'].toLowerCase().contains('kopi'))
          .toList();
    } else if (_selectedCategory == 'makanan') {
      filtered = filtered
          .where((p) => p['category'].toLowerCase().contains('makanan'))
          .toList();
    } else if (_selectedCategory == 'snack') {
      filtered = filtered
          .where((p) => p['category'].toLowerCase().contains('snack'))
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((p) =>
              p['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
              p['description']
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }
}
