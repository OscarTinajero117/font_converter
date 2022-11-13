import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/my_text_form.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(Get.width * 0.1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'If you want use own fonts following with this steps:',
              ),
              const SizedBox(height: 10),
              const Text('  1. Get your .ttf file'),
              const SizedBox(height: 10),
              const Text(
                '  2. Convert ttf file to fnt zip with page: https://ttf2fnt.com/',
              ),
              const SizedBox(height: 10),
              const Text('  3. Select your .zip'),
              const SizedBox(height: 10),
              const Text(
                '  4. Add the .dart file to the project',
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async => await controller.searchFile(),
                icon: const Icon(Icons.search),
                label: const Text('Search'),
              ),
              const SizedBox(height: 20),
              Obx(() => Text('File Name: ${controller.fileName.value}')),
              Obx(
                () => controller.loading.value
                    ? const CircularProgressIndicator.adaptive()
                    : Column(
                        children: [
                          MyTextForm(
                            controller: controller.fontName,
                            labelTextDecoration: 'Font Name',
                            hintTextDecoration: 'Insert Font Name',
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          MyTextForm(
                            controller: controller.fontSize,
                            labelTextDecoration: 'Font Size',
                            hintTextDecoration: 'Insert Font Size',
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.number,
                          ),
                          MyTextForm(
                            controller: controller.fontStyle,
                            labelTextDecoration: 'Font Style',
                            hintTextDecoration: 'Insert Font Style',
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          Visibility(
                            visible: controller.visible.value,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                if (controller.fontStyle.text.isEmpty ||
                                    controller.fontSize.text.isEmpty ||
                                    controller.fontName.text.isEmpty) {
                                  return;
                                }
                                await controller.saveFile();
                              },
                              icon: const Icon(Icons.download),
                              label: const Text('Download file'),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
