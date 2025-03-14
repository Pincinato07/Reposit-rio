import 'dart:io';
import 'dart:async';

void main(List<String> arguments) {
  List <int> andares = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int andarAtual = 1;

  while (true){
    print("Simulador de Elevador");
    print("");
    print("1 - Subir para um andar superior");
    print("2 - Descer para um andar inferior");
    print("3 - Ver andar atual");
    print("4 - Sair do programa");
    print("");
    stdout.write("Escolha uma opção: ");

    String? input = stdin.readLineSync();
    int? opcao = int.tryParse(input ?? ""); 
    if (opcao == null) {
      print("Você escolheu uma opção inválida! Digite um número de 1 a 4");
      continue;
    }

    if (opcao == 1) {
      stdout.write("Escolha para qual andar deseja Subir: ");
      String? escolhaDestino = stdin.readLineSync();
      int? destino = int.tryParse(escolhaDestino ?? "");

      if (destino != null && destino > andarAtual && destino <= 10) {
        int indexAtual = andares.indexOf(andarAtual);
        int indexDestino = andares.indexOf(destino);

        if (indexDestino > indexAtual){
          for (int i = indexAtual + 1; i <= indexDestino; i ++){
            print("Elevador subindo, você está no andar ${andares[i]}");
          }
          andarAtual = destino;
        }
        
      } else {
        print("Andar inválido, digite uma opção acima do andar que você se encontra.");
      }
    }

    if (opcao == 2) {
      stdout.write("Escolha para qual andar deseja Descer:  ");
      String? escolhaDestino = stdin.readLineSync();
      int? destino = int.tryParse(escolhaDestino ?? "");

      if (destino != null && destino < andarAtual && destino >= 1) {
        int indexAtual = andares.indexOf(andarAtual);
        int indexDestino = andares.indexOf(destino);

        if (indexDestino < indexAtual) {
          for (int i = indexAtual - 1; i >= indexDestino; i --){
            print("Elevador descendo, você está no andar ${andares[i]}");
          }
          andarAtual = destino;
        }
      } else {
        print("Andar inválido, digite uma opção abaixo do andar que você se encontra.");
      }
    }

    if (opcao == 3) {
      print("Você se encontra no andar $andarAtual");
    }

    if (opcao == 4){
      print("Ok, encerrando programa.");
      for (int i = 1 ; i <= 5; i ++) {
        Future.delayed(Duration(seconds: 1), (){
          print("Encerrando em $i");
        });
      }
      exit(0);
    }
  }

}

