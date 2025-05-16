    class Animal {
      String name;

      Animal(this.name);

      void makeSound() {
        print("Generic animal sound");
      }
    }

    class Dog extends Animal {
      Dog(String name) : super(name); // Calls the superclass constructor

      @override
      void makeSound() {
        print("Woof!"); // Overrides the superclass method
      }
    }

    void main() {
      var dog = Dog("Buddy");
      print(dog.name); // Output: Buddy (inherited from Animal)
      dog.makeSound(); // Output: Woof! (Dog's overridden method)
    }