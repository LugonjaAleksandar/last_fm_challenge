
import 'package:last_fm_challenge/2_state_management/main_scoped_model.dart';

class ScopedModelUtils {
  static final ScopedModelUtils _instance =
      ScopedModelUtils._privateConstructor();
  MainModel _mainModel;

  factory ScopedModelUtils() => _instance;

  ScopedModelUtils._privateConstructor();

  void setModel(MainModel model) => _mainModel = model;
  MainModel get model => _mainModel;
}
