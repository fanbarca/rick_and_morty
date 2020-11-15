import 'package:flutter/foundation.dart';
import 'package:tashcommerce/api/characters.dart';
import 'package:tashcommerce/api/episodes.dart';
import 'package:tashcommerce/api/locations.dart';

class Categories with ChangeNotifier {
  List<String> _categories = [
    (Characters).toString(),
    (Episodes).toString(),
    (Locations).toString(),
  ];
  Map<String, int> _pages = {
    (Characters).toString(): 1,
    (Episodes).toString(): 1,
    (Locations).toString(): 1,
  };

  int page(String cat) {
    return _pages[cat];
  }

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
    _index = index;
    notifyListeners();
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
    _pages[currentCategory]++;
    notifyListeners();
  }

  decrementCurrentCategoryPage() {
    _pages[currentCategory]--;
    notifyListeners();
  }

  setCurrentCategoryMaxPages(int total) {
    _maxPages[currentCategory] = int.parse(total.toString());
    //notifyListeners();
  }

  addCategory(String cat) {
    _categories.add(cat);
    notifyListeners();
  }
}
