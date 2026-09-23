import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class ContentFormScreen extends StatefulWidget {
  final Map<String, dynamic>? content;

  const ContentFormScreen({super.key, this.content});

  @override
  State<ContentFormScreen> createState() => _ContentFormScreenState();
}

class _ContentFormScreenState extends State<ContentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;

  String _selectedType = 'Promo';
  String _selectedStatus = 'Pending';
  bool _publishInstagram = false;
  bool _publishFacebook = false;
  bool _publishTiktok = false;
  bool _isPublished = false;

  final List<String> _contentTypes = ['Promo', 'Article', 'Event'];
  final List<String> _statusOptions = ['Active', 'Pending'];

  bool get _isEditMode => widget.content != null;

  @override
  void initState() {
    super.initState();
    final c = widget.content;
    _titleController = TextEditingController(text: c?['title'] ?? '');
    _descController = TextEditingController(
      text: c?['description'] ?? '',
    );
    if (c != null) {
      _selectedType = c['category'] ?? 'Promo';
      _selectedStatus = c['status'] == 'active' ? 'Active' : 'Pending';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
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
              child: _isPublished
                  ? _buildPublishedState(context)
                  : _buildForm(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    String title;
    if (_isPublished) {
      title = 'Konten Dipublikasikan';
    } else if (_isEditMode) {
      title = 'Edit Konten';
    } else {
      title = 'Buat Konten Baru';
    }

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
            title,
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

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.margin),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(context, 'Judul *'),
            const SizedBox(height: AppTheme.spaceSm),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Contoh: Promo Weekend Special',
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Judul wajib diisi' : null,
            ),
            const SizedBox(height: AppTheme.spaceMd),

            _buildLabel(context, 'Jenis Konten *'),
            const SizedBox(height: AppTheme.spaceSm),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                border: Border.all(color: AppTheme.outlineVariant),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedType,
                  isExpanded: true,
                  items: _contentTypes
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedType = v);
                  },
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spaceMd),

            _buildLabel(context, 'Deskripsi'),
            const SizedBox(height: AppTheme.spaceSm),
            TextFormField(
              controller: _descController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Tulis deskripsi konten...',
              ),
            ),
            const SizedBox(height: AppTheme.spaceMd),

            _buildLabel(context, 'Status'),
            const SizedBox(height: AppTheme.spaceSm),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                border: Border.all(color: AppTheme.outlineVariant),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedStatus,
                  isExpanded: true,
                  items: _statusOptions
                      .map(
                        (s) => DropdownMenuItem(value: s, child: Text(s)),
                      )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedStatus = v);
                  },
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spaceLg),

            _buildLabel(context, 'Platform Publikasi'),
            const SizedBox(height: AppTheme.spaceSm),
            _buildPlatformCheckboxes(context),
            const SizedBox(height: AppTheme.spaceLg),

            // Preview
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Preview: ${_titleController.text.isEmpty ? "Judul belum diisi" : _titleController.text}',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.visibility),
                label: const Text('Preview Konten'),
              ),
            ),
            const SizedBox(height: AppTheme.spaceSm),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handlePublish,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondary,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spaceSm,
                  ),
                ),
                child: Text(_isEditMode ? 'Perbarui' : 'Publikasikan'),
              ),
            ),
            const SizedBox(height: AppTheme.spaceLg),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformCheckboxes(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Column(
        children: [
          CheckboxListTile(
            title: Row(
              children: [
                Icon(Icons.camera_alt, size: 18, color: AppTheme.primary),
                const SizedBox(width: 8),
                const Text('Instagram'),
              ],
            ),
            value: _publishInstagram,
            activeColor: AppTheme.secondary,
            onChanged: (v) =>
                setState(() => _publishInstagram = v ?? false),
            controlAffinity: ListTileControlAffinity.trailing,
            dense: true,
          ),
          Divider(height: 1, color: AppTheme.outlineVariant),
          CheckboxListTile(
            title: Row(
              children: [
                Icon(Icons.facebook, size: 18, color: AppTheme.primary),
                const SizedBox(width: 8),
                const Text('Facebook'),
              ],
            ),
            value: _publishFacebook,
            activeColor: AppTheme.secondary,
            onChanged: (v) =>
                setState(() => _publishFacebook = v ?? false),
            controlAffinity: ListTileControlAffinity.trailing,
            dense: true,
          ),
          Divider(height: 1, color: AppTheme.outlineVariant),
          CheckboxListTile(
            title: Row(
              children: [
                Icon(Icons.music_note, size: 18, color: AppTheme.primary),
                const SizedBox(width: 8),
                const Text('TikTok'),
              ],
            ),
            value: _publishTiktok,
            activeColor: AppTheme.secondary,
            onChanged: (v) => setState(() => _publishTiktok = v ?? false),
            controlAffinity: ListTileControlAffinity.trailing,
            dense: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPublishedState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.margin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.tertiary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                size: 48,
                color: AppTheme.tertiary,
              ),
            ),
            const SizedBox(height: AppTheme.spaceLg),
            Text(
              'Konten Dipublikasikan!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: AppTheme.spaceSm),
            Text(
              '"${_titleController.text}" berhasil diterbitkan',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppTheme.spaceMd),
            Wrap(
              spacing: AppTheme.spaceSm,
              children: [
                if (_publishInstagram)
                  _buildPlatformBadge(context, 'Instagram'),
                if (_publishFacebook)
                  _buildPlatformBadge(context, 'Facebook'),
                if (_publishTiktok) _buildPlatformBadge(context, 'TikTok'),
              ],
            ),
            const SizedBox(height: AppTheme.spaceLg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondary,
                ),
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformBadge(BuildContext context, String platform) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.tertiary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: Border.all(color: AppTheme.tertiary.withValues(alpha: 0.3)),
      ),
      child: Text(
        '✓ $platform',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppTheme.tertiary,
          fontWeight: FontWeight.w700,
        ),
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

  void _handlePublish() {
    if (!_formKey.currentState!.validate()) return;

    final platforms = [
      if (_publishInstagram) 'Instagram',
      if (_publishFacebook) 'Facebook',
      if (_publishTiktok) 'TikTok',
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_isEditMode ? 'Perbarui Konten' : 'Publikasikan Konten'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Judul: "${_titleController.text}"',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text('Jenis: $_selectedType'),
            Text('Status: $_selectedStatus'),
            if (platforms.isNotEmpty)
              Text('Platform: ${platforms.join(", ")}'),
          ],
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
              setState(() => _isPublished = true);
            },
            child: Text(_isEditMode ? 'Perbarui' : 'Publikasikan'),
          ),
        ],
      ),
    );
  }
}
