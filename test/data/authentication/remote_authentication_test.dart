import 'package:curso_tdd/data/http/http.dart';
import 'package:curso_tdd/data/http/http_error.dart';
import 'package:curso_tdd/data/usecases/usecases.dart';
import 'package:curso_tdd/domain/helpers/helpers.dart';
import 'package:curso_tdd/domain/usecases/authentication.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

//sut = system under test

class HttpClientSpy extends Mock implements HttpClient {}
/*
  A Classe que esta sendo testada aqui nesse teste é a "RemoteAuthentication"
  com a função auth();
*/

void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;
  AuthenticationParans parans;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    parans = AuthenticationParans(
        email: faker.internet.email(), secret: faker.internet.password());
  });

  test('Shuld call HttpClient with correct values', () async {
    // deve chamar o HttpClient com os valores corretos.
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenAnswer((_) async =>
            {'accessToken': faker.guid.guid(), 'name': faker.person.name()});

    await sut.auth(parans);

    //está simulando com mockito
    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': parans.email, 'password': parans.secret}));
  });

  test('Shuld throw UnespectedError if HttpClient returns 400', () async {
    // Querermos retornar um erro chamado UnespectedError para o usuário.

    //Mocar a resposta do HttpClient
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.badRequest);

    final future = sut.auth(parans);

    //capturando a resposta da requisição.
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shuld throw UnespectedError if HttpClient returns 404', () async {
    // Querermos retornar um erro chamado UnespectedError para o usuário.

    //Mocar a resposta do HttpClient
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.notFound);

    final future = sut.auth(parans);

    //capturando a resposta da requisição.
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shuld throw UnespectedError if HttpClient returns 500', () async {
    // Querermos retornar um erro chamado UnespectedError para o usuário.

    //Mocar a resposta do HttpClient
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.serverError);

    final future = sut.auth(parans);

    //capturando a resposta da requisição.
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shuld throw InvalideCredencialsError if HttpClient returns 401',
      () async {
    // Querermos retornar um erro chamado UnespectedError para o usuário.

    //Mocar a resposta do HttpClient
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.anauthorized);

    final future = sut.auth(parans);

    //capturando a resposta da requisição.
    expect(future, throwsA(DomainError.invalidCredencials));
  });

  test('Shuld throw InvalideCredencialsError if HttpClient returns 401',
      () async {
    // Querermos retornar um erro chamado UnespectedError para o usuário.

    //Mocar a resposta do HttpClient
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenThrow(HttpError.anauthorized);

    final future = sut.auth(parans);

    //capturando a resposta da requisição.
    expect(future, throwsA(DomainError.invalidCredencials));
  });

  //Caso de sucesso do Accaount
  test('Shuld return an Account if HttpClient returns 200', () async {
    final accessToken = faker.guid.guid();
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            body: anyNamed('body')))
        .thenAnswer((_) async =>
            {'accessToken': accessToken, 'name': faker.person.name()});

    final account = await sut.auth(parans);

    expect(account.token, accessToken);
  });
}
