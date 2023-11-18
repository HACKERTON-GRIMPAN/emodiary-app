import 'package:emodiary/screen/Diary/Writing/Widget/diary_title_field.dart';
import 'package:emodiary/screen/Diary/Writing/Widget/diary_writing_back_card.dart';
import 'package:emodiary/screen/Diary/Writing/Widget/diary_writing_card.dart';
import 'package:emodiary/viewModel/Diary/Writing/diary_writing_view_model.dart';
import 'package:emodiary/widget/Diary/diary_appbar.dart';
import 'package:emodiary/screen/Diary/Writing/Widget/diary_writing_bottom_button.dart';
import 'package:emodiary/widget/Diary/diary_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryWritingScreen extends StatefulWidget {
  const DiaryWritingScreen({super.key});

  @override
  State<DiaryWritingScreen> createState() => _DiaryWritingScreenState();
}

class _DiaryWritingScreenState extends State<DiaryWritingScreen> {
  final DiaryWritingViewModel vm = Get.put(DiaryWritingViewModel());

  @override
  void initState() {
    super.initState();
    vm.initTextController();
  }

  @override
  void dispose() {
    vm.disposeTextController();
    super.dispose();
  }

  void refresh(String _) {
    setState(() {});
  }

  void onTapBack() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
      builder: (BuildContext context) {
        return DiaryConfirmDialog(
          question: "일기를 그만 작성하시겠습니까?",
          cancel: "취소",
          confirm: "그만쓰기",
          cancelAction: () {
            Get.back();
          },
          confirmAction: () {
            Get.back();
            Get.back();
          },
        );
      },
    );
  }

  void onTapSend() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color.fromRGBO(98, 98, 114, 0.4),
      builder: (BuildContext context) {
        return DiaryConfirmDialog(
          question: "일기를 전송하시겠습니까?",
          cancel: "취소하기",
          confirm: "전송하기",
          cancelAction: () {
            Get.back();
          },
          confirmAction: () {
            Get.toNamed("/diary/loading");
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: DiaryAppBar(
              title: '2023.06',
              onPressed: onTapBack,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                DiaryTitleField(viewModel: vm),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        top: 40,
                        child: DiaryWritingBackCard(
                          viewModel: vm,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        bottom: 64,
                        child: DiaryWritingCard(
                          viewModel: vm,
                          refresh: refresh,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DiaryWritingBottomButton(
                        onPressed: vm.canSend() ? onTapSend : null,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
