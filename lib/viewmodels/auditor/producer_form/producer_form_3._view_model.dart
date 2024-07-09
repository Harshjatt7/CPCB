import 'dart:io';

import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../constants/string_constant.dart';

class ProducerForm3ViewModel extends BaseViewModel {
  final helperFunctions = HelperFunctions();
  final stringConstants = StringConstants();
  final messageConstant = MessageConstant();
  String radioMisreporting = "";
  String radioInformation = "";
  TextEditingController deviationController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      String path = result.files.single.path!;
      File file = File(path);

      int fileSize = await file.length();
      if (fileSize > 100 * 1024 * 1024) {
        helperFunctions.logger(
            'Selected video is larger than 100 MB. Please select another video.');
        updateUI();
        return;
      }
      Duration? videoDuration = await _getVideoDuration(path);
      if (videoDuration != null && videoDuration.inSeconds > 30) {
        helperFunctions.logger(
            'Selected video is longer than 30 seconds. Please select another video.');
      } else {
        helperFunctions.logger('Video is selected successfully.');
      }
    }
  }

  Future<Duration?> _getVideoDuration(String videoPath) async {
    final VideoPlayerController _controller =
        VideoPlayerController.file(File(videoPath));
    await _controller.initialize();
    final duration = _controller.value.duration;
    _controller.dispose();
    return duration;
  }
}
