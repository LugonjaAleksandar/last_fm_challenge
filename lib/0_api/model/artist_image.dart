class ArtistImage {
  String url;
  String size;

  ArtistImage({
    this.url,
    this.size,
  });

  factory ArtistImage.fromJson(Map<String, dynamic> json) => ArtistImage(
        url: json['#text'],
        size: json['size'],
      );
}
