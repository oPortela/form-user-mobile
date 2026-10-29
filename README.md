# Cadastro de usuário em Flutter

Projeto acadêmico simples com um formulário de cadastro.

## Funcionalidades

- Campos obrigatórios: nome completo, e-mail, CPF, telefone e senha.
- E-mail deve conter `@` e senha deve ter pelo menos 6 caracteres.
- CPF e telefone aceitam somente números.
- Erros aparecem abaixo dos campos ao tocar em **CADASTRAR**.
- Um SnackBar confirma o cadastro quando todos os campos são válidos.

A tela usa `Scaffold > Form > SingleChildScrollView > Column`, com
`TextFormField`, espaçamentos de 16 pixels e um `ElevatedButton`.
Os valores são capturados com `onSaved`. O cadastro é apenas uma simulação,
sem banco de dados ou envio para servidor.

## Executar

Com o Flutter instalado e um dispositivo ou emulador disponível:

```bash
flutter pub get
flutter run
```

## Verificar

```bash
flutter analyze
flutter test
```

O código da tela está em `lib/main.dart`.
