import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label; // Başlangıç değeri için
  final Function(String) onChanged; // Veri almak için callback

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: widget.onChanged, // Değer değiştikçe veriyi yukarı taşır
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
      ),
    );
  }
}




