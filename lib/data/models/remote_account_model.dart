import 'package:curso_tdd/domain/entities/account_entity.dart';

class RemoteAcoountModel {
  final String accessToken;

  RemoteAcoountModel(this.accessToken);

  factory RemoteAcoountModel.fromJson(Map json) =>
      RemoteAcoountModel(json['accessToken']);

  AccountEntity toEntity() => AccountEntity(accessToken);
}
