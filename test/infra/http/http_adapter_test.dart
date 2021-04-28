import 'package:curso_tdd/infra/http/http.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client {}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = Uri.parse(faker.internet.httpUrl()).toString();
  });

  group('post', () {
    PostExpectation mockRequest() => when(
        client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode,
        {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    //esse cara é padrão vai rodar em todos os testes antes de iniciar;
    //isso serve para não escrever código repetido
    setUp(() {
      mockResponse(200);
    });

    test('Shoult call post with correct values', () async {
      await sut.request(
          url: url.toString(), method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(url,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('Shoult call post without body', () async {
      when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut.request(url: url.toString(), method: 'post');

      verify(client.post(
        any,
        headers: anyNamed('headers'),
        //body: '{"any_key":"any_value"}'
      ));
    });

    test('Shoult return data if post returns 200', () async {
      final resposnse = await sut.request(url: url.toString(), method: 'post');

      expect(resposnse, {'any_key': 'any_value'});
    });

    test('Shoult return null if post returns 200 with no data', () async {
      mockResponse(200, body: '');

      final resposnse = await sut.request(url: url.toString(), method: 'post');

      expect(resposnse, null);
    });

    test('Shoult return null if post returns 204', () async {
      mockResponse(204, body: '');

      final resposnse = await sut.request(url: url.toString(), method: 'post');

      expect(resposnse, null);
    });

    test('Shoult return null if post returns 204 with data ', () async {
      mockResponse(204);

      final resposnse = await sut.request(url: url.toString(), method: 'post');

      expect(resposnse, null);
    });
  });
}
