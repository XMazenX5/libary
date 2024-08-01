import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librayproject/screens/books/data/banner_model.dart';
import 'package:librayproject/screens/books/data/books_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<BannerModel> banner = [];

  Future<void> getbanners() async {
    emit(HomeLoading());
    var url = Uri.parse('https://student.valuxapps.com/api/banners');

    try {
      final response = await http.get(url);

      var result = json.decode(response.body);

      if (result['status'] == true) {
        // debugPrint('Sucess');
        for (var element in result['data']) {
          banner.add(
              BannerModel.fromJson(element));
        }
        emit(HomeSuccess());
      } else {
        debugPrint('error $result');
        emit(HomeError());
      }
    } catch (e) {
      debugPrint('error when getting product ${e.toString()}');
    }
  }

  List<BooksModel> allbooks = [];

  Future<void> getallBooks() async {
    emit(HomeLoading());
    var url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=everything&maxResults=40');

    try {
      final response = await http.get(url);
      var result = json.decode(response.body);

      if (response.statusCode == 200) {
        // debugPrint('Success $result');
        for (var element in result['items']) {
          allbooks.add(
              BooksModel.fromJson(element));
        }



        emit(HomeSuccess());
      } else {
        debugPrint('Error: ${response.statusCode}');
        emit(HomeError());
      }
    } catch (e) {
      debugPrint('Error when fetching books: ${e.toString()}');
      emit(HomeError());
    }
  }

  List<BooksModel> recobooks = [];

  Future<void> getrecoBooks() async {
    emit(HomeLoading());
    var url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=book&orderBy=relevance&maxResults=13');

    try {
      final response = await http.get(url);
      var result = json.decode(response.body);

      if (response.statusCode == 200) {
        // debugPrint('Success $result');
        for (var element in result['items']) {
          recobooks.add(
              BooksModel.fromJson(element));
        }



        emit(HomeSuccess());
      } else {
        debugPrint('Error: ${response.statusCode}');
        emit(HomeError());
      }
    } catch (e) {
      debugPrint('Error when fetching books: ${e.toString()}');
      emit(HomeError());
    }
  }

  List<BooksModel> qbooks = [];

  Future<void> getqBooks(q) async {
    emit(HomeLoading());
    var url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$q+subject&maxResults=40');

    try {
      final response = await http.get(url);
      var result = json.decode(response.body);

      if (response.statusCode == 200) {
        // debugPrint('Success $result');
        for (var element in result['items']) {
          qbooks.add(
              BooksModel.fromJson(element));
        }



        emit(HomeSuccess());
      } else {
        debugPrint('Error: ${response.statusCode}');
        emit(HomeError());
      }
    } catch (e) {
      debugPrint('Error when fetching books: ${e.toString()}');
      emit(HomeError());
    }
  }

  List<BooksModel> infobooks = [];

  Future<void> getinfoBooks(String id) async {
    emit(HomeLoading());
    var url = Uri.parse('https://www.googleapis.com/books/v1/volumes/$id');

    try {
      final response = await http.get(url);
      var result = json.decode(response.body);

      if (response.statusCode == 200) {
        // debugPrint('Success $result');
        // Clear previous data
        infobooks.clear();

        // Add the single book object
        infobooks.add(BooksModel.fromJson(result));



        emit(HomeSuccess());
      } else {
        debugPrint('Error: ${response.statusCode}');
        emit(HomeError());
      }
    } catch (e) {
      debugPrint('Error when fetching books: ${e.toString()}');
      emit(HomeError());
    }
  }

  static Future<void> launchUrls(String booksUrl) async {
    final Uri url = Uri.parse(booksUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

}
