import 'package:flutter/material.dart';
import 'package:last_fm_challenge/1_navigation/route_names.dart';
import 'package:last_fm_challenge/screens/1_main_screen/00_artists_screen.dart';
import 'package:last_fm_challenge/screens/1_main_screen/01_artist_details_screen.dart';

class RouteConfigurator {
  static Map<String, WidgetBuilder> allAppRoutesList(BuildContext context) {
    return {
      RouteNames.main: (BuildContext context) => ArtistsScreen(),
      RouteNames.artistDetails: (BuildContext context) => ArtistDetailsScreen(),
    };
  }
}
