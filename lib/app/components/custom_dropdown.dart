import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnica_app/app/constants/constants.dart';

class CustomDropdown extends StatefulWidget {
  final String? label;
  final bool? all;
  final bool isEnabled;
  final String? hint;
  final List<Map<String, String>> items; // Ubah tipe data items
  final Map<String, String>? initialValue;
  final String? Function(Map<String, String>?)
      itemLabel; // Ubah tipe data itemLabel
  final List<String? Function(Map<String, String>?)>?
      validators; // Ubah tipe data validators
  final void Function(Map<String, String>?)?
      onChanged; // Ubah tipe data onChanged
  final InputDecoration? decoration;
  final bool isBorder;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final bool showResetButton;
  final Widget Function(Map<String, String> item)?
      itemBuilder; // Ubah tipe data itemBuilder
  final Widget? icon;
  final Widget? prefixicon;

  /// Widget [CustomDropdown] dengan fitur kustomisasi yang lengkap - created by [G.SW]
  ///
  /// Parameter:
  /// - `label`: Label yang akan ditampilkan pada dropdown.
  /// - `hint`: Hint text yang akan muncul saat dropdown tidak memiliki pilihan.
  /// - `items`: Daftar item dalam bentuk `Map<String, String>` yang akan ditampilkan dalam dropdown.
  /// - `itemLabel`: Fungsi yang digunakan untuk mengambil label dari item untuk ditampilkan.
  /// - `validators`: Daftar fungsi validasi yang digunakan untuk memvalidasi pilihan dropdown.
  /// - `onChanged`: Fungsi callback yang akan dipanggil ketika nilai dropdown berubah.
  /// - `decoration`: Dekorasi input untuk dropdown, seperti warna dan padding.
  /// - `isBorder`: Menentukan apakah dropdown memiliki border atau tidak.
  /// - `borderRadius`: Menentukan radius sudut untuk border dropdown.
  /// - `borderColor`: Menentukan warna border untuk dropdown.
  /// - `showResetButton`: Menentukan apakah tombol reset akan ditampilkan untuk menghapus pilihan dropdown.
  /// - `itemBuilder`: Fungsi yang digunakan untuk menyesuaikan tampilan setiap item dalam dropdown.
  const CustomDropdown({
    super.key,
    this.label,
    this.hint,
    required this.items,
    required this.itemLabel,
    this.validators,
    this.isEnabled = true,
    this.onChanged,
    this.decoration,
    this.isBorder = false,
    this.borderRadius,
    this.borderColor,
    this.showResetButton = false,
    this.itemBuilder,
    this.icon,
    this.all = false,
    this.prefixicon,
    this.initialValue,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  Map<String, String>? _selectedValue;
  List<Map<String, String>> _dropdownItems = [];

  @override
  void initState() {
    super.initState();
    _dropdownItems = List.from(widget.items);

    // Tambahkan initialValue jika belum ada di _dropdownItems
    if (widget.initialValue != null &&
        !_dropdownItems
            .any((item) => item['name'] == widget.initialValue!['name'])) {
      _dropdownItems.add(widget.initialValue!);
    }

    if (widget.all == true) {
      _dropdownItems.insert(0, {'id': '', 'name': 'Semua'});
    }
    if (_selectedValue == null &&
        widget.initialValue != null &&
        widget.initialValue != {}) {
      _selectedValue = widget.initialValue;
    }
  }

  @override
  void didUpdateWidget(covariant CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items || _dropdownItems != widget.items) {
      _dropdownItems = List.from(widget.items);
      if (widget.all == true &&
          !_dropdownItems.any((item) => item['name'] == 'Semua')) {
        _dropdownItems.insert(0, {'id': '', 'name': 'Semua'});
      }
    }
  }

  void _resetDropdown() {
    setState(() {
      _selectedValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<Map<String, String>>(
            value: _selectedValue == null
                ? _selectedValue
                : _dropdownItems.isNotEmpty
                    ? _dropdownItems
                        .where((i) => i['name'] == _selectedValue?['name'])
                        .first as Map<String, String>?
                    : null,
            decoration: widget.decoration ??
                (_useCustomBorder()
                    ? InputDecoration(
                        isDense: true,
                        errorStyle: GoogleFonts.montserrat(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                        prefixIcon: widget.prefixicon,
                        labelText: widget.label ?? '',
                        filled: widget.isEnabled ? false : true,
                        fillColor: widget.isEnabled ? Colors.white : kWhite,
                        border: OutlineInputBorder(
                          borderRadius:
                              widget.borderRadius ?? BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: widget.borderColor ?? Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              widget.borderRadius ?? BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: widget.borderColor ?? Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              widget.borderRadius ?? BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: widget.borderColor ?? Colors.grey,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 22,
                        ),
                      )
                    : null),
            items: _dropdownItems
                .map(
                  (item) => DropdownMenuItem<Map<String, String>>(
                    value: item,
                    child: _buildDropdownItem(item),
                  ),
                )
                .toList(),
            onChanged: widget.isEnabled
                ? (Map<String, String>? newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                    widget.onChanged?.call(newValue);
                  }
                : null,
            validator: _validate,
            hint: widget.hint != null
                ? Text(
                    widget.hint!,
                    style: GoogleFonts.montserrat(
                      color: kGrayLight,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            icon: widget.icon ??
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: kGray,
                ),
            isExpanded: true,
          ),
        ),
        if (widget.showResetButton)
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.grey),
            onPressed: _resetDropdown,
          ),
      ],
    );
  }

  bool _useCustomBorder() {
    return widget.isBorder;
  }

  Widget _buildDropdownItem(Map<String, String> item) {
    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(item);
    }
    final label = widget.itemLabel(item);
    return Container(
      height: 60, // Control the height of the dropdown *menu* items
      alignment: Alignment.centerLeft,
      child: Text(
        label ?? '', // Handle jika label null
        style: GoogleFonts.montserrat(
          color: kDark,
          fontSize: 14,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  String? _validate(Map<String, String>? value) {
    if (widget.validators != null) {
      for (var validator in widget.validators!) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
    }
    return null;
  }
}
