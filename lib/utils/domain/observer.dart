abstract class Observer {
  void update();
}

class Observable {
  List<Observer> observers = [];

  void addObserver(Observer observer) {
    observers.add(observer);
  }

  void removeObserver(Observer observer) {
    observers.remove(observer);
  }
}
