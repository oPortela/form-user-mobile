import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de usuário',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3759B8)),
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF4F6FB),
          foregroundColor: Color(0xFF23345C),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF23345C),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          prefixIconColor: const Color(0xFF59709C),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD9DFEB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF3759B8), width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3759B8),
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _dados = {};

  String? _validarObrigatorio(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Este campo é obrigatório.';
    }
    return null;
  }

  void _cadastrar() {
    if (!_formKey.currentState!.validate()) return;

    // Captura os valores pelos callbacks onSaved dos campos.
    _formKey.currentState!.save();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Cadastro de ${_dados['nome']} realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    // O cadastro é uma simulação, sem banco de dados.
    _dados.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de usuário')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: (constraints.maxHeight - 48).clamp(
                    0.0,
                    double.infinity,
                  ),
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 480),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE3E8F2)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D23345C),
                          blurRadius: 24,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Center(
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Color(0xFFEBF0FF),
                            child: Icon(
                              Icons.person_add_alt_1_outlined,
                              size: 28,
                              color: Color(0xFF3759B8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Crie sua conta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF23345C),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Preencha os dados abaixo para se cadastrar.\nTodos os campos são obrigatórios.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF63708A),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nome completo',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          validator: _validarObrigatorio,
                          onSaved: (valor) => _dados['nome'] = valor!.trim(),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          validator: (valor) {
                            final erro = _validarObrigatorio(valor);
                            if (erro != null) return erro;
                            if (!valor!.contains('@')) {
                              return 'O e-mail deve conter @.';
                            }
                            return null;
                          },
                          onSaved: (valor) => _dados['email'] = valor!.trim(),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'CPF',
                            prefixIcon: Icon(Icons.badge_outlined),
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: _validarObrigatorio,
                          onSaved: (valor) => _dados['cpf'] = valor!,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Telefone',
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: _validarObrigatorio,
                          onSaved: (valor) => _dados['telefone'] = valor!,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          validator: (valor) {
                            final erro = _validarObrigatorio(valor);
                            if (erro != null) return erro;
                            if (valor!.length < 6) {
                              return 'A senha deve ter no mínimo 6 caracteres.';
                            }
                            return null;
                          },
                          onSaved: (valor) => _dados['senha'] = valor!,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _cadastrar,
                          child: const Text('CADASTRAR'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
