import 'package:flutter/foundation.dart';

class Categories with ChangeNotifier {
  List<String> _categories = [
    'Characters',
    'Episodes',
    'Locations',
  ];
  Map<String, int> _pages = {
    'Characters': 1,
    'Episodes': 1,
    'Locations': 1,
  };
  Map<String, int> _maxPages = {
    'Characters': 2,
    'Episodes': 2,
    'Locations': 2,
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
