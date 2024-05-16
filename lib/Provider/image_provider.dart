import 'package:flutter/material.dart';
import 'package:test_app/Model/image_model.dart';
import 'package:test_app/Service/service.dart';

class ImagesProvider extends ChangeNotifier {
  final imageService = ImageService();
  final List<ImageModel> _photos = [];
  int _page = 1;
  bool _isLoading = false;

  List<ImageModel> get photos => _photos;
  bool get isLoading => _isLoading;

  Future<void> fetchPhotos() async {
    try {
      _isLoading = true;
      final List<ImageModel> fetchedPhotos =
          await ImageService.fetchPhotos(page: _page);
      _photos.addAll(fetchedPhotos);
      _page++;
    } catch (e) {
      debugPrint('Error fetching photos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
