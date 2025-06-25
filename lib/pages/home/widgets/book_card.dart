import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../../../data/database/app_database.dart';
import '../../../shared/constants.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCard({
    Key? key,
    required this.book,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.cardMargin * 2),
      child: Card(
        elevation: 3,
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
                // Book icon and title row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.book,
                        color: AppTheme.primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // English name
                          Text(
                            book.title, // Changed from nameEnglish to title
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Bangla name - Not available in new schema
                          // You can remove this or use another field
                          Text(
                            book.bookName, // Using bookName instead of nameBangla
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

                const SizedBox(height: 16),

                // Arabic name
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    book.titleAr, // Changed from nameArabic to titleAr
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.arabicTextColor,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                ),

                const SizedBox(height: 12),

                // Total hadith count
                Row(
                  children: [
                    const Icon(
                      Icons.format_list_numbered,
                      color: AppTheme.textSecondary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Total Hadiths: ${book.numberOfHadis}', // Changed from totalHadith to numberOfHadis
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),

                // Description if available
                if (book.bookDescr.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    book.bookDescr,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
