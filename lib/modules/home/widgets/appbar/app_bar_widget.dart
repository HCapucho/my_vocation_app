import 'package:flutter/material.dart';
import 'package:my_vocation_app/core/core.dart';

class AppBarWidget extends PreferredSize {
  final String username;
  AppBarWidget({super.key, required this.username})
      : super(
          preferredSize: const Size.fromHeight(150),
          child: SizedBox(
            height: 150,
            child: Container(
              height: 161,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              width: double.maxFinite,
              decoration: BoxDecoration(gradient: AppGradients.linear),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Olá, ",
                      style: AppTextStyles.title,
                      children: [
                        TextSpan(
                          text: username,
                          style: AppTextStyles.titleBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
