import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../http/http_client.dart';
import '../http/http_error.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  //Contrutor da classe RemoteAuthentication
  RemoteAuthentication({
    @required this.httpClient,
    @required this.url,
  });

  //aqui que passa os parametros para o teste.
  Future<AccountEntity> auth(AuthenticationParans parans) async {
    final body = RemoteAuthenticationParans.toDomain(parans).toJason();

    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: body);
      return AccountEntity.fromJson(httpResponse);
    } on HttpError catch (error) {
      throw error == HttpError.anauthorized
          ? DomainError.invalidCredencials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParans {
  final String email;
  final String password;

  RemoteAuthenticationParans({@required this.email, @required this.password});

  factory RemoteAuthenticationParans.toDomain(AuthenticationParans parans) =>
      RemoteAuthenticationParans(email: parans.email, password: parans.secret);

  Map toJason() => {'email': email, 'password': password};
}
