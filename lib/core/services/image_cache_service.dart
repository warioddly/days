import 'dart:math';
import 'dart:ui' as ui;

import 'package:days/core/assets/illustration_assets.dart';
import 'package:flutter/services.dart';

class ImageCacheService {
  static final Map<String, ui.Image> _cache = {};
  static bool _preloaded = false;

  static Future<void> precacheImages() async {
    if (_preloaded) return;

    final imageFutures = IllustrationAssets.illustrations.map((path) async {
      try {
        final data = await rootBundle.load(path);
        final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
        final frame = await codec.getNextFrame();
        return MapEntry(path, frame.image);
      } catch (e) {
        // Handle cases where an image might fail to load
        print('Failed to load image: $path, error: $e');
        return null;
      }
    });

    final results = await Future.wait(imageFutures);
    for (final result in results) {
      if (result != null) {
        _cache[result.key] = result.value;
      }
    }
    _preloaded = true;
  }

  static ui.Image? getImage(String path) {
    return _cache[path];
  }

  static ui.Image? getRandomImage() {
    if (_cache.isEmpty) return null;
    final randomIndex = Random().nextInt(_cache.length);
    final randomKey = _cache.keys.elementAt(randomIndex);
    return _cache[randomKey];
  }
}
