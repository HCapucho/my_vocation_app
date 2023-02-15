import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_vocation_app/core/core.dart';
import 'package:my_vocation_app/core/helpers/loader.dart';
import 'package:my_vocation_app/core/helpers/messages.dart';
import 'package:my_vocation_app/modules/home/home_page.dart';
import 'package:my_vocation_app/modules/login/domain/bloc/login_bloc.dart';
import 'package:my_vocation_app/modules/quiz/widgets/next_button/next_button_widget.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with Messages<LoginPage>, Loader<LoginPage> {
  late final LoginBloc bloc;

  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = context.read<LoginBloc>();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  void _onLoginAuthentication(String user, String senha) {
    bloc.add(LoginAuthenticationEvent(user, senha));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginAuthenticationInProgress) {
            showLoader();
          }
          if (state is LoginAuthenticationFailure) {
            hideLoader();
            showError(state.errorMessage);
          }
          if (state is LoginAuthenticationSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomePage(username: state.usuario.nome)));
          }
        },
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: AppGradients.linear,
            ),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            (MediaQuery.of(context).size.width > 350
                                ? .30
                                : .25),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child:
                              Text('Login', style: AppTextStyles.bodyWhite20),
                        ),
                      ),
                      TextFormField(
                        controller: emailEC,
                        decoration: InputDecoration(
                          label: Text('E-mail',
                              style: TextStyle(color: AppColors.white)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('Obrigatório'),
                          Validatorless.email('E-mail inválido')
                        ]),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordEC,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text('Senha',
                              style: TextStyle(color: AppColors.white)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('Obrigatório'),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      NextButtonWidget.white(
                        onTap: () {
                          final valid =
                              formKey.currentState?.validate() ?? false;
                          if (valid) {
                            _onLoginAuthentication(
                                emailEC.text, passwordEC.text);
                          }
                        },
                        label: 'Entrar',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
