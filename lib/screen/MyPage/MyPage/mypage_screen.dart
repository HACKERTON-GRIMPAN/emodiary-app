import 'package:emodiary/screen/MyPage/MyPage/Widget/mypage_has_data_screen.dart';
import 'package:emodiary/screen/MyPage/MyPage/Widget/mypage_has_not_data_screen.dart';
import 'package:emodiary/screen/MyPage/MyPage/Widget/mypage_menu_row.dart';
import 'package:emodiary/screen/MyPage/MyPage/Widget/withdrawal_confirm_dialog.dart';
import 'package:emodiary/util/function/log_on_dev.dart';
import 'package:emodiary/viewModel/MyPage/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  final UserViewModel userViewModel = Get.put(UserViewModel());

  bool isLoading = false;

  void getUserInfo() {
    setState(() {
      isLoading = true;
    });

    userViewModel.getUserInfo().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : userViewModel.userModel.value == null
                  ? MyPageHasNotDataScreen(
                      onPressRetry: getUserInfo,
                    )
                  : MyPageHasDataScreen(
                      userModel: userViewModel.userModel.value!,
                    ),
        ),
      ),
    );
  }
}
