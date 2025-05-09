import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notereader/controller/homepage.controller.dart';
import 'package:notereader/model/item.model.dart';
import 'package:notereader/view/detailPage/articleDetail.page.dart';

class Articlecard extends StatelessWidget {
  Articlecard({super.key, required this.data});
  HomepageController controller = Get.put(HomepageController());
  Item? data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(Articledetails(itemData: data)),
      child: Container(
        height: 80,
        width: double.infinity,
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 2, color: Colors.black45),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                data?.title ?? 'Text',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            SizedBox(width: 16),
            IconButton(
              icon: Icon(
                data?.isFav ?? false ? Icons.favorite : Icons.favorite_border,
                color: data?.isFav ?? false ? Colors.black45 : null,
              ),
              onPressed: () => {controller.toggleFavorite(data ?? Item())},
            ),
          ],
        ),
      ),
    );
  }
}
