import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notereader/controller/homepage.controller.dart';
import 'package:notereader/view/globalWidget/vertical_Listing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  HomepageController controller = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favorites Article'),
        backgroundColor: Colors.white60,
        surfaceTintColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshItems,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            listingWidget(
              VerticalListing(title: '', isFromFav: true),
              controller.isArticleListLoading,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
          ],
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
