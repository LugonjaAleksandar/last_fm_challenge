// ignore: import_of_legacy_library_into_null_safe
import 'package:last_fm_challenge/0_api/model/pagination/paginated_response.dart';
import 'package:last_fm_challenge/0_api/services/artist_service.dart';
import 'package:last_fm_challenge/0_api/services/base_service.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ArtistModel on Model {
  List _artists;
  bool _initialArtistDataLoaded = false;
  int _currentPage = -1;
  bool _hasMoreData = true;

  List get artists => _artists != null ? List.from(_artists) : null;
  bool get initialArtistDataLoaded => _initialArtistDataLoaded;
  int get currentPage => _currentPage;
  bool get hasMoreData => _hasMoreData;

  void clearArtistModel() {
    _artists = null;
    _initialArtistDataLoaded = false;
    _currentPage = -1;
  }

  void updateStateWithArtists({PaginatedResponse paginatedResponse}) {
    _artists = paginatedResponse.dataList;
    _initialArtistDataLoaded = true;
    notifyListeners();
  }

  void loadFirstPageOfData(String searchText) async {
    _currentPage = 1;
    ApiResponse response = await ArtistService().artistsSearch(_currentPage, searchText);
    updateStateWithArtists(paginatedResponse: response.responseObject);
  }

  void loadNextPageOfData(String searchText) async {
    if (_currentPage > 1 && _hasMoreData == false) {
      notifyListeners();
      return;
    }

    _currentPage = _currentPage + 1;
    ApiResponse response = await ArtistService().artistsSearch(_currentPage, searchText);
    PaginatedResponse paginatedResponse = response.responseObject;
    _hasMoreData = !paginatedResponse.isLastPage;

    if (paginatedResponse.currentPage == 1) {
      _artists = paginatedResponse.dataList;
    } else {
      _artists.addAll(paginatedResponse.dataList);
    }
    
    _initialArtistDataLoaded = true;
    notifyListeners();
  }
}
