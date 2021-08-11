# Smartdata - Creating Random Typesafe Test Data

Code generator for generating type-safe generators to generate a random amount of test data in dart

- [Overview](#overview)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [Roadmap](#roadmap)

# Overview

- Add smartdata as a dependency, and smartdata_generator as a dev_dependency
- Annotate your method with the @SmartdataInit Annotation and configure the classes for which to generate Datagenerators.
- Run the build_runner
- Use the generated Generator!

# Installation

Add smartdata as a dependency, and the generator as a dev_dependency.

https://pub.dev/packages/smartdata

```yaml
dependencies:
  smartdata: [version]

dev_dependencies:
  smartdata_generator: [version]
  # add build runner if not already added
  build_runner:
```

Run the generator

```console
dart run build_runner build
flutter packages pub run build_runner build
// or watch
flutter packages pub run build_runner watch
```

# Usage
There are 2 ways, on how to setup Smartdata.
You can automatically generate Datagenerators with the included _@SmartdataInit_ Annotation or manually create them.

## Automatically generate your generators

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
## Manually create your generator
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

# Implementation
How does it work? Behind the scenes is just a Generator class, which can be implemented by everyone.
```dart
abstract class Generator<T> {
  T generateRandom();
}
```
This package provides default implementations for common primitive types, such as Strings, ints, nums and booleans.
```dart
class StringGenerator extends Generator<String> {
  final _random = Random();
  final _strings = ['bulbasaur', 'ivysaur', 'venosaur'];
  @override
  String generateRandom() {
    return _strings[_random.nextInt(_strings.length)];
  }
}
```
These generators are maintained by a static Map, and can be accessed via the Smartdata Singleton.
```dart
// generates a list of 10 random strings
Smartdata.I.get<String>(10);
```

# Examples

Please refer to the [example](https://github.com/smotastic/smartdata/tree/master/example) package, for a list of examples and how to use the Smartdata.

You can always run the examples by navigating to the examples package and executing the generator.

```console
$ dart pub get
...
$ dart run build_runner build
```

# Roadmap
Feel free to open a [Pull Request](https://github.com/smotastic/smartdata/pulls), if you'd like to contribute.

Or just open an issue, and i do my level best to deliver.
