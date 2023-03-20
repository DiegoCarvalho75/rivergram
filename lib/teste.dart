import 'dart:collection';

void main() {
  // create a cache of data
  final Map<String, String> cache = {
    'user1': 'John Smith',
    'user2': 'Jane Doe',
    'user3': 'Bob Johnson',
  };

  // create a MapView from the cache
  final MapView<String, String> cacheView = MapView<String, String>(cache);

  // use the cache in different parts of your code
  print('User 1: ${cacheView['user1']}'); // prints "User 1: John Smith"
  print('User 2: ${cacheView['user2']}'); // prints "User 2: Jane Doe"

  // try to modify the cache through the MapView
  try {
    cacheView['user4'] = 'Alice Smith'; // throws an exception
  } catch (e) {
    print(
        'Error: $e'); // prints "Error: Unsupported operation: Cannot set value in non-extendable view"
  }

  print("cacheView ${cacheView}");
}
