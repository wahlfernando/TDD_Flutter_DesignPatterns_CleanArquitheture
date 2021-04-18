import 'package:curso_tdd/domain/entities/account_entity.dart';

import 'package:meta/meta.dart';

abstract class Authentication {
  //Vai retornar um objeto o tipo AccountEntity
  Future<AccountEntity> auth(AuthenticationParans parans);
  }
  
  class AuthenticationParans {
    final String email;
    final String secret;

  AuthenticationParans({
    @required this.email, 
    @required this.secret
  });


}
