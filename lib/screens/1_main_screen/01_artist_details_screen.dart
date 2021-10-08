import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:last_fm_challenge/0_api/model/artist.dart';
import 'package:last_fm_challenge/shared_widgets/base_background_widget.dart';
import 'package:last_fm_challenge/shared_widgets/text_widget.dart';
import 'package:last_fm_challenge/utilities/colors.dart';
import 'package:last_fm_challenge/utilities/fonts.dart';
import 'package:last_fm_challenge/utilities/sizes.dart';

class ArtistDetailsScreenParams {
  Artist artist;

  ArtistDetailsScreenParams({this.artist});
}

class ArtistDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ArtistDetailsScreenParams screenParams = ModalRoute.of(context).settings.arguments;
    return BaseBackgroundWidget(
      title: tr('artistDetailsScreen.title'),
      child: ListView(
        children: [
          _artistImage(screenParams),
          Padding(
            padding: EdgeInsets.all(Sizes.padding.standard),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _fieldItem(fieldName: tr('artistDetailsScreen.artistName'), fieldValue: screenParams.artist.name),
                SizedBox(height: Sizes.padding.standard),
                _fieldItem(fieldName: tr('artistDetailsScreen.noOfListeners'), fieldValue: screenParams.artist.listeners),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _fieldItem({String fieldName, String fieldValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          fieldName,
          color: ThemeColors.text.secondary,
          size: ThemeFonts.size.listTileTitle,
          weight: FontWeight.w900,
        ),
        TextWidget(
          fieldValue,
          color: ThemeColors.text.secondaryLight,
          size: ThemeFonts.size.listTileTitle,
          weight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _artistImage(ArtistDetailsScreenParams screenParams) {
    return Image.network(
      screenParams.artist.images.first.url,
      width: Sizes.listTile.standardHeight - Sizes.padding.standard,
    );
  }
}
