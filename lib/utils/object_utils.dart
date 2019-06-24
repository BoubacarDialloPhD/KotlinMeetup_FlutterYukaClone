class ObjectUtils {
  const ObjectUtils._();

  static T extract<T>(Object object, ObjectBuilder<T> f) {
    try {
      return f(object);
    } catch (e) {
      return null;
    }
  }
}

typedef ObjectBuilder<T> = T Function(Map<String, Object> object);
