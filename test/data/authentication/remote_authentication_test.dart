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
  Map mockValidData() => {'accessToken': faker.guid.guid(), 'name': faker.person.name()};

  PostExpectation mockRequest() => when(httpClient.request( url: anyNamed('url'),method: anyNamed('method'), body: anyNamed('body')));

  void mockHttpData(Map data){
     mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error){
    mockRequest().thenThrow(error);
  }


  setUp(() {  
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    parans = AuthenticationParans(email: faker.internet.email(), secret: faker.internet.password());
    mockHttpData(mockValidData());
  });

    // deve chamar o HttpClient com os valores corretos.
  test('Shuld call HttpClient with correct values', () async {
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
    mockHttpError(HttpError.badRequest);

    final future = sut.auth(parans);

    //capturando a resposta da requisição.
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shuld throw UnespectedError if HttpClient returns 404', () async {
    // Querermos retornar um erro chamado UnespectedError para o usuário.

    //Mocar a resposta do HttpClient
    mockHttpError(HttpError.notFound);

    final future = sut.auth(parans);

    //capturando a resposta da requisição.
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shuld throw UnespectedError if HttpClient returns 500', () async {
    // Querermos retornar um erro chamado UnespectedError para o usuário.

    //Mocar a resposta do HttpClient
    mockHttpError(HttpError.serverError);

    final future = sut.auth(parans);

    //capturando a resposta da requisição.
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Shuld throw InvalideCredencialsError if HttpClient returns 401',
      () async {
    // Querermos retornar um erro chamado UnespectedError para o usuário.

    //Mocar a resposta do HttpClient
    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(parans);

    //capturando a resposta da requisição.
    expect(future, throwsA(DomainError.invalidCredencials));
  });

  test('Shuld throw InvalideCredencialsError if HttpClient returns 401',
      () async {
    // Querermos retornar um erro chamado UnespectedError para o usuário.

    //Mocar a resposta do HttpClient
    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(parans);

    //capturando a resposta da requisição.
    expect(future, throwsA(DomainError.invalidCredencials));
  });

  //Caso de sucesso do Accaount
  test('Shuld return an Account if HttpClient returns 200', () async {
    final validData = mockValidData();

    mockHttpData(validData);
  
    final account = await sut.auth(parans);

    expect(account.token, validData['accessToken']);
  });

  // Esse teste vai causar uma exeção quando for colocado dados inválidos no retorno.
  test('Shuld throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.auth(parans);

    expect(future, throwsA(DomainError.unexpected) );
  });
}
