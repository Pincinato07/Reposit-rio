import 'dart:io';

void main() {
  List<Map<String, dynamic>> estoque = [];

  while (true) {
    print("\n=== Sistema de Controle de Estoque ===");
    print("1 - Cadastrar Produto");
    print("2 - Listar Produtos Cadastrados");
    print("3 - Excluir Produto");
    print("4 - Adicionar/Remover Quantidade");
    print("5 - Sair");
    stdout.write("Escolha uma opção: ");

    String? input = stdin.readLineSync();
    int? opcao = int.tryParse(input ?? "");

    if (opcao == null || opcao < 1 || opcao > 5) {
      print("Opção inválida! Por favor, escolha um número de 1 a 5.");
      continue;
    }

    if (opcao == 1) {
      print("\n=== Cadastrar Produto ===");
      stdout.write("Digite o nome do produto: ");
      String? nome = stdin.readLineSync();

      if (nome == null || nome.trim().isEmpty) {
        print("Nome inválido! O produto não foi cadastrado.");
        continue;
      }

      stdout.write("Digite a quantidade inicial: ");
      String? qtdInput = stdin.readLineSync();
      int? quantidade = int.tryParse(qtdInput ?? "");

      if (quantidade == null || quantidade < 0) {
        print("Quantidade inválida! Use um número maior ou igual a 0.");
        continue;
      }

      stdout.write("Digite o preço do produto (ex.: 10.50): ");
      String? precoInput = stdin.readLineSync();
      double? preco = double.tryParse(precoInput ?? "");

      if (preco == null || preco < 0) {
        print("Preço inválido! Use um valor maior ou igual a 0.");
        continue;
      }

      estoque.add({
        'nome': nome,
        'quantidade': quantidade,
        'preco': preco,
      });
      print("Produto cadastrado com sucesso!");
    }

    if (opcao == 2) {
      if (estoque.isEmpty) {
        print("\nNenhum produto cadastrado.");
      } else {
        print("\n=== Lista de Produtos Cadastrados ===");
        for (int i = 0; i < estoque.length; i++) {
          print("\nProduto ${i + 1}:");
          print("Nome: ${estoque[i]['nome']}");
          print("Quantidade: ${estoque[i]['quantidade']}");
          print("Preço: R\$${estoque[i]['preco'].toStringAsFixed(2)}");
        }
      }
    }

    if (opcao == 3) {
      if (estoque.isEmpty) {
        print("\nNenhum produto para excluir.");
        continue;
      }

      print("\n=== Excluir Produto ===");
      stdout.write("Digite o número do produto a excluir (conforme listado): ");
      String? numeroInput = stdin.readLineSync();
      int? numero = int.tryParse(numeroInput ?? "");

      if (numero == null || numero < 1 || numero > estoque.length) {
        print("Número inválido! Digite um número válido da lista de produtos.");
        continue;
      }

      estoque.removeAt(numero - 1);
      print("Produto $numero excluído com sucesso!");
    }

    if (opcao == 4) {
      if (estoque.isEmpty) {
        print("\nNenhum produto para atualizar.");
        continue;
      }

      print("\n=== Adicionar/Remover Quantidade ===");
      stdout.write("Digite o número do produto (conforme listado): ");
      String? numeroInput = stdin.readLineSync();
      int? numero = int.tryParse(numeroInput ?? "");

      if (numero == null || numero < 1 || numero > estoque.length) {
        print("Número inválido! Digite um número válido da lista de produtos.");
        continue;
      }

      Map<String, dynamic> produto = estoque[numero - 1];
      print("\nProduto selecionado:");
      print("Nome: ${produto['nome']}");
      print("Quantidade: ${produto['quantidade']}");
      print("Preço: R\$${produto['preco'].toStringAsFixed(2)}");

      print("\n1 - Adicionar quantidade");
      print("2 - Remover quantidade");
      stdout.write("Escolha uma opção: ");
      String? subOpcaoInput = stdin.readLineSync();
      int? subOpcao = int.tryParse(subOpcaoInput ?? "");

      if (subOpcao == null || (subOpcao != 1 && subOpcao != 2)) {
        print("Opção inválida! Escolha 1 ou 2.");
        continue;
      }

      stdout.write("Digite a quantidade: ");
      String? qtdInput = stdin.readLineSync();
      int? quantidade = int.tryParse(qtdInput ?? "");

      if (quantidade == null || quantidade < 0) {
        print("Quantidade inválida! Use um número maior ou igual a 0.");
        continue;
      }

      if (subOpcao == 1) {
        produto['quantidade'] += quantidade;
        print("Quantidade adicionada! Novo estoque: ${produto['quantidade']}");
      } else if (subOpcao == 2) {
        if (quantidade > produto['quantidade']) {
          print("Erro: Não há quantidade suficiente para remover. Estoque atual: ${produto['quantidade']}");
        } else {
          produto['quantidade'] -= quantidade;
          print("Quantidade removida! Novo estoque: ${produto['quantidade']}");
        }
      }
    }

    if (opcao == 5) {
      print("\nEncerrando o sistema...");
      for (int i = 3; i > 0; i--) {
        sleep(Duration(seconds: 1));
        print("Saindo em $i...");
      }
      print("Sistema encerrado!");
      exit(0);
    }
  }
}