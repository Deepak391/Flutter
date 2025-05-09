import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notereader/api/api_client.dart';
import 'package:notereader/model/item.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomepageController extends GetxController {
  RxBool isArticleListLoading = false.obs;
  RxList<Item>? articleList = <Item>[].obs;
  RxList<Item>? filteredItems = <Item>[].obs;
  RxBool isSearchEnable = false.obs;
  TextEditingController searchController = TextEditingController();
  RxList<Item>? favItemsList = <Item>[].obs;

  void filterItems() {
    if (searchController.text.isEmpty) {
      filteredItems?.assignAll(articleList ?? []);
      isSearchEnable.value = false;
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        filteredItems?.value =
            articleList!
                .where(
                  (item) => item.title!.toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  ),
                )
                .toList();
        isArticleListLoading.value = false;
      });

      isSearchEnable.value = true;
    }
  }

  Future<void> fetchList() async {
    try {
      isArticleListLoading.value = true;
      final res = await ApiService.fetchArticleList();
      filteredItems?.value = res;
      articleList?.clear();
      articleList?.value = res;
      final prefs = await SharedPreferences.getInstance();
      final favoriteIds = prefs.getStringList('favorite_ids') ?? [];

      for (var item in filteredItems!) {
        item.isFav = favoriteIds.contains(item.id.toString());
      }
      favItemsList?.clear();
      for (var item in filteredItems!) {
        if (item.isFav ?? false) {
          favItemsList?.add(item);
        }
      }

      isArticleListLoading.value = false;
    } catch (e) {
      isArticleListLoading.value = false;
      print('Error $e');
    }
  }

  Future<void> refreshItems() async {
    await Future.delayed(const Duration(seconds: 2));
    fetchList();
    filterItems();
  }

  void toggleFavorite(Item item) async {
    item.isFav = !(item.isFav ?? false);
    articleList?.refresh();
    filteredItems?.refresh();
    if (item.isFav ?? false) {
      favItemsList?.add(item);
    } else {
      favItemsList?.remove(item);
    }
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds =
        favItemsList?.map((item) => item.id.toString()).toList();
    await prefs.setStringList('favorite_ids', favoriteIds ?? []);
  }
}
