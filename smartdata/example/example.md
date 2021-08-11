# Automatically generate your generators

Create your beans.

```dart
class Dog {
    final String breed;
    final int age;
    final String name;
    Dog(this.breed, this.age, this.name);
}
```
To generate a Datagenerator for this bean, you need to initialize it.

```dart
// dog_test.dart
@SmartdataInit(forClasses: [Dog])
void init() {
  $init();
}
```

Once you ran the generator, next to your _dog_test.dart_ a _dog_test.smart.dart_ will be generated.

```
dart run build_runner build
```

```dart
// dog_test.smart.dart
class DogGenerator extends Generator {
  @override
  Simple generateRandom() {
    final dog = Dog(
        Smartdata.I.getSingle<String>(),
        Smartdata.I.getSingle<int>(),
        Smartdata.I.getSingle<String>()
    );
    return dog;
  }
}

$init() {
  Smartdata.put(Dog, DogGenerator());
}
```

The Generator supports positional arguments, named arguments and property access via implicit and explicit setters.

The generated Class can then be used in your tests.
```dart
@SmartdataInit(forClasses: [Dog])
void init() {
  $init();
}

void main() {
  setUp(init); // make sure to call the init, to initialize the generator map
  test('should create lots of random dogs', () {
    final testData = Smartdata.I.get<Dog>(50);
    expect(testData.length, 50);
  });
}
```
# Manually create your generator
For flexibility or other reasons you can create your own generator.
Just implement the included _Generator_ class, and add an instance to the Smartdata singleton.
```dart
class CustomDogGenerator extends Generator<Dog> {
  Dog generateRandom() {
    return Dog('German Shepherd', 1, 'Donald'); // completely random
  }
}

void init() {
  // $init() in case you also want to initialize your automatically generated generators
  Smartdata.put(Dog, CustomDogGenerator());
}
```
And make sure to call init before running the test.
```dart
void main() {
  setUp(init); // make sure to call the init, to initialize the generator map
  test('should create lots of custom random dogs', () {
    final testData = Smartdata.I.get<Dog>(50);
    expect(testData.length, 50);
  });
}
```