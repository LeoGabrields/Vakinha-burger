extension FormatterExtension on double {
  String get currencyPTBR {
    var length = toString().length + 1;
    var value = toString().replaceAll('.', ',').padRight(length, '0');
    return 'R\$ $value';
  }
}
