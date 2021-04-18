import 'package:curso_tdd/data/http/http_client.dart';
import 'package:curso_tdd/data/http/http_error.dart';
import 'package:curso_tdd/domain/helpers/domain_error.dart';
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
    final body = RemoteAuthenticationParans.toDomain(parans).toJason();
    
    try{
      await httpClient.request(url: url, method: 'post', body: body);
    } on HttpError catch(error){
      throw error == HttpError.anauthorized ? DomainError.invalidCredencials : DomainError.unexpected;
    }
  }
}

  class RemoteAuthenticationParans {
    final String email;
    final String password;

  RemoteAuthenticationParans({
    @required this.email, 
    @required this.password
  });

  factory RemoteAuthenticationParans.toDomain(AuthenticationParans parans) => RemoteAuthenticationParans(email: parans.email, password: parans.secret);

  Map toJason() => {'email': email, 'password': password};  


}
