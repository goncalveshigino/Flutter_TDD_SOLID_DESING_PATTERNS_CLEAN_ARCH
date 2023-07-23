import 'package:test/test.dart';


abstract class FieldValidation {
  String get field;
  String validate(String value);
}


class RequiredFieldValidation implements FieldValidation {

  @override
  final String field;

  RequiredFieldValidation(this.field);

  @override
  String validate(String value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatorio';
  }

}

void main(){
  RequiredFieldValidation sut;

  setUp((){
     sut = RequiredFieldValidation('any_field');
  });


  test('Should return null if value is not empty',(){
     expect(sut.validate('any_value'), null);
  });


  test('Should return null if value is empty',(){
     expect( sut.validate(''), 'Campo obrigatorio');
  });


  test('Should return null if value is null',(){
     expect( sut.validate(null), 'Campo obrigatorio');
  });

  
}