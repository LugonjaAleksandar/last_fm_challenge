import 'package:last_fm_challenge/0_api/model/artist_image.dart';

class Artist {
  String name;
  String listeners;
  String mbid;
  String url;
  String streamable;
  List<ArtistImage> images;

  Artist({
    this.name,
    this.listeners,
    this.mbid,
    this.url,
    this.streamable,
    this.images,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    List images = json['image'];
    return Artist(
      name: json['name'],
      listeners: json['listeners'],
      mbid: json['mbid'],
      url: json['url'],
      streamable: json['streamable'],
      images: List.generate(images.length, (i) => ArtistImage.fromJson(images[i])),
    );
  }
}
