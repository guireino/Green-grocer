import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../config/custom_colors.dart';
import '../../../services/validators.dart';
import '../../common_widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // pegando dimensao da tela
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  // Formulario
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            icon: Icons.email,
                            label: 'Email',
                            onSaved: (value) {
                              // savaldo valor na memoria dispositivo
                              authController.user.email = value;
                            },
                            validator: emailValidator,
                            textInputType: TextInputType.emailAddress,
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Senha',
                            onSaved: (value) {
                              // savaldo valor na memoria dispositivo
                              authController.user.password = value;
                            },
                            validator: passwordValidator,
                            isSecret: true,
                          ),
                          CustomTextField(
                            icon: Icons.person,
                            label: 'Nome',
                            onSaved: (value) {
                              // savaldo valor na memoria dispositivo
                              authController.user.name = value;
                            },
                            validator: nameValidator,
                          ),
                          CustomTextField(
                            icon: Icons.phone,
                            label: 'Celular',
                            onSaved: (value) {
                              // savaldo valor na memoria dispositivo
                              authController.user.phone = value;
                            },
                            validator: phoneValidator,
                            textInputType: TextInputType.phone,
                            inputFormatters: [phoneFormatter],
                          ),
                          CustomTextField(
                            icon: Icons.file_copy,
                            label: 'CPF',
                            onSaved: (value) {
                              // savaldo valor na memoria dispositivo
                              authController.user.cpf = value;
                            },
                            validator: cpfvalidator,
                            textInputType: TextInputType.number,
                            inputFormatters: [cpfFormatter],
                          ),
                          SizedBox(
                            height: 50,
                            //utilizando obx para ver returna valor observador
                            child: Obx(() {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        //dirando teclado
                                        FocusScope.of(context).unfocus();
                                        //fazendo click cadastro validar canpos
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          authController.signUp();
                                          //print(authController.user);
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Cadastrar usuario',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                      onPressed: () {
                        // medoto pop do navigator volta para a tela anterior
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
