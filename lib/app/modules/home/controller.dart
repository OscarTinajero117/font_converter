// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';
import 'dart:html' show AnchorElement;
import 'dart:convert' show utf8;
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
//
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController {
  final fileName = ''.obs;

  final loading = false.obs;

  final visible = false.obs;

  final bytes = <int>[].obs;

  final fontName = TextEditingController();

  final fontSize = TextEditingController();

  final fontStyle = TextEditingController();

  Future<void> searchFile() async {
    visible.value = false;
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        loading.value = true;
        fileName.value = result.files.single.name;

        bytes.value = result.files.single.bytes as List<int>;

        visible.value = true;
      }
    } catch (e) {
      log('$e');
    }
    loading.value = false;
  }

  Future<void> saveFile() async {
    final nameList =
        '_${fontName.text.toUpperCase()}_${fontSize.text.toUpperCase()}_${fontStyle.text.toUpperCase()}_';
    final name =
        '${fontName.text.toLowerCase()}${fontSize.text}${fontStyle.text}';

    final text = '''
// ignore_for_file: depend_on_referenced_packages

import 'package:image/image.dart' as ui;

final $name = ui.BitmapFont.fromZip($nameList);
const List<int> $nameList = $bytes;
  ''';

    if (GetPlatform.isWeb) {
      AnchorElement()
        ..href =
            '${Uri.dataFromString(text, mimeType: 'text/dart', encoding: utf8)}'
        ..download = '$name.dart'
        ..style.display = 'none'
        ..click();
    }

    if (GetPlatform.isWindows || GetPlatform.isMacOS || GetPlatform.isLinux) {
      // final outputFile =
      await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: '$name.dart',
      );
    }

    if (GetPlatform.isMobile) {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$name.dart');
      file.writeAsString(text);
    }
  }

  @override
  void onClose() {
    fontName.dispose();
    fontSize.dispose();
    fontStyle.dispose();
    super.onClose();
  }
}
