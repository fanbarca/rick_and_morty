import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tashcommerce/providers/categories.dart';

import 'page_button.dart';

class Pagination extends StatefulWidget {
  const Pagination({
    Key key,
  }) : super(key: key);

  @override
  _PaginationState createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  ScrollController _scrollController;
  Categories categories;

  @override
  void initState() {
    super.initState();
    // categories = ProviderContainer().read(categoriesProvider);
  }

  void _scroll() {
    categories.setCurrentCategoryPageOffset(_scrollController.position.pixels);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      categories = watch(categoriesProvider);
      _scrollController = ScrollController(
        keepScrollOffset: true,
        initialScrollOffset: categories.currentCategoryOffset,
      )..addListener(_scroll);
      return Container(
        height: 95,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 25),
              ...List.generate(
                categories.currentCategoryMaxPages,
                (index) => PageButton(
                  onTap: index + 1 != categories.currentCategoryPage
                      ? () {
                          Navigator.of(context).pop();
                          context
                              .read(categoriesProvider)
                              .setCurrentCategoryPage(index + 1);
                        }
                      : null,
                  label: '${index + 1}',
                  isActive: index + 1 == categories.currentCategoryPage,
                ),
              ),
              SizedBox(width: 25)
            ],
          ),
        ),
      );
    });
  }
}
