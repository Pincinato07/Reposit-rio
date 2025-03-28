import 'dart:io';

enum EnumPriority { Alta, Media, Baixa }

class Task {
  int id;
  String name;
  EnumPriority priority;
  DateTime date;

  Task(this.id, this.name, this.priority, this.date);

  @override
  String toString() {
    return '[$id] $name - Prioridade: ${priority.name} - Criada em: ${date.toLocal()}';
  }
}

abstract class TaskRepository {
  void add(Task task);
  bool remove(int id);
  bool update(int id);
  Task? findById(int id);
  Task? findByName(String name);
  List<Task> getAllTasks();
  List<Task> getTaskByPriority();
}

class TaskRepositoryFromList implements TaskRepository {
  List<Task> tasks = [];

  @override
  void add(Task task) => tasks.add(task);

  @override
  bool remove(int id) {
    Task? task = findById(id);
    if (task != null) {
      tasks.remove(task);
      return true;
    }
    return false;
  }

  @override
  bool update(int id) {
    Task? task = findById(id);
    if (task == null) return false;

    print('\nAtualizando tarefa: ${task.name}');
    stdout.write('Novo nome (pressione Enter para manter o atual): ');
    String? newName = stdin.readLineSync();
    if (newName != null && newName.isNotEmpty) {
      task.name = newName;
    }

    stdout.write('Deseja alterar a prioridade? (s/n): ');
    String? changePriority = stdin.readLineSync();
    if (changePriority?.toLowerCase() == 's') {
      task.priority = getPriorityFromInput();
    }

    return true;
  }

  @override
  Task? findById(int id) {
    try {
      return tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Task? findByName(String name) {
    try {
      return tasks.firstWhere((task) => task.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  @override
  List<Task> getAllTasks() => List.unmodifiable(tasks);

  @override
  List<Task> getTaskByPriority() {
    List<Task> sortedTasks = List.from(tasks);
    sortedTasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return sortedTasks;
  }
}

EnumPriority getPriorityFromInput() {
  print('Escolha a prioridade:');
  print('1. Alta');
  print('2. Média');
  print('3. Baixa');
  stdout.write('Digite o número da prioridade: ');
  int choice = int.tryParse(stdin.readLineSync() ?? '') ?? 2;

  switch (choice) {
    case 1:
      return EnumPriority.Alta;
    case 2:
      return EnumPriority.Media;
    case 3:
      return EnumPriority.Baixa;
    default:
      print('Opção inválida! Definindo prioridade como Média.');
      return EnumPriority.Media;
  }
}

void showMenu() {
  print('\n=== Gerenciador de Tarefas ===');
  print('1. Adicionar tarefa');
  print('2. Remover tarefa');
  print('3. Atualizar tarefa');
  print('4. Buscar tarefa por ID');
  print('5. Buscar tarefa por nome');
  print('6. Listar todas as tarefas');
  print('7. Listar tarefas por prioridade');
  print('8. Sair');
  stdout.write('Escolha uma opção: ');
}

void main() {
  var repo = TaskRepositoryFromList();
  bool running = true;

  while (running) {
    showMenu();
    int choice = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    switch (choice) {
      case 1:
        stdout.write('ID da tarefa: ');
        int id = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
        stdout.write('Nome da tarefa: ');
        String? name = stdin.readLineSync();
        if (name == null || name.isEmpty) {
          print('Nome inválido! Tente novamente.');
          continue;
        }
        EnumPriority priority = getPriorityFromInput();
        repo.add(Task(id, name, priority, DateTime.now()));
        print('Tarefa adicionada.');
        break;

      case 2:
        stdout.write('ID da tarefa a remover: ');
        int id = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
        if (repo.remove(id)) {
          print('Tarefa removida.');
        } else {
          print('Tarefa não encontrada.');
        }
        break;

      case 3:
        stdout.write('ID da tarefa a atualizar: ');
        int id = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
        if (repo.update(id)) {
          print('Tarefa atualizada.');
        } else {
          print('Tarefa não encontrada.');
        }
        break;

      case 4:
        stdout.write('ID da tarefa: ');
        int id = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
        Task? task = repo.findById(id);
        print(task ?? 'Tarefa não encontrada.');
        break;

      case 5:
        stdout.write('Nome da tarefa: ');
        String? name = stdin.readLineSync();
        if (name == null || name.isEmpty) {
          print('Nome inválido!');
          continue;
        }
        Task? task = repo.findByName(name);
        print(task ?? 'Tarefa não encontrada.');
        break;

      case 6:
        List<Task> tasks = repo.getAllTasks();
        if (tasks.isEmpty) {
          print('Nenhuma tarefa registrada.');
        } else {
          print('Tarefas cadastradas:');
          tasks.forEach(print);
        }
        break;

      case 7:
        List<Task> tasks = repo.getTaskByPriority();
        if (tasks.isEmpty) {
          print('Nenhuma tarefa registrada.');
        } else {
          print('Tarefas ordenadas por prioridade:');
          tasks.forEach(print);
        }
        break;

      case 8:
        print('Saindo...');
        running = false;
        break;

      default:
        print('Opção inválida! Tente novamente.');
    }
  }
}