import 'package:last_fm_challenge/2_state_management/artist_scoped_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with ArtistModel {
  void clearMainModel() {
    this.clearArtistModel();
    
    notifyListeners();
  }
}
