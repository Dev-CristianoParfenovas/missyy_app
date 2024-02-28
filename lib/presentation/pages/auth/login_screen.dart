import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:missyy/domain/models/user_login.dart';
import 'package:missyy/domain/models/user_manager.dart';
import 'package:missyy/helpers/validators.dart';
import 'package:missyy/presentation/pages/auth/cad_products_screen.dart';
import 'package:missyy/presentation/pages/base/base_screen.dart';
import 'package:missyy/presentation/widgets/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:missyy/presentation/pages/auth/tela_cadastro_screen.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final Color corPadrao = ScreenColors.corPadraoApp;

  final Color corPrincipal = ScreenColors.fundoPrincipal;

  //controlador de campos
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
          padding: const EdgeInsets.all(16.0),
          //FORMULÁRIO
          child: Form(
            key: _formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //LOGO APP
                    Image.asset(
                      "assets/logo.jpg",
                      height: 128,
                    ),
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText(
                              'Semijóias de qualidade!!',
                              textAlign: TextAlign.center,
                            ),
                            FadeAnimatedText(
                              'Acesse nossa loja!!',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 56,
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
                    ),

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
                    ),

                    //BOTAO ENTRAR
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor:
                              ScreenColors.corPadraoApp.withAlpha(100),
                          backgroundColor: ScreenColors.corPadraoApp,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  userManager.signIn(
                                    userlogin: UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: '',
                                    ),
                                    onFail: (e) {
                                      // print(e);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('falha ao entrar: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                    onSuccess: () {
                                      if (userManager.adminEnable) {
                                        // Navigator.of(context).pop();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (ctx) {
                                          return CadProducts();
                                        }));
                                      } else
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (ctx) {
                                          return BaseScreen();
                                        }));

                                      /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProductsPage()));*/
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
                                'Entrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //ESQUECEU A SENHA
                    const Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: null,
                        child: Text(
                          'Esqueceu a senha?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    //DIVISOR
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.withAlpha(90),
                              thickness: 2,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Ou',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.withAlpha(90),
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //BOTÃO DE NOVO USUÁRIO
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          side: const BorderSide(
                            width: 2,
                            color: ScreenColors.corPadraoApp,
                          ),
                        ),
                        onPressed: () {
                          // listaUsuarios();
                          //_registerUser();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) {
                                return TelaCadastro();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Criar conta',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
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
