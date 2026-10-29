import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_user_mobile/main.dart';

void main() {
  testWidgets('Exibe erros para todos os campos vazios', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('CADASTRAR'));
    await tester.pump();
    expect(find.text('Este campo é obrigatório.'), findsNWidgets(5));
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('Valida os campos e confirma cadastro válido', (tester) async {
    await tester.pumpWidget(const MyApp());
    final campos = find.byType(TextFormField);
    await tester.enterText(campos.at(0), 'Maria Silva');
    await tester.enterText(campos.at(1), 'maria');
    await tester.enterText(campos.at(2), '123.456.789-00');
    await tester.enterText(campos.at(3), '(11) 99999-8888');
    await tester.enterText(campos.at(4), '123');
    expect(find.text('12345678900'), findsOneWidget);
    expect(find.text('11999998888'), findsOneWidget);
    await tester.ensureVisible(find.text('CADASTRAR'));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pump();
    expect(find.text('O e-mail deve conter @.'), findsOneWidget);
    expect(
      find.text('A senha deve ter no mínimo 6 caracteres.'),
      findsOneWidget,
    );
    expect(find.byType(SnackBar), findsNothing);

    await tester.enterText(campos.at(1), 'maria@exemplo.com');
    await tester.enterText(campos.at(4), '123456');
    await tester.ensureVisible(find.text('CADASTRAR'));
    await tester.tap(find.text('CADASTRAR'));
    await tester.pumpAndSettle();
    expect(
      find.text('Cadastro de Maria Silva realizado com sucesso!'),
      findsOneWidget,
    );
  });
}
