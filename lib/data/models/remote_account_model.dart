import '../../domain/entities/entities.dart';
import '../http/http.dart';

class RemoteAcoountModel {
  final String accessToken;

  RemoteAcoountModel(this.accessToken);

  factory RemoteAcoountModel.fromJson(Map json) {
    if(!json.containsKey('accessToken')){
      throw HttpError.invalidData;
    }
    return RemoteAcoountModel(json['accessToken']);
  }
      

  AccountEntity toEntity() => AccountEntity(accessToken);
}
