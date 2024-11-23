import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class ImgAuth extends StatelessWidget {
  const ImgAuth({
    super.key,
    imgAuth,
  }) : imgUrlBase = imgAuth ?? AppContants.imgBackgroundLogin;
  final String imgUrlBase;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        imgUrlBase,
        fit: BoxFit.cover,
      ),
    );
  }
}
