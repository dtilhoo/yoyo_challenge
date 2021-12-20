class ValidatorMixin {
  String? textValidation(value, String text) {
    if (value == null || value.isEmpty) {
      return text;
    }
    return null;
  }
}
