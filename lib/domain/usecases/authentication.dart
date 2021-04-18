import 'package:curso_tdd/domain/entities/account_entity.dart';

import 'package:meta/meta.dart';

abstract class Authentication{

  //Vai retornar um objeto o tipo AccountEntity
  Future<AccountEntity>auth({@required String email, @required String password});


}