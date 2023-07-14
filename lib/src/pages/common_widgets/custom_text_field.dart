import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextInputType? textInputType;

  final IconData icon;

  final String label;

  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String? initialValue;

  // variavel isSecret para verificar botao visibility da senha esta ativo ou nao
  final bool isSecret, readOnly;

  const CustomTextField({
    Key? key,
    required this.icon,
    required this.label,
    this.isSecret = false,
    this.readOnly = false,
    this.inputFormatters,
    this.initialValue,
    this.validator,
    this.onSaved,
    this.controller,
    this.textInputType,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: widget.controller,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        validator: widget.validator,
        onSaved: widget.onSaved,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.isSecret
                // se ? o isObscure foi igual true case contrario vai ser : null
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        // vai recebe seu reverso
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off))
                : null,
            labelText: widget.label,
            isDense: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
