import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../view/screens/daily_actvities/homework/homework_submission_screen.dart';
import '../view/screens/storage.dart';
import 'package:http/http.dart' as http;

class BaseService {
  String token = LocalStorage.getValue('token') ?? "";
  Dio dio = Dio();

  Future loginAuth(Map<String, dynamic> userData, String url) async {
    FormData formData = FormData.fromMap(userData);
    try {
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
            validateStatus: (_) => true,
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }),
      );
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  Future postData(Map<String, dynamic> userData, String url) async {
    FormData formData = FormData.fromMap(userData);
    try {
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
            validateStatus: (_) => true,
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token'
            }),
      );
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  Future multipartFormData(XFile file, String url) async {
    String fileName = file.path.split('/').last;
    try {
      FormData data = FormData.fromMap({
        "photo": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      Response response = await dio.post(url,
          data: data,
          options: Options(
              responseType: ResponseType.json,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Authorization': 'Bearer $token',
                "Accept": "application/json",
              }));
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  Future uploadMultipleFiles(
      {required String homewrkId,
      required String homewrkText,
      required List<FilesUploadModel> filesList,
      required String url}) async {
    FormData data = FormData.fromMap({});
    try {
      if (filesList.isNotEmpty) {
        for (int i = 0; i < filesList.length; i++) {
          String fileName = filesList[i].file!.path.split('/').last;
          data = FormData.fromMap({
            "student_id": LocalStorage.getValue("studentId"),
            "homework_id": homewrkId,
            "stu_description": homewrkText,
            "stu_homework_file": await MultipartFile.fromFile(
              filesList[i].file!.path,
              filename: fileName,
            )
          });
        }
      } else {
        data = FormData.fromMap({
          "student_id": LocalStorage.getValue("studentId"),
          "homework_id": homewrkId,
          "stu_description": homewrkText,
          "stu_homework_file": []
        });
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(
              responseType: ResponseType.json,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Authorization': 'Bearer $token',
                "Accept": "application/json",
              }));
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  Future getData(String url) async {
    try {
      Response response = await dio.get(
        url,
        options: Options(
            validateStatus: (_) => true,
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token}'
            }),
      );
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }
}
