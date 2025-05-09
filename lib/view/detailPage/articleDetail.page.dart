import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notereader/model/item.model.dart';
import 'package:notereader/view/detailPage/favoritesDetail.page.dart';

class Articledetails extends StatelessWidget {
  Articledetails({super.key, required this.itemData});
  Item? itemData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${itemData?.isFav ?? false ? '🖤' : ''} Article ${itemData?.isFav ?? false ? '🖤' : ''}',
        ),
        backgroundColor: Colors.white60,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
              child: Text(
                itemData?.title ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
              child: Text(
                itemData?.body ?? '',
                softWrap: true,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
