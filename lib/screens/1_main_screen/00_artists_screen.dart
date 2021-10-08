import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:last_fm_challenge/0_api/model/artist.dart';
import 'package:last_fm_challenge/1_navigation/route_names.dart';
import 'package:last_fm_challenge/2_state_management/main_scoped_model.dart';
import 'package:last_fm_challenge/screens/1_main_screen/01_artist_details_screen.dart';
import 'package:last_fm_challenge/screens/1_main_screen/widgets/artist_list_tile.dart';
import 'package:last_fm_challenge/shared_widgets/base_background_widget.dart';
import 'package:last_fm_challenge/shared_widgets/image_widget.dart';
import 'package:last_fm_challenge/shared_widgets/list_view_widget.dart';
import 'package:last_fm_challenge/utilities/fonts.dart';
import 'package:last_fm_challenge/utilities/scoped_model_utils.dart';
import 'package:scoped_model/scoped_model.dart';

class ArtistsScreen extends StatefulWidget {
  @override
  State createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  String _searchText = 'a';

  @override
  void initState() {
    super.initState();
    ScopedModelUtils().model.loadFirstPageOfData(_searchText);
  }

  @override
  Widget build(BuildContext context) {
    return BaseBackgroundWidget(
      titleWidget: Hero(
        tag: 'appLogo',
        child: ImageWidget(
          ImageUrls.logo,
          height: 70,
        ),
      ),
      hideBackButton: true,
      child: ScopedModelDescendant<MainModel>(
        builder: (_, __, MainModel model) {
          if (model.initialArtistDataLoaded == true && model.artists == null) {
            // Rewrite this and display propper "no data element"
            return Container();
          } else {
            return Column(
              children: [
                TextField(
                  onChanged: (changedText) => _onSearchTextChanged(changedText),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: tr('artistListScreen.searchText'),
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: ThemeFonts.size.textFieldText,
                    ),
                  ),
                ),
                Expanded(
                  child: ListViewWidget(
                    pullToRefreshEnabled: true,
                    shouldShowEmptyListIndicator: model.initialArtistDataLoaded == false,
                    onRefresh: () => _onSearchTextChanged(_searchText),
                    itemCount: model.artists?.length,
                    hasMoreData: model.hasMoreData,
                    listItemForIndex: (index) {
                      return ArtistListTile(
                        artist: model.artists[index],
                        onPressed: _openArtistDetails,
                      );
                    },
                    shouldShowSeparatorForIndex: (index) => true,
                    nextPageLoadingEnabled: true,
                    didReachEnd: _listDidReachScrollingEnd,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _listDidReachScrollingEnd() async {
    ScopedModelUtils().model.loadNextPageOfData(_searchText);
  }

  void _onSearchTextChanged(String text) {
    _searchText = text;
    if (_searchText.length == 0)  _searchText = 'a';
    ScopedModelUtils().model.loadFirstPageOfData(_searchText);
  }

  void _openArtistDetails({Artist artist}) {
    Navigator.pushNamed(
      context,
      RouteNames.artistDetails,
      arguments: ArtistDetailsScreenParams(artist: artist),
    );
  }
}
