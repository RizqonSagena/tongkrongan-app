import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Admin'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: AppTheme.primary,
              child: Icon(
                Icons.admin_panel_settings,
                size: 48,
                color: AppTheme.onPrimary,
              ),
            ),
            SizedBox(height: AppTheme.spaceMd),
            Text(
              'Profil Admin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.onSurface,
              ),
            ),
            SizedBox(height: AppTheme.spaceSm),
            Text(
              'Kelola pengaturan sistem dan akun admin',
              style: TextStyle(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}