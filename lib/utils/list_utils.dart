class ListUtils {
  const ListUtils._();

  static void addNonNull(List<Object> list, Object item) {
    if (item != null) {
      list.add(item);
    }
  }

  static List<T> toListFromMap<T>(Object object, ListMapItemBuilder<T> f,
      [bool returnNonNullList = false, bool acceptNullItems = false]) {
    if (object is List) {
      List<T> list = [];

      for (var item in object) {
        if (acceptNullItems == true || item != null) {
          addNonNull(list, f(item));
        }
      }

      return list;
    }

    if (returnNonNullList == true) {
      return List(0);
    } else {
      return null;
    }
  }

  static List<O> toListFromObject<I, O>(List<I> object, ListItemBuilder<I, O> f,
      [bool returnNonNullList = false, bool acceptNullItems = false]) {
    if (object != null) {
      List<O> list = [];

      for (var item in object) {
        if (acceptNullItems == true || item != null) {
          addNonNull(list, f(item));
        }
      }

      return list;
    }

    if (returnNonNullList == true) {
      return List(0);
    } else {
      return null;
    }
  }
}

typedef ListMapItemBuilder<T> = T Function(Map<String, Object> object);

typedef ListItemBuilder<I, O> = O Function(I object);
