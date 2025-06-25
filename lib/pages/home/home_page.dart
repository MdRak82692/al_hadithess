import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/error_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadith Books'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget(message: 'Loading Books...');
        }

        if (controller.error.value.isNotEmpty) {
          return CustomErrorWidget(
            message: controller.error.value,
            onRetry: controller.refreshBooks,
          );
        }

        if (controller.books.isEmpty) {
          return const Center(child: Text('No books found'));
        }

        return RefreshIndicator(
          onRefresh: controller.refreshBooks,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.books.length,
            itemBuilder: (context, index) {
              final book = controller.books[index];
              return Card(
                child: ListTile(
                  title: Text(book.title),
                  subtitle: Text('${book.numberOfHadis} hadiths'),
                  trailing: Text(
                    book.titleAr,
                    style: const TextStyle(fontSize: 18),
                  ),
                  onTap: () => controller.goToChapters(book),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
