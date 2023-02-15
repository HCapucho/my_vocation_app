import 'package:flutter/material.dart';
import 'package:my_vocation_app/core/core.dart';
import 'package:my_vocation_app/models/user_model.dart';
import 'package:my_vocation_app/modules/home/widgets/score_card/score_card_widget.dart';
import 'package:my_vocation_app/modules/login/domain/models/usuario.dart';

class AppBarWidget extends PreferredSize {
  final String username;
  AppBarWidget({super.key, required this.username})
      : super(
          preferredSize: const Size.fromHeight(250),
          child: SizedBox(
            height: 250,
            child: Stack(
              children: [
                Container(
                  height: 161,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                Align(
                  alignment: Alignment(0.0, 1.0),
                  child: ScoreCardWidget(percent: 60 / 100),
                ),
              ],
            ),
          ),
        );
}
