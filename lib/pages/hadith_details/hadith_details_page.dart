//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/hadith_details_controller.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/error_widget.dart';

class HadithDetailsPage extends StatelessWidget {
  const HadithDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HadithDetailsController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              controller.selectedChapter.value?.title ?? 'Hadith Details',
            )),
        actions: [
          Obx(() {
            if (controller.currentHadith != null) {
              return IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showBottomSheet(context, controller),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            final chapter = controller.selectedChapter.value;
            if (chapter == null) return const SizedBox.shrink();

            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(chapter.title),
                  Text('Chapter ${chapter.number}'),
                  if (chapter.hadisRange != null) Text(chapter.hadisRange!),
                ],
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const LoadingWidget(message: 'Loading Hadiths...');
              }

              if (controller.error.value.isNotEmpty) {
                return CustomErrorWidget(
                  message: controller.error.value,
                  onRetry: controller.refreshHadiths,
                );
              }

              if (controller.hadiths.isEmpty) {
                return const Center(child: Text('No hadiths found'));
              }

              final hadith = controller.currentHadith;
              if (hadith == null) {
                return const Center(child: Text('No hadith selected'));
              }

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: controller.currentHadithIndex.value > 0
                              ? controller.previousHadith
                              : null,
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        Text(
                          '${controller.currentHadithIndex.value + 1} of ${controller.hadiths.length}',
                        ),
                        IconButton(
                          onPressed: controller.currentHadithIndex.value <
                                  controller.hadiths.length - 1
                              ? controller.nextHadith
                              : null,
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: controller.refreshHadiths,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              hadith.ar!,
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 16),
                            Text(hadith.bn!),
                            const SizedBox(height: 16),
                            Text(
                              'Narrator: ${hadith.narrator}',
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                            if (hadith.grade != null)
                              Text(
                                'Grade: ${hadith.grade}',
                                style: TextStyle(
                                  color: hadith.gradeColor != null
                                      ? Color(int.parse(hadith.gradeColor!
                                          .replaceFirst('#', '0xff')))
                                      : Colors.black,
                                ),
                              ),
                            if (hadith.note != null)
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[100],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(hadith.note!),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(
      BuildContext context, HadithDetailsController controller) {
    final hadith = controller.currentHadith;
    if (hadith == null) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hadith Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Hadith ID: ${hadith.hadithId}'),
            if (hadith.hadithKey != null) Text('Key: ${hadith.hadithKey}'),
            if (hadith.sectionId != null)
              Text('Section ID: ${hadith.sectionId}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
