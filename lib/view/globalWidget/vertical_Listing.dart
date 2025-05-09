import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notereader/controller/homepage.controller.dart';
import 'package:notereader/model/item.model.dart';
import 'package:notereader/view/globalWidget/articleCard.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VerticalListing extends StatelessWidget {
  VerticalListing({super.key, this.isFromFav = false, required this.title});

  String title;
  bool isFromFav;
  HomepageController homeController = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (homeController.isSearchEnable.value || (isFromFav ?? false))
              ? SizedBox.shrink()
              : titleHeader(title),
          const SizedBox(height: 6),
          articleCardListing(),
        ],
      ),
    );
  }

  Widget titleHeader(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white70,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget articleCardListing() {
    return homeController.isArticleListLoading.value
        ? ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Articlecard(
              data: Item(
                title: 'Sample Text',
                id: 1,
                body: 'Sample Text',
                userId: 1,
              ),
            );
          },
        )
        : homeController.filteredItems!.isEmpty
        ? Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Text(
              'No Article Found',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
        )
        : isFromFav && homeController.favItemsList!.isEmpty
        ? Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Text(
              'No Favorite Article Found',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
        )
        : ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              isFromFav
                  ? homeController.favItemsList?.length
                  : homeController.filteredItems?.length,
          itemBuilder: (context, index) {
            return isFromFav
                ? Articlecard(data: homeController.favItemsList?[index])
                : Articlecard(data: homeController.filteredItems?[index]);
          },
        );
  }
}
