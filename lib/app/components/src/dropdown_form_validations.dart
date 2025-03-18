class DropdownFormValidations {
  static String? required(dynamic value, {String fieldName = 'This field'}) {
    if (value == null) {
      return "${fieldName} tidak boleh kosong";
    }
    return null;
  }

  static String? isValidItem<T>(
      Map<String, String>? value, List<Map<String, String>?> items,
      {String message = 'Invalid selection'}) {
    if (value != null && !items.any((item) => item?['name'] == value['name'])) {
      return message;
    }
    return null;
  }
}
