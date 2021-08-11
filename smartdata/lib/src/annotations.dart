/// Annotate your method with this annotation, and run the generator to automatically generate datagenerators for the given types in [forClasses].
class SmartdataInit {
  final List<Type> forClasses;
  const SmartdataInit({required this.forClasses});
}
