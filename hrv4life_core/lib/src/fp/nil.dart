// representação de um valor nulo

class Nil {
  @override
  String toString() {
    return 'Nil{}';
  }
}

Nil get nil => Nil();
