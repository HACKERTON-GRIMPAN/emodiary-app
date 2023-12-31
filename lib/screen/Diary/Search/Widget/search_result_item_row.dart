import 'package:cached_network_image/cached_network_image.dart';
import 'package:emodiary/model/Diary/diary_search_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchResultItemRow extends StatelessWidget {
  final DiarySearchItemModel model;

  const SearchResultItemRow({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 1,
            spreadRadius: 0,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          Get.toNamed("/diary", arguments: {"id": model.id});
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFFE8DCFF),
          splashFactory: NoSplash.splashFactory,
          padding: const EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFF656D78),
              ),
              child: CachedNetworkImage(
                placeholder: (context, url) {
                  return Container();
                },
                errorWidget: (context, url, error) {
                  return Container();
                },
                imageUrl:
                    '${dotenv.env["SERVER_HOST"]}/images/${model.imageUrl}',
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                Text(
                  DateFormat("yyyy년 MM월 dd일").format(model.createdDate),
                  style: const TextStyle(
                    color: Color(0xFF434A54),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
