import 'package:formz/formz.dart';

enum LastnameValidationError { invalid }

class Lastname extends FormzInput<String, LastnameValidationError> {
  const Lastname.pure() : super.pure('');

  const Lastname.dirty([String value = '']) : super.dirty(value);

  @override
  LastnameValidationError? validator(String? value) {
    if (value != null && value.isEmpty) {
      return LastnameValidationError.invalid;
    }
    return null;
  }
}
