class PaginatedResponse {
  int totalResources;
  int currentPage;
  int size;
  bool isLastPage;
  List dataList;

  PaginatedResponse({
    this.totalResources,
    this.currentPage,
    this.size,
    this.isLastPage,
    this.dataList,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json, Function dataConstructor) {
    Map<String, dynamic> results = json['results'];
    int currentPage = int.parse(results['opensearch:startIndex']) ~/ int.parse(results['opensearch:itemsPerPage']);
    int totalResources = int.parse(results['opensearch:totalResults']);
    int size = int.parse(results['opensearch:itemsPerPage']);
    bool isLastPage = (totalResources / currentPage + 1) < size;

    return PaginatedResponse(
      totalResources: totalResources,
      currentPage: currentPage,
      size: size,
      isLastPage: isLastPage,
      dataList: List.generate(results['artistmatches']['artist'].length, (i) => dataConstructor(results['artistmatches']['artist'][i])),
    );
  }
}
