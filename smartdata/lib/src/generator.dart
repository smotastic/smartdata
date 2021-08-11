/// The base [Generator] of which all generators should inherit. Provides only one method to randomly generate an entity.
/// Should always be used in conjunction with the Smartdata singleton.
abstract class Generator<T> {
  T generateRandom();
}
