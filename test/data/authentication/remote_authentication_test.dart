import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

//sut = system under test

class RemoteAuthentication{
  final HttpClient httpClient;
  final String url;

  //Contrutor da classe RemoteAuthentication
  RemoteAuthentication({
    @required this.httpClient, 
    @required this.url,
  });

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void> request({
    @required String url,
    @required String method,
  });
}

class HttpClientSpy extends Mock implements HttpClient{}

void main() {

  test('Shuld call HttpClient with correct values',  () async{
    // deve chamar o HttpClient com os valores corretos.
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);

    await sut.auth();

    //está simulando com mockito
    verify(httpClient.request(
      url: url,
      method: 'post'
    ));


  });
}