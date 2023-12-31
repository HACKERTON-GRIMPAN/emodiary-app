import 'package:emodiary/screen/SignUp/Identify/Widget/already_signup_bottom_sheet.dart';
import 'package:emodiary/util/class/tel_formatter.dart';
import 'package:emodiary/viewModel/SignUp/signup_view_model.dart';
import 'package:emodiary/widget/base/common_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpIdentifyScreen extends StatefulWidget {
  final void Function() gotoNext;
  final SignUpViewModel viewModel;

  const SignUpIdentifyScreen({
    super.key,
    required this.gotoNext,
    required this.viewModel,
  });

  @override
  State<SignUpIdentifyScreen> createState() => _SignUpIdentifyScreenState();
}

class _SignUpIdentifyScreenState extends State<SignUpIdentifyScreen> {
  static const int nickNameMinLength = 4;
  static const int nickNameMaxLength = 10;
  static const int telMaxLength = 13;

  late TextEditingController _nickNameCtrl;
  late TextEditingController _telCtrl;
  bool isNotEmpty = false;

  @override
  void initState() {
    super.initState();
    _nickNameCtrl = TextEditingController();
    _telCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _nickNameCtrl.dispose();
    _telCtrl.dispose();
    super.dispose();
  }

  bool canSend() {
    return _nickNameCtrl.text.length >= nickNameMinLength &&
        _telCtrl.text.isNotEmpty;
  }

  void showAlreadySignUpBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const AlreadySignUpBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "회원여부 확인 및 가입을 진행합니다.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
              ),
              const SizedBox(
                height: 76,
              ),
              const Text(
                "닉네임",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              TextField(
                controller: _nickNameCtrl,
                onChanged: (value) {
                  setState(() {});
                },
                maxLength: nickNameMaxLength,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  hintText: '닉네임 입력 (4~10자)',
                  hintStyle: const TextStyle(
                    color: Color(0xFFCCD1D9),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 20,
                    minWidth: 20,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: _nickNameCtrl.clear,
                    child: SvgPicture.asset(
                      "assets/icons/clear.svg",
                      width: 20,
                      height: 20,
                    ),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 13.0,
                    horizontal: 0.0,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE6E9ED),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE6E9ED),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "휴대폰번호",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              TextField(
                controller: _telCtrl,
                inputFormatters: [
                  TelFormatter(masks: ["xxx-xxxx-xxxx"], separator: "-"),
                ],
                onChanged: (_) {
                  setState(() {});
                },
                maxLength: telMaxLength,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  hintText: '휴대폰번호 입력 (xxx-xxxx-xxxx)',
                  hintStyle: const TextStyle(
                    color: Color(0xFFCCD1D9),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 20,
                    minWidth: 20,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: _telCtrl.clear,
                    child: SvgPicture.asset(
                      "assets/icons/clear.svg",
                      width: 20,
                      height: 20,
                    ),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 13.0,
                    horizontal: 0.0,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE6E9ED),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE6E9ED),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CommonBottomButton(
                  text: "다음",
                  disabledText: "닉네임과 휴대폰 번호를 입력해주세요!",
                  onPressed: canSend()
                      ? () {
                          widget.viewModel.setNickname(_nickNameCtrl.text);
                          widget.viewModel.setPhoneNumber(_telCtrl.text);
                          widget.gotoNext();
                        }
                      : null,
                  // onPressed: showAlreadySignUpBottomSheet,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
