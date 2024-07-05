import 'dart:io';
import 'dart:math';

import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../models/response/common/file_size_model.dart';

class ProducerForm1ViewModel extends BaseViewModel {
  final stringConstants = StringConstants();
  final messageConstant = MessageConstant();
  final helperFunctions = HelperFunctions();
  TextEditingController companyNameRemark = TextEditingController();
  TextEditingController categoryOfProducerRemark = TextEditingController();
  TextEditingController gstRemark = TextEditingController();
  TextEditingController panOfCompanyRemark = TextEditingController();
  TextEditingController cinRemark = TextEditingController();
  TextEditingController iecRemark = TextEditingController();
  TextEditingController iecController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController gstController = TextEditingController();

  MultipartFile? iecFile;
  MultipartFile? cinFile;
  MultipartFile? panFile;
  MultipartFile? gstFile;

  String radioCompanyDetail = "";
  String radioCategoryOfProducer = "";
  String radioGst = "";
  String radioPanOfCompany = "";
  String radioCin = "";
  String radioIec = "";

  String? gstFilePath;
  String? panFilePath;
  String? cinFilePath;
  String? iecFilePath;
  String? fileError;
  FileSizeModel? fileSizeModel;
  String? fileSize;
  double? fileSizeNum;

  String? gstFileName;
  String? panFileName;
  String? cinFileName;
  String? iecFileName;

  void initalizeGroupValues() {
    radioCompanyDetail = stringConstants.confirmed;
    radioCategoryOfProducer = stringConstants.confirmed;
    radioGst = stringConstants.confirmed;
    radioPanOfCompany = stringConstants.confirmed;
    radioCin = stringConstants.confirmed;
    radioIec = stringConstants.confirmed;
  }

  void handleOnSuffixTap(
    BuildContext context,
    AuditorProducerForm1 fieldName,
    TextEditingController controller,
    MultipartFile? selectedFileName,
  ) async {
    if (controller.text.isEmpty) {
      var res = await openFileManager(context, fieldName);

      if (res != null) {
        controller.text = res.files.isEmpty ? "" : res.files.first.name;
        selectedFileName = await MultipartFile.fromFile(
            res.files.first.path ?? '',
            filename: "uploadInvoice.pdf");
      }
    } else {
      switch (fieldName) {
        case AuditorProducerForm1.gst:
          controller.text = "";
          gstFilePath = null;
          break;
        case AuditorProducerForm1.panOfCompany:
          controller.text = "";
          panFilePath = null;
          break;
        case AuditorProducerForm1.cin:
          controller.text = "";
          cinFilePath = null;
          break;
        case AuditorProducerForm1.iec:
          controller.text = "";
          iecFilePath = null;
          break;
      }

      updateUI();
    }
  }

  void handleOnTap(
    BuildContext context,
    AuditorProducerForm1 fieldName,
    TextEditingController controller,
    MultipartFile? selectedFileName,
  ) async {
    if (controller.text.isEmpty) {
      var res = await openFileManager(context, fieldName);

      if (res != null) {
        controller.text = res.files.isEmpty ? "" : res.files.first.name;
        selectedFileName = await MultipartFile.fromFile(
            res.files.first.path ?? '',
            filename: "uploadInvoice.pdf");
      }
    } else {
      switch (fieldName) {
        case AuditorProducerForm1.gst:
          helperFunctions.openFile(gstFilePath ?? '');
          break;
        case AuditorProducerForm1.panOfCompany:
          helperFunctions.openFile(panFilePath ?? '');
          break;
        case AuditorProducerForm1.cin:
          helperFunctions.openFile(cinFilePath ?? '');

          break;
        case AuditorProducerForm1.iec:
          helperFunctions.openFile(iecFilePath ?? '');
          break;
      }
    }
  }

  Future<FilePickerResult?> openFileManager(
      BuildContext context, AuditorProducerForm1 fieldName) async {
    fileError = null;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
    if (result != null) {
      switch (fieldName) {
        case AuditorProducerForm1.gst:
          final file = File(result.files.single.path ?? "");
          gstFilePath = file.path;
          fileSizeModel = await getFileSize(gstFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          gstFileName = file.path.split('/').last;
          updateUI();
          break;
        case AuditorProducerForm1.panOfCompany:
          final file = File(result.files.single.path ?? "");
          panFilePath = file.path;
          fileSizeModel = await getFileSize(panFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          panFileName = file.path.split('/').last;
          updateUI();
          break;
        case AuditorProducerForm1.cin:
          final file = File(result.files.single.path ?? "");
          cinFilePath = file.path;
          fileSizeModel = await getFileSize(cinFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          cinFileName = file.path.split('/').last;
          updateUI();
          break;
        case AuditorProducerForm1.iec:
          final file = File(result.files.single.path ?? "");
          iecFilePath = file.path;
          fileSizeModel = await getFileSize(iecFilePath ?? "", 1);
          fileSize = fileSizeModel?.fileSize ?? "0 B";
          iecFileName = file.path.split('/').last;
          updateUI();
          break;
      }
    } else {
      fileError = messageConstant.pleaseSelectFile;
      updateUI();
    }
    return result;
  }

  Future<FileSizeModel> getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) {
      return FileSizeModel(fileSize: "0 B", fileSizeNum: 0);
    }
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    fileSizeNum = bytes / pow(1024, i);
    return FileSizeModel(
        fileSize:
            '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}',
        fileSizeNum: fileSizeNum ?? 0);
  }
}
