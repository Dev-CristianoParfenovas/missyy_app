import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:missyy/domain/models/user_login.dart';
import 'package:missyy/domain/models/user_manager.dart';
import 'package:missyy/presentation/widgets/components/custom_text_field.dart';
import '../../../helpers/validators.dart';
import 'package:provider/provider.dart';

class TelaCadastro extends StatelessWidget {
  TelaCadastro({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Color corPadrao = ScreenColors.corPadraoApp;
  late final UserLogin userLogin = UserLogin(email: '', password: '', name: '');

  //controlador de campos
  // final phoneController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  /*final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: corPadrao,
        elevation: 0,
        toolbarHeight: 72,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Missyy',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 50,
          ),
          //FORMULÁRIO
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 56,
                    ),
                    //NOME
                    CustomTextField(
                      controller: nameController,
                      icon: Icons.person,
                      label: 'Nome',
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (name.trim().split(' ').length <= 1) {
                          return 'Preencha seu nome completo';
                        }
                        return null;
                      },
                      // onSaved: (name) => userLogin.name = name,
                    ),
                    //EMAIL
                    CustomTextField(
                      controller: emailController,
                      readOnly: false,
                      textInputType: TextInputType.emailAddress,
                      icon: Icons.email,
                      label: 'Email',
                      validator: (email) {
                        if (!emailValid(email!)) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                      // onSaved: (email) => userLogin.email = email,
                    ),
                    //CELULAR
                    /*CustomTextField(
                  controller: phoneController,
                  icon: Icons.phone,
                  label: 'Celular',
                  inputFormatters: [phoneFormatter],
                  textInputType: TextInputType.phone,
                  validator: phoneValidator,
                  onSaved: (email) => userLogin.email = email,
                ),*/
                    //SENHA
                    CustomTextField(
                      controller: passwordController,
                      readOnly: false,
                      icon: Icons.lock,
                      label: 'Senha',
                      isSecret: true,
                      validator: (pass) {
                        if (pass!.isEmpty || pass.length < 6) {
                          return 'Senha inválida';
                        }
                        return null;
                      },
                      // onSaved: (pass) => userLogin.password = pass,
                    ),
                    //REPITA A SENHA
                    /* CustomTextField(
                      controller: confirmPasswordController,
                      readOnly: false,
                      icon: Icons.lock,
                      label: 'Repita a Senha',
                      isSecret: true,
                      validator: (confirmpass) {
                        if (confirmpass!.isEmpty || confirmpass.length < 6) {
                          return 'Senha inválida';
                        }
                        return null;
                      },
                    ),*/

                    //BOTAO CADASTRAR
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ScreenColors.corPadraoApp,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  userManager.signUp(
                                    userlogin: UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                    ),
                                    //_formKey.currentState!.save();

                                    onSuccess: () {
                                      debugPrint('Sucesso ao Cadastrar');
                                    },
                                    onFail: (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('falha ao cadastrar: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                        child: userManager.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Cadastrar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
