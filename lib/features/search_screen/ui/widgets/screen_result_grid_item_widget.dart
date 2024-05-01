import 'package:flutter/material.dart';
import 'package:search_task/core/base/base_widgets/base_stateless_widget.dart';
import 'package:search_task/core/base/lang/app_localization_keys.dart';
import 'package:search_task/core/design/colors_catalog.dart';
import 'package:search_task/features/search_screen/models/screen_result_response/screen_result_response.dart';

class ScreenResultGridItem extends BaseStatelessWidget {
  final ScreenResult? screenResult;

  ScreenResultGridItem({Key? key, this.screenResult}) : super();

  @override
  Widget baseBuild(BuildContext context) {
    return Card(
      color: ColorsCatalog().APP_LIGHT_GREY,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${translate(LangKeys.firstName)}: ${screenResult?.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Description: ${screenResult?.description}'),
            Text(
                '${translate(LangKeys.nationality)}: ${screenResult?.nationality}'),
            Text('Place of Birth: ${screenResult?.placeOfBirth}'),
            Text('Score: ${screenResult?.score}'),
          ],
        ),
      ),
    );
  }
}
