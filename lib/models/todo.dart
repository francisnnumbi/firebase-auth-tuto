class Todo {
  String id;
  String todoText;
  late bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'todoText': todoText,
        'isDone': isDone,
      };

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        todoText: json['todoText'],
        isDone: json['isDone'],
      );

  static List<Todo> todoList() {
    return [
      Todo(
        id: '1',
        todoText: 'Buy milk',
        isDone: true,
      ),
      Todo(
        id: '2',
        todoText: 'Buy eggs',
        isDone: false,
      ),
      Todo(
        id: '3',
        todoText: 'Buy bread',
        isDone: true,
      ),
      Todo(
        id: '4',
        todoText: 'Buy butter',
        isDone: true,
      ),
      Todo(
        id: '5',
        todoText: 'Buy cheese',
        isDone: false,
      ),
      Todo(
        id: '6',
        todoText: 'Buy milk',
        isDone: false,
      ),
      Todo(
        id: '7',
        todoText: 'Buy eggs',
        isDone: false,
      ),
      Todo(
        id: '8',
        todoText: 'Buy bread',
        isDone: false,
      ),
      Todo(
        id: '9',
        todoText: 'Buy butter',
        isDone: false,
      ),
      Todo(
        id: '10',
        todoText: 'Buy cheese',
        isDone: false,
      ),
      Todo(
        id: '11',
        todoText: 'Buy milk',
        isDone: false,
      ),
      Todo(
        id: '12',
        todoText: 'Buy eggs',
        isDone: false,
      ),
      Todo(
        id: '13',
        todoText: 'Buy bread',
        isDone: false,
      ),
      Todo(
        id: '14',
        todoText: 'Buy butter',
        isDone: false,
      ),
      Todo(
        id: '15',
        todoText: 'Buy cheese',
        isDone: false,
      ),
      Todo(
        id: '16',
        todoText: 'Buy milk',
        isDone: false,
      ),
      Todo(
        id: '17',
        todoText: 'Buy eggs',
        isDone: false,
      ),
      Todo(
        id: '18',
        todoText: 'Buy bread',
        isDone: false,
      ),
      Todo(
        id: '19',
        todoText: 'Buy butter',
        isDone: false,
      ),
      Todo(
        id: '20',
        todoText: 'Buy cheese',
        isDone: true,
      ),
    ];
  }
}
