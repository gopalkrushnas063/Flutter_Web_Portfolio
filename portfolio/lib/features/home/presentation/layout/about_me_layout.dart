import 'package:flutter/material.dart';
import 'package:portfolio/core/presentation/constant/gap_constant.dart';
import 'package:portfolio/core/presentation/extensions/build_context_extension.dart';
import 'package:portfolio/core/presentation/extensions/responsive_extension.dart';
import 'package:portfolio/features/home/data/model/home_about_me_response_model.dart';
import 'package:portfolio/features/home/presentation/widget/home_background.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/presentation/widget/image_loader.dart';
import '../widget/chip_widget.dart';

class AboutMeLayout extends StatelessWidget {
  final HomeAboutMeResponseModel aboutMe;

  const AboutMeLayout({
    super.key,
    required this.aboutMe,
  });

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      isGrey: true,
      child: Column(
        children: [
          const ChipWidget(text: 'About Me'),
          GapConstant.h48,
          ResponsiveRowColumn(
            columnMainAxisAlignment: MainAxisAlignment.center,
            columnSpacing: 32,
            rowSpacing: 32,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            rowCrossAxisAlignment: CrossAxisAlignment.start,
            layout: context.isDisplayLargeThanTablet
                ? ResponsiveRowColumnType.ROW
                : ResponsiveRowColumnType.COLUMN,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _pictureLayout(context),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _descriptionLayout(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _descriptionLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          aboutMe.title,
          style: context.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.justify,
          textScaleFactor: context.titleScaleFactor,
        ),
        GapConstant.h16,
        Text(
          aboutMe.description,
          textAlign: TextAlign.justify,
          style: context.bodyMedium,
        )
      ],
    );
  }

  Widget _pictureLayout(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: context.isDisplayLargeThanTablet ? 500 : 300,
      ),
      child: ImageLoader(
        aboutMe.image,
        height: 400,
      ),
    );
  }
}
