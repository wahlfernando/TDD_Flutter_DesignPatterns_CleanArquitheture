import 'package:curso_tdd/data/http/http_client.dart';
import 'package:curso_tdd/domain/usecases/authentication.dart';
import 'package:meta/meta.dart';


class RemoteAuthentication{
  final HttpClient httpClient;
  final String url;

  //Contrutor da classe RemoteAuthentication
  RemoteAuthentication({
    @required this.httpClient, 
    @required this.url,
  });


  //aqui que passa os parametros para o teste.
  Future<void> auth(AuthenticationParans parans) async {
    final body = parans.toJason();
    await httpClient.request(url: url, method: 'post', body: body);
  }
}