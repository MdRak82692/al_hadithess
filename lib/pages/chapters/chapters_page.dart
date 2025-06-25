import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chapters_controller.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/error_widget.dart';

class ChaptersPage extends StatelessWidget {
  const ChaptersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChaptersController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              controller.selectedBook.value?.title ?? 'Chapters',
            )),
      ),
      body: Column(
        children: [
          Obx(() {
            final book = controller.selectedBook.value;
            if (book == null) return const SizedBox.shrink();

            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    book.titleAr,
                    style: const TextStyle(fontSize: 20),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(book.title),
                  Text('${book.numberOfHadis} hadiths'),
                ],
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const LoadingWidget(message: 'Loading Chapters...');
              }

              if (controller.error.value.isNotEmpty) {
                return CustomErrorWidget(
                  message: controller.error.value,
                  onRetry: controller.refreshChapters,
                );
              }

              if (controller.chapters.isEmpty) {
                return const Center(child: Text('No chapters found'));
              }

              return RefreshIndicator(
                onRefresh: controller.refreshChapters,
                child: ListView.builder(
                  itemCount: controller.chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = controller.chapters[index];
                    return Card(
                      child: ListTile(
                        title: Text(chapter.title),
                        subtitle: Text(chapter.hadisRange ?? ''),
                        trailing: Text('Chapter ${chapter.number}'),
                        onTap: () => controller.goToHadithDetails(chapter),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}