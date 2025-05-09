import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notereader/controller/homepage.controller.dart';
import 'package:notereader/view/detailPage/favoritesDetail.page.dart';
import 'package:notereader/view/globalWidget/vertical_Listing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomepageController controller = Get.put(HomepageController());
  Timer? _debounce;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchList();
    });

    super.initState();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    controller.isArticleListLoading.value = true;
    _debounce = Timer(const Duration(milliseconds: 800), () {
      if (controller.searchController.text.trim().isNotEmpty) {
        controller.filterItems();
      } else {
        controller.searchController.clear();
        controller.isSearchEnable.value = false;
        controller.isArticleListLoading.value = false;
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const FavoritesPage());
        },
        tooltip: 'View Favorites',
        backgroundColor: Colors.grey,
        child: const Icon(Icons.favorite, color: Colors.black54),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Article Reader'),
        backgroundColor: Colors.white60,
        surfaceTintColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshItems,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            searchBarWidget(),
            listingWidget(
              VerticalListing(title: 'Latest Article'),
              controller.isArticleListLoading,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
          ],
        ),
      ),
    );
  }

  Widget searchBarWidget() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 6, right: 6),
        child: TextFormField(
          onChanged: _onSearchChanged,
          controller: controller.searchController,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white60),
            prefixIcon: const Icon(Icons.search, color: Colors.white60),
            suffixIcon: Obx(
              () =>
                  controller.isSearchEnable.value
                      ? InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          controller.searchController.clear();
                          controller.filterItems();
                          controller.isSearchEnable.value = false;
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white70,
                          size: 30,
                        ),
                      )
                      : SizedBox.shrink(),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white60),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }

  Widget listingWidget(Widget listWidget, RxBool isLoading) {
    return SliverToBoxAdapter(
      child: Obx(
        () => Skeletonizer(enabled: isLoading.value, child: listWidget),
      ),
    );
  }
}
