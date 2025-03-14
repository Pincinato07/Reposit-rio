import 'dart:io';

void main() {
  List<List<String>> tabuleiro = [
    [" ", " ", " "],
    [" ", " ", " "],
    [" ", " ", " "]
  ];
  String jogador = "X";

  while (true) {
    print("\n ${tabuleiro[0][0]} | ${tabuleiro[0][1]} | ${tabuleiro[0][2]} ");
    print("-----------");
    print(" ${tabuleiro[1][0]} | ${tabuleiro[1][1]} | ${tabuleiro[1][2]} ");
    print("-----------");
    print(" ${tabuleiro[2][0]} | ${tabuleiro[2][1]} | ${tabuleiro[2][2]} \n");

    print("Jogador $jogador, digite linha e coluna (1-3):");
    stdout.write("Linha: ");
    String? linhaStr = stdin.readLineSync();
    stdout.write("Coluna: ");
    String? colunaStr = stdin.readLineSync();

    int? linha = int.tryParse(linhaStr ?? "");
    int? coluna = int.tryParse(colunaStr ?? "");

    if (linha == null || coluna == null || linha < 1 || linha > 3 || coluna < 1 || coluna > 3) {
      print("Posição inválida! Use 1, 2 ou 3.");
      continue;
    }

    int linhaIdx = linha - 1;
    int colunaIdx = coluna - 1;

    if (tabuleiro[linhaIdx][colunaIdx] != " ") {
      print("Posição ocupada!");
      continue;
    }

    // Fazer jogada
    tabuleiro[linhaIdx][colunaIdx] = jogador;

    // Verificar vitória
    if ((tabuleiro[0][0] == jogador && tabuleiro[0][1] == jogador && tabuleiro[0][2] == jogador) ||
        (tabuleiro[1][0] == jogador && tabuleiro[1][1] == jogador && tabuleiro[1][2] == jogador) ||
        (tabuleiro[2][0] == jogador && tabuleiro[2][1] == jogador && tabuleiro[2][2] == jogador) ||
        (tabuleiro[0][0] == jogador && tabuleiro[1][0] == jogador && tabuleiro[2][0] == jogador) ||
        (tabuleiro[0][1] == jogador && tabuleiro[1][1] == jogador && tabuleiro[2][1] == jogador) ||
        (tabuleiro[0][2] == jogador && tabuleiro[1][2] == jogador && tabuleiro[2][2] == jogador) ||
        (tabuleiro[0][0] == jogador && tabuleiro[1][1] == jogador && tabuleiro[2][2] == jogador) ||
        (tabuleiro[0][2] == jogador && tabuleiro[1][1] == jogador && tabuleiro[2][0] == jogador)) {
      print("\n ${tabuleiro[0][0]} | ${tabuleiro[0][1]} | ${tabuleiro[0][2]} ");
      print("-----------");
      print(" ${tabuleiro[1][0]} | ${tabuleiro[1][1]} | ${tabuleiro[1][2]} ");
      print("-----------");
      print(" ${tabuleiro[2][0]} | ${tabuleiro[2][1]} | ${tabuleiro[2][2]} \n");
      print("Jogador $jogador venceu!");
      break;
    }

    // Verificar empate
    bool temEspaco = false;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (tabuleiro[i][j] == " ") temEspaco = true;
      }
    }
    if (!temEspaco) {
      print("\n ${tabuleiro[0][0]} | ${tabuleiro[0][1]} | ${tabuleiro[0][2]} ");
      print("-----------");
      print(" ${tabuleiro[1][0]} | ${tabuleiro[1][1]} | ${tabuleiro[1][2]} ");
      print("-----------");
      print(" ${tabuleiro[2][0]} | ${tabuleiro[2][1]} | ${tabuleiro[2][2]} \n");
      print("Empate!");
      break;
    }

    jogador = jogador == "X" ? "O" : "X";
  }
}