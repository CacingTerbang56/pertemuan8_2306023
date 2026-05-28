import 'package:flutter/material.dart';
import '../models/pict_model.dart';
import '../services/pict_service.dart';

class PictProvider extends ChangeNotifier {

  List<PictModel> pictures = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> getPictures() async {

    try {

      isLoading = true;
      notifyListeners();

      pictures = await PictService.getPictures();

    } catch (e) {

      errorMessage = e.toString();

    } finally {

      isLoading = false;
      notifyListeners();

    }

  }

}