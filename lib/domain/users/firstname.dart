import 'package:formz/formz.dart';

enum FirstnameValidationError { invalid }

class Firstname extends FormzInput<String, FirstnameValidationError> {
  const Firstname.pure() : super.pure('');

  const Firstname.dirty([String value = '']) : super.dirty(value);

  @override
  FirstnameValidationError? validator(String? value) {
    if (value != null && value.isEmpty) {
      return FirstnameValidationError.invalid;
    }
    return null;
  }
}
