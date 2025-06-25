import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../../../data/database/app_database.dart';

class HadithBottomSheet extends StatelessWidget {
  final Hadith hadith;

  const HadithBottomSheet({
    Key? key,
    required this.hadith,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(
                  Icons.menu_book,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Hadith ${hadith.hadithId}', // Changed from hadithNumber to hadithId
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: AppTheme.textSecondary,
                ),
              ],
            ),
          ),

          // Divider
          Divider(
            height: 1,
            color: Colors.grey[200],
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Copy Arabic Text
                _buildActionButton(
                  icon: Icons.copy,
                  title: 'Copy Arabic Text',
                  subtitle: 'Copy the Arabic hadith text',
                  onTap: () {
                    // TODO: Implement copy functionality
                    Navigator.pop(context);
                    _showSnackBar(context, 'Arabic text copied to clipboard');
                  },
                ),

                const SizedBox(height: 12),

                // Copy Bengali Translation
                _buildActionButton(
                  icon: Icons.language,
                  title: 'Copy Bengali Translation',
                  subtitle: 'Copy the Bengali translation',
                  onTap: () {
                    // TODO: Implement copy functionality
                    Navigator.pop(context);
                    _showSnackBar(
                        context, 'Bengali translation copied to clipboard');
                  },
                ),

                const SizedBox(height: 12),

                // Share Hadith
                _buildActionButton(
                  icon: Icons.share,
                  title: 'Share Hadith',
                  subtitle: 'Share this hadith with others',
                  onTap: () {
                    // TODO: Implement share functionality
                    Navigator.pop(context);
                    _showSnackBar(context, 'Share functionality coming soon');
                  },
                ),

                const SizedBox(height: 12),

                // Bookmark Hadith
                _buildActionButton(
                  icon: Icons.bookmark_border,
                  title: 'Bookmark Hadith',
                  subtitle: 'Save this hadith to bookmarks',
                  onTap: () {
                    // TODO: Implement bookmark functionality
                    Navigator.pop(context);
                    _showSnackBar(
                        context, 'Bookmark functionality coming soon');
                  },
                ),

                const SizedBox(height: 12),

                // Report Issue
                _buildActionButton(
                  icon: Icons.report_outlined,
                  title: 'Report Issue',
                  subtitle: 'Report a problem with this hadith',
                  onTap: () {
                    // TODO: Implement report functionality
                    Navigator.pop(context);
                    _showSnackBar(context, 'Report functionality coming soon');
                  },
                  isDestructive: true,
                ),
              ],
            ),
          ),

          // Bottom safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDestructive
                ? Colors.red.withOpacity(0.2)
                : AppTheme.primaryColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDestructive
                    ? Colors.red.withOpacity(0.1)
                    : AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isDestructive ? Colors.red : AppTheme.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? Colors.red : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDestructive
                          ? Colors.red.withOpacity(0.7)
                          : AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isDestructive
                  ? Colors.red.withOpacity(0.5)
                  : AppTheme.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
