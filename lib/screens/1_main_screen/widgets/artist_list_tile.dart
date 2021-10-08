import 'package:flutter/material.dart';
import 'package:last_fm_challenge/0_api/model/artist.dart';
import 'package:last_fm_challenge/shared_widgets/text_widget.dart';
import 'package:last_fm_challenge/utilities/colors.dart';
import 'package:last_fm_challenge/utilities/fonts.dart';
import 'package:last_fm_challenge/utilities/sizes.dart';

class ArtistListTile extends StatelessWidget {
  final Artist artist;
  final Function({Artist artist}) onPressed;

  ArtistListTile({
    this.artist,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.listTile.standardHeight,
      child: ListTile(
        contentPadding: EdgeInsets.only(
          left: Sizes.padding.standard,
          right: Sizes.padding.standard,
          bottom: Sizes.padding.small,
        ),
        onTap: () => this.onPressed(artist: this.artist),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _artistImage(),
            SizedBox(height: Sizes.padding.small),
            _artistName(),
          ],
        ),
      ),
    );
  }

  Widget _artistName() {
    return Expanded(
      child: TextWidget(
        this.artist.name,
        color: ThemeColors.text.secondary,
        size: ThemeFonts.size.listTileTitle,
        weight: FontWeight.bold,
      ),
    );
  }

  Widget _artistImage() {
    if (this.artist.images == null || this.artist.images.first == null || this.artist.images.first.url.length == 0) {
      return SizedBox(width: Sizes.listTile.standardHeight - Sizes.padding.standard,);
    }
    return Image.network(
      this.artist.images.first.url,
      width: Sizes.listTile.standardHeight - Sizes.padding.standard,
    );
  }
}
