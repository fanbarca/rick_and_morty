import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tashcommerce/api_models/characters.dart';
import 'package:tashcommerce/api_models/episodes.dart';
import 'package:tashcommerce/api_models/locations.dart';

final categoriesProvider =
    ChangeNotifierProvider<Categories>((ref) => Categories());

class Categories with ChangeNotifier {
  List<String> _categories = [
    (Characters).toString(),
    (Episodes).toString(),
    (Locations).toString(),
  ];
  // List<dynamic> _categoryTypes = [
  //   Characters(),
  //   Episodes(),
  //   Locations(),
  // ];
  Map<String, int> _pages = {
    (Characters).toString(): 1,
    (Episodes).toString(): 1,
    (Locations).toString(): 1,
  };
  Map<String, double> _offsets = {
    (Characters).toString(): 0.0,
    (Episodes).toString(): 0.0,
    (Locations).toString(): 0.0,
  };
  setCurrentCategoryPageOffset(double offset) {
    _offsets[currentCategory] = offset;
    // notifyListeners();
  }

  double get currentCategoryOffset {
    return _offsets[currentCategory];
  }

  // int page(String cat) {
  //   return _pages[cat];
  // }

  Map<String, int> _maxPages = {
    (Characters).toString(): 2,
    (Episodes).toString(): 2,
    (Locations).toString(): 2,
  };

  int _index = 0;

  int get currentIndex {
    return _index;
  }

  setIndex(int index) {
    if (_index != index) {
      _index = index;
      notifyListeners();
    }
  }

  String get currentCategory {
    return _categories[_index];
  }

  int get categoriesCount {
    return _categories.length;
  }

  List<String> get categories {
    return _categories;
  }

  int get currentCategoryPage {
    return _pages[currentCategory];
  }

  int get currentCategoryMaxPages {
    return _maxPages[currentCategory];
  }

  incrementCurrentCategoryPage() {
    if (currentCategoryPage < currentCategoryMaxPages) {
      _pages[currentCategory]++;
      notifyListeners();
    }
  }

  decrementCurrentCategoryPage() {
    if (currentCategoryPage > 0) {
      _pages[currentCategory]--;
      notifyListeners();
    }
  }

  setCurrentCategoryMaxPages(int total) {
    _maxPages[currentCategory] = int.parse(total.toString());
    //notifyListeners();
  }

  addCategory(String cat) {
    _categories.add(cat);
    notifyListeners();
  }

  setCurrentCategoryPage(int page) {
    _pages[currentCategory] = int.parse(page.toString());
    notifyListeners();
  }

  jumpToLastPage() {
    _pages[currentCategory] = _maxPages[currentCategory];
    notifyListeners();
  }
}
