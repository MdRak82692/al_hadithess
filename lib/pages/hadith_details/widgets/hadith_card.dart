import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../../../data/database/app_database.dart';
import '../../../shared/constants.dart';

class HadithCard extends StatelessWidget {
  final Hadith hadith;

  const HadithCard({
    Key? key,
    required this.hadith,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hadith number header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Hadith ${hadith.hadithId}', // Changed from hadithNumber to hadithId
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Arabic text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Arabic Text',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hadith.ar!, // Changed from hadithArabic to ar
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.arabicTextColor,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // English translation - Not available in new schema
            // You can remove this section or use another field

            const SizedBox(height: 16),

            // Bangla translation
            _buildTranslationSection(
              context,
              'Bengali Translation',
              hadith.bn!, // Changed from hadithBangla to bn
              TextAlign.left,
            ),

            const SizedBox(height: 20),

            // Narrator info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.secondaryColor.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: AppTheme.secondaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Narrator',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hadith.narrator!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),

            // Grade and Note (if available)
            if (hadith.grade != null || hadith.note != null) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  if (hadith.grade != null) ...[
                    Expanded(
                      child: _buildInfoChip('Grade', hadith.grade!, Icons.star),
                    ),
                  ],
                  if (hadith.grade != null && hadith.note != null)
                    const SizedBox(width: 12),
                  if (hadith.note != null) ...[
                    Expanded(
                      child: _buildInfoChip('Note', hadith.note!, Icons.note),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTranslationSection(
    BuildContext context,
    String title,
    String text,
    TextAlign textAlign,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.textSecondary.withOpacity(0.2),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
            textAlign: textAlign,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppTheme.primaryColor,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
