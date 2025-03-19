class Pessoa {
  String nome;
  int idade;
  String? end;

  Pessoa({this.end, required this.nome, required this.idade}); 

  void setidade(int x){
    if (x.isNegative){
      print("Valor negativo");  
    } else{
      this.idade = x;
    }
  }
}

 

void main() {
  
  Pessoa pessoa = Pessoa(idade: 20, nome: 'Lucas', end: 'Avenida caetano Gornati')
}