import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label; // Başlangıç değeri için
  final Function(String) onChanged; // Veri almak için callback
   bool? obscure;

   CustomTextFormField({
    super.key,
    required this.label,
    required this.onChanged,
    this.obscure
  });

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
      obscureText: widget.obscure ?? false,
      controller: _controller,
      style: TextStyle(color: Colors.white),
      onChanged: widget.onChanged, // Değer değiştikçe veriyi yukarı taşır
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)
        ),
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)
        ) ,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2)
        ),
      ),
    );
  }
}




