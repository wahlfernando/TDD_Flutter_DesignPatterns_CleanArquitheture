
import 'package:curso_tdd/data/http/http_client.dart';
import 'package:curso_tdd/data/usecases/remote_authentication.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:curso_tdd/domain/usecases/authentication.dart';

//sut = system under test





class HttpClientSpy extends Mock implements HttpClient{}

/*
  A Classe que esta sendo testada aqui nesse teste é a "RemoteAuthentication"
  com a função auth();
*/


void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;


  setUp((){
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Shuld call HttpClient with correct values',  () async{
    // deve chamar o HttpClient com os valores corretos.
    
    final parans = AuthenticationParans(email: faker.internet.email(), secret: faker.internet.password());
    await sut.auth(parans);

    //está simulando com mockito
    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {'email': parans.email, 'password': parans.secret}
    ));


  });
}