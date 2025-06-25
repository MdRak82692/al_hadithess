import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../../../data/database/app_database.dart';
import '../../../shared/constants.dart';

class ChapterCard extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback onTap;

  const ChapterCard({
    Key? key,
    required this.chapter,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.cardMargin * 2),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Chapter number and title row
                Row(
                  children: [
                    // Chapter number badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${chapter.number}', // Changed from chapterNumber to number
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // English name
                          Text(
                            chapter.title, // Changed from nameEnglish to title
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Bangla name - Not available in new schema
                          // You can remove this or use another field
                          Text(
                            chapter
                                .bookName, // Using bookName instead of nameBangla
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: AppTheme.textSecondary,
                      size: 16,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Arabic name - Not available in new schema
                // You can remove this section or use another field

                const SizedBox(height: 12),

                // Hadith range
                if (chapter.hadisRange != null) ...[
                  Row(
                    children: [
                      const Icon(
                        Icons.format_list_numbered,
                        color: AppTheme.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Hadith Range: ${chapter.hadisRange}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
