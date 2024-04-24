import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myportfolio/core/presentation/extensions/build_context_extension.dart';
import 'package:myportfolio/core/presentation/extensions/date_extension.dart';
import 'package:myportfolio/core/presentation/extensions/responsive_extension.dart';
import 'package:myportfolio/features/home/data/model/home_experiences_item_response_model.dart';
import 'package:myportfolio/features/home/data/model/home_experiences_response_model.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/presentation/constant/gap_constant.dart';
import '../../../../core/presentation/widget/image_loader.dart';
import '../widget/chip_widget.dart';
import '../widget/home_background.dart';

class ExperiencesLayout extends StatelessWidget {
  final HomeExperiencesResponseModel experiences;

  const ExperiencesLayout({
    super.key,
    required this.experiences,
  });

  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      child: Column(
        children: [
          const ChipWidget(
            text: 'Experience',
          ),
          GapConstant.h24,
          Text(
            experiences.text,
            style: context.bodyLarge,
            textAlign: TextAlign.center,
          ),
          GapConstant.h16,
          _listExperiences(context),
        ],
      ),
    );
  }

  Widget _listExperiences(BuildContext context) {
    return Column(
      children: experiences.items
          .mapIndexed(
            (i, e) => _ExperienceItem(
              item: e,
              isEven: i % 2 == 0,
            ),
          )
          .toList(),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final HomeExperiencesItemResponseModel item;
  final bool isEven;

  const _ExperienceItem({
    required this.item,
    required this.isEven,
  });

  @override
  Widget build(BuildContext context) {
    var isRow = context.isDisplayLargeThanTablet;

    return Container(
      margin: const EdgeInsets.only(top: 32),
      decoration: context.radiusBorderDecoration,
      child: ResponsiveRowColumn(
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        layout: isRow ? ResponsiveRowColumnType.ROW : ResponsiveRowColumnType.COLUMN,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            rowOrder: isEven ? 1 : 2,
            child: _logoLayout(context, !isRow),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            rowOrder: !isEven ? 1 : 2,
            child: _textAndDateLayout(context),
          ),
        ],
      ),
    );
  }

  Widget _logoLayout(BuildContext context, bool isColumn) {
    const radius = Radius.circular(12);
    const radiusZero = Radius.zero;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: isColumn
              ? radius
              : isEven
                  ? radius
                  : radiusZero,
          bottomLeft: isColumn
              ? radiusZero
              : isEven
                  ? radius
                  : radiusZero,
          topRight: isColumn
              ? radius
              : !isEven
                  ? radius
                  : radiusZero,
          bottomRight: isColumn
              ? radiusZero
              : !isEven
                  ? radius
                  : radiusZero,
        ),
        // color: context.colorScheme.onInverseSurface,
      ),
      padding: const EdgeInsets.all(32),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: !isColumn ? 100 : 340,
          minWidth: context.screenWidth,
        ),
        child: ImageLoader(
          item.logo,
          height: context.isDisplayLargeThanTablet ? null : 68,
        ),
      ),
    );
  }

  Widget _textAndDateLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: context.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textScaleFactor: context.titleScaleFactor,
          ),
          GapConstant.h24,
          Text(
            item.description,
            style: context.bodyMedium,
            textAlign: TextAlign.justify,
          ),
          GapConstant.h32,
          _dateLayout(context),
        ],
      ),
    );
  }

  Widget _dateLayout(BuildContext context) {
    var outputFormat = 'MMM yyyy';

    return Text(
      '${item.startDate.formatDate(outputFormat: outputFormat)} - ${item.endDate?.formatDate(outputFormat: outputFormat) ?? 'Present'}',
      style: context.bodyMedium,
    );
  }
}
