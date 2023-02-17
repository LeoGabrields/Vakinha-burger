import 'package:delivery_app/app/core/extensions/validator_extension.dart';
import 'package:delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery_app/app/pages/auth/register/register_controller.dart';
import 'package:delivery_app/app/pages/auth/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () {
            hideLoader();
            showError('Erro ao registrar usuário');
          },
          success: () {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso');
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    'Preencha os campos abaixo para criar o seu cadastro.',
                    style: context.textStyles.textMedium.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameEC,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      var valor = value ?? '';
                      if (valor.isEmpty) {
                        return 'Nome obrigatório';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailEC,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: (value) {
                      var valor = value ?? '';
                      if (valor.isEmpty) {
                        return 'E-mail obrigatório';
                      } else if (!valor.validarEmail) {
                        return 'E-mail inválido';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordEC,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    validator: (value) {
                      var valor = value ?? '';
                      if (valor.isEmpty) {
                        return 'Senha obrigatório';
                      } else if (valor.length < 6) {
                        return 'Senha deve conter pelo menos 6 caracteres';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Confirma Senha'),
                    obscureText: true,
                    validator: (value) {
                      var valor = value ?? '';
                      if (valor.isEmpty) {
                        return 'Confirma Senha obrigatório';
                      } else if (value != _passwordEC.text) {
                        return 'As duas senhas devem ser iguais';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: DeliveryButton(
                      width: double.infinity,
                      onPressed: () {
                        final valid =
                            _formKey.currentState?.validate() ?? false;
                        if (valid) {
                          controller.register(
                            _nameEC.text,
                            _emailEC.text,
                            _passwordEC.text,
                          );
                        }
                      },
                      label: 'Cadastra',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
