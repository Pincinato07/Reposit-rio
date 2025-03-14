from flask import Flask, request, jsonify

app = Flask(__name__)

clientes = {
    1: {"nome": "João", 
        "email": "joao@example.com", 
        "livros_comprados": [1], 
        "data_registro": "2025-01-15"},
    2: {"nome": "Maria", 
        "email": "maria@example.com", 
        "livros_comprados": [2], 
        "data_registro": "2025-01-16"}
}

autores = {
    1: {"nome": "J.K. Rowling", 
        "nacionalidade": "Britânica", 
        "data_nascimento": "1965-07-31"},
    2: {"nome": "George Orwell", 
        "nacionalidade": "Britânica", 
        "data_nascimento": "1903-06-25"}
}

livros = {
    1: {"titulo": "Harry Potter e a Pedra Filosofal", 
        "autor_id": 1, 
        "genero": "Fantasia", 
        "preco": 49.90, 
        "data_lancamento": "1997-06-26"},
    2: {"titulo": "1984", 
        "autor_id": 2, 
        "genero": "Distopia", 
        "preco": 39.90, 
        "data_lancamento": "1949-06-08"}
}

@app.route('/')
def homepage():
    return "<h1>Bem-vindo à biblioteca</h1>"

# Rotas para Clientes
@app.route('/clientes/<int:id>', methods=['GET'])
def get_cliente(id):
    if id in clientes:
        return jsonify(clientes[id])
    return jsonify({"erro": "Cliente não encontrado"}), 404

@app.route('/clientes', methods=['POST'])
def add_cliente():
    data = request.get_json()
    novo_id = max(clientes.keys(), default=0) + 1
    clientes[novo_id] = data
    return jsonify({"mensagem": "Cliente adicionado", "cliente": clientes[novo_id]}), 201

@app.route('/clientes/<int:id>', methods=['PUT'])
def update_cliente(id):
    if id not in clientes:
        return jsonify({"erro": "Cliente não encontrado"}), 404
    clientes[id].update(request.get_json())
    return jsonify({"mensagem": "Cliente atualizado", "cliente": clientes[id]})

@app.route('/clientes/<int:id>', methods=['DELETE'])
def delete_cliente(id):
    if id not in clientes:
        return jsonify({"erro": "Cliente não encontrado"}), 404
    del clientes[id]
    return jsonify({"mensagem": "Cliente removido"})

# Rotas para Autores
@app.route('/autores/<int:id>', methods=['GET'])
def get_autor(id):
    return jsonify(autores.get(id, {"erro": "Autor não encontrado"}))

@app.route('/autores', methods=['POST'])
def add_autor():
    data = request.get_json()
    novo_id = max(autores.keys(), default=0) + 1
    autores[novo_id] = data
    return jsonify({"mensagem": "Autor adicionado", "autor": autores[novo_id]}), 201

@app.route('/autores/<int:id>', methods=['PUT'])
def update_autor(id):
    if id not in autores:
        return jsonify({"erro": "Autor não encontrado"}), 404
    autores[id].update(request.get_json())
    return jsonify({"mensagem": "Autor atualizado", "autor": autores[id]})

@app.route('/autores/<int:id>', methods=['DELETE'])
def delete_autor(id):
    if id not in autores:
        return jsonify({"erro": "Autor não encontrado"}), 404
    del autores[id]
    return jsonify({"mensagem": "Autor removido"})

# Rotas para Livros
@app.route('/livros/<int:id>', methods=['GET'])
def get_livro(id):
    return jsonify(livros.get(id, {"erro": "Livro não encontrado"}))

@app.route('/livros', methods=['POST'])
def add_livro():
    data = request.get_json()
    novo_id = max(livros.keys(), default=0) + 1
    livros[novo_id] = data
    return jsonify({"mensagem": "Livro adicionado", "livro": livros[novo_id]}), 201

@app.route('/livros/<int:id>', methods=['PUT'])
def atualizar_livro(id):
    if id not in livros:
        return jsonify({"erro": "Livro não encontrado"}), 404
    livros[id].update(request.get_json())
    return jsonify({"mensagem": "Livro atualizado", "livro": livros[id]})

@app.route('/livros/<int:id>', methods=['DELETE'])
def delete_livro(id):
    if id not in livros:
        return jsonify({"erro": "Livro não encontrado"}), 404
    del livros[id]
    return jsonify({"mensagem": "Livro removido"})

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
