import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  // Format hadith number
  static String formatHadithNumber(int number) {
    return 'Hadith #$number';
  }

  // Get text direction for Arabic text
  static TextDirection getTextDirection(String text) {
    // Simple check for Arabic characters
    if (text.contains(RegExp(r'[\u0600-\u06FF]'))) {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }

  // Format chapter title
  static String formatChapterTitle(int chapterNumber, String name) {
    return 'Chapter $chapterNumber: $name';
  }

  // Show snackbar
  static void showSnackBar(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? 'Error' : 'Info',
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  // Validate Arabic text
  static bool isArabicText(String text) {
    return text.contains(RegExp(r'[\u0600-\u06FF]'));
  }
}