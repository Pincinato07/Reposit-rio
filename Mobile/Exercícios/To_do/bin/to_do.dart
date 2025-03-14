import 'dart:io';

void main() {
  List<Map<String, dynamic>> tarefas = [];

  while (true) {
    print("\n=== Sistema de Gestão de Tarefas ===");
    print("1 - Incluir Tarefa");
    print("2 - Listar Todas as Tarefas");
    print("3 - Excluir Tarefa");
    print("4 - Sair");
    stdout.write("Escolha uma opção: ");

    String? input = stdin.readLineSync();
    int? opcao = int.tryParse(input ?? "");

    if (opcao == null || opcao < 1 || opcao > 4) {
      print("Opção inválida! Por favor, escolha um número de 1 a 4.");
      continue;
    }

    if (opcao == 1) {
      print("\n=== Nova Tarefa ===");
      stdout.write("Digite o título da tarefa: ");
      String? titulo = stdin.readLineSync();

      if (titulo == null || titulo.trim().isEmpty) {
        print("Título inválido! A tarefa não foi criada.");
        continue;
      }

      stdout.write("Digite a descrição da tarefa: ");
      String? descricao = stdin.readLineSync();

      stdout.write("Digite o grau de urgência (1-5): ");
      String? urgenciaInput = stdin.readLineSync();
      int? urgencia = int.tryParse(urgenciaInput ?? "");

      if (urgencia == null || urgencia < 1 || urgencia > 5) {
        print("Grau de urgência inválido! Use um valor entre 1 e 5.");
        continue;
      }

      tarefas.add({
        'titulo': titulo,
        'descricao': descricao ?? "Sem descrição",
        'urgencia': urgencia,
      });
      print("Tarefa adicionada com sucesso!");
    }

    if (opcao == 2) {
      if (tarefas.isEmpty) {
        print("\nNenhuma tarefa cadastrada.");
      } else {
        print("\n=== Lista de Tarefas ===");
        for (int i = 0; i < tarefas.length; i++) {
          print("\nTarefa ${i + 1}:");
          print("Título: ${tarefas[i]['titulo']}");
          print("Descrição: ${tarefas[i]['descricao']}");
          print("Urgência: ${tarefas[i]['urgencia']}/5");
        }
      }
    }

    if (opcao == 3) {
      if (tarefas.isEmpty) {
        print("\nNenhuma tarefa para excluir.");
        continue;
      }

      print("\n=== Excluir Tarefa ===");
      print("Digite o número da tarefa que deseja excluir:");
      stdout.write("Número: ");
      String? numeroInput = stdin.readLineSync();
      int? numero = int.tryParse(numeroInput ?? "");

      if (numero == null || numero < 1 || numero > tarefas.length) {
        print("Número inválido! Digite um número válido da lista de tarefas.");
        continue;
      }

      tarefas.removeAt(numero - 1);
      print("Tarefa $numero excluída com sucesso!");
    }

    if (opcao == 4) {
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