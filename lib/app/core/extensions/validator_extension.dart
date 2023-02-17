extension ValidatorEmail on String {
  bool get validarEmail {
    final RegExp regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    return regex.hasMatch(this);
  }
}