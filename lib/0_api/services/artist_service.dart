import 'package:http/http.dart' as http;
import 'package:last_fm_challenge/0_api/communication_manager.dart';
import 'package:last_fm_challenge/0_api/endpoints.dart';
import 'package:last_fm_challenge/0_api/model/artist.dart';
import 'package:last_fm_challenge/0_api/services/base_service.dart';

class ArtistService extends BaseService {
  Future<ApiResponse> artistsSearch(int page, String searchString) async {
    final http.Response response = await CommunicationManager().executeAuthorizedGet(
      endpoint: urlWithParameters(
        endpoint: Endpoints.artistSearch,
        parameters: {
          'page': page.toString(),
          'artist': searchString,
        },
      ),
    );

    return handlePaginatedResponse(
      serverResponse: response,
      objectConstructor: (json) => Artist.fromJson(json),
    );
  }
}
