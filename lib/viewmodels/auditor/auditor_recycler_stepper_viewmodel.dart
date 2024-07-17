import 'package:cpcb_tyre/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:cpcb_tyre/constants/enums/enums.dart';
import 'package:cpcb_tyre/constants/message_constant.dart';
import 'package:cpcb_tyre/constants/string_constant.dart';
import 'package:cpcb_tyre/models/request/auditor/producer/produer_form_1_request_model.dart';
import 'package:cpcb_tyre/utils/helper/helper_functions.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../../../controllers/auditor/auditor_repository.dart';
import '../../../models/response/common/file_size_model.dart';

class CommonStepperViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  int index = 1;

  int totalIndex = 0;
  void getUser(String? user) {
    switch (user) {
      case "Producer":
        totalIndex = 3;
        break;
      case "Recycler":
        totalIndex = 5;
        break;
      default:
        totalIndex = 3;
        break;
    }
    updateUI();
  }

  void onBackButton(BuildContext context) {
    if (index > 1) {
      index--;
      updateUI();
    } else {
      Navigator.pop(context);
    }
  }

  void onNextButton(BuildContext context, String? user) {
    switch (user) {
      case "Producer":
        if (index < 3) {
          index++;
          updateUI();
        }
        break;
      case "Recycler":
        if (index < 5) {
          index++;
          updateUI();
        }
        break;
      default:
        if (index < 5) {
          index++;
          updateUI();
        }
        break;
    }
  }

  void formValidation(BuildContext context, String? userType) {
    if (formKey.currentState?.validate() ?? false) {
      onNextButton(context, userType);
    } else {}
  }

  // Producer Form 1 viewModel
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

  String radioCompanyDetail = "confirmed";
  String radioCategoryOfProducer = "confirmed";
  String radioGst = "confirmed";
  String radioPanOfCompany = "confirmed";
  String radioCin = "confirmed";
  String radioIec = "confirmed";

  MultipartFile? iecFile;
  MultipartFile? cinFile;
  MultipartFile? panFile;
  MultipartFile? gstFile;

  String? gstFilePath;
  String? panFilePath;
  String? cinFilePath;
  String? iecFilePath;

  FileSizeModel? gstFileSizeModel;
  FileSizeModel? panFileSizeModel;
  FileSizeModel? cinFileSizeModel;
  FileSizeModel? iecFileSizeModel;

  String? fileSize;
  double? fileSizeNum;

  String? fileError;

  String? gstFileName;
  String? panFileName;
  String? cinFileName;
  String? iecFileName;

  final _auditorRepository = AuditorRepository();
  ProducerForm1RequestModel? data;
  ProducerForm1RequestModel? producerForm1data;

  Future<void> postForm1Data(
      BuildContext context, ProducerForm1RequestModel requestModel) async {
    try {
      final res = await _auditorRepository.postProducerForm1Data(requestModel);
      if (res?.isSuccess == true) {
        if (context.mounted) {
          HelperFunctions()
              .commonErrorSnackBar(context, res?.data?.message ?? "");
        }
      }
    } catch (e) {
      if (context.mounted) {
        HelperFunctions()
            .commonErrorSnackBar(context, stringConstants.somethingWentWrong);
      }
    }
  }

  void initalizeGroupValues() {
    radioCompanyDetail = stringConstants.confirmed;
    radioCategoryOfProducer = stringConstants.confirmed;
    radioGst = stringConstants.confirmed;
    radioPanOfCompany = stringConstants.confirmed;
    radioCin = stringConstants.confirmed;
    radioIec = stringConstants.confirmed;
  }

  String? validate(String controller) {
    if (controller.isEmpty) {
      return "Please enter a value";
    } else {
      return null;
    }
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
          gstFileSizeModel = await getFileSize(gstFilePath ?? "", 1);
          fileSize = gstFileSizeModel?.fileSize ?? "0 B";
          gstFileName = file.path.split('/').last;
          updateUI();
          break;
        case AuditorProducerForm1.panOfCompany:
          final file = File(result.files.single.path ?? "");
          panFilePath = file.path;
          panFileSizeModel = await getFileSize(panFilePath ?? "", 1);
          fileSize = panFileSizeModel?.fileSize ?? "0 B";
          panFileName = file.path.split('/').last;
          updateUI();
          break;
        case AuditorProducerForm1.cin:
          final file = File(result.files.single.path ?? "");
          cinFilePath = file.path;
          cinFileSizeModel = await getFileSize(cinFilePath ?? "", 1);
          fileSize = cinFileSizeModel?.fileSize ?? "0 B";
          cinFileName = file.path.split('/').last;
          updateUI();
          break;
        case AuditorProducerForm1.iec:
          final file = File(result.files.single.path ?? "");
          iecFilePath = file.path;
          iecFileSizeModel = await getFileSize(iecFilePath ?? "", 1);
          fileSize = iecFileSizeModel?.fileSize ?? "0 B";
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

  String? uploadInvoiceValidation(FileSizeModel? fileSizeModel) {
    if (fileSizeModel?.fileSize.contains("MB") ?? false) {
      if (fileSizeModel!.fileSizeNum > 2.0) {
        return messageConstant.maxFileSize;
      }
    }
    return null;
  }
}


