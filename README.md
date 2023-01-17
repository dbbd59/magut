# Magut

Set of utilities for Dart and Flutter

> from Lombard: laborer/apprentice [magut wiki](<https://it.wiktionary.org/wiki/mag%C3%BCtt>)

[![style: ficcanaso](https://img.shields.io/badge/style-ficcanaso-yellow)](https://github.com/dbbd59/ficcanaso)

Utilities

## Installation 💻

Add `magut` to your `pubspec.yaml`:

```yaml
dependencies:
  magut:
```

Install it:

```sh
dart pub get
```

---

## String Extension

> This library provides additional functionality to the built-in String class in Dart.

The following methods are included:

 - `reverse()`: returns the string reversed.
 - `capitalize()`: returns the string with the first letter capitalized.
 - `isPalindrome()`: returns a boolean indicating whether the
 - `titleCase()`: returns the string in title case (first letter of each word capitalized).

Usage
First, import the library by adding the following line to the top of your Dart file:

```dart
import 'package:string_extension/string_extension.dart';
```

Then, you can use the provided methods on any String object:

```dart
String word = "example";
print(word.reverse()); // "elpmaxE"
print(word.capitalize()); // "Example"
print(word.isPalindrome()); // false
print(word.titleCase()); // "Example"
```

>Note that the titleCase() method also replaces multiple spaces with a single space, and trims leading and trailing whitespace.

You can also chain methods together:

```dart
print(word.reverse().capitalize()); // "Epmaxel"
```

Additional Information

This library was created using the extension keyword, which allows you to add functionality to a class without modifying its source code. This makes it easy to use and maintain.

---

## DateTime extention


This Dart code contains a `DateTimeApp` class and a `DateTimeExtension` extension on the built-in `DateTime` class. The `DateTimeApp` class provides a static method to retrieve the current date and time, and another static method to set a custom date and time to be used as the current date and time. The `DateTimeExtension` extension adds several additional methods to the `DateTime` class for determining whether a date is today, tomorrow, or in the past, as well as for determining the number of months that have passed since a given date.

### Usage

### DateTimeApp
To use the `DateTimeApp` class, you can simply call the `now()` method to get the current date and time, or the `setCustomDateTime(DateTime value)` method to set a custom date and time to be used as the current date and time.

```dart
DateTime currentTime = DateTimeApp.now();
DateTimeApp.setCustomDateTime(DateTime(2022, 1, 1));
```
### DateTimeExtension
The DateTimeExtension extension adds several additional methods to the DateTime class that you can use as follows:

 - `isToday()` : Returns true if the date is today.
 - `isTomorrow()` : Returns true if the date is tomorrow.
 - `isSameDay(DateTime other)` : Returns true if the date is the same day as the given date.
 - `isSameMonth(DateTime other)` : Returns true if the date is in the same month as the given date.
 - `getMonthsPassed()` : Returns the number of months passed since the date.
 - `isPast()` : Returns true if the date is in the past.

```dart
DateTime date = DateTime(2022, 1, 1);
bool today = date.isToday();
bool sameDay = date.isSameDay(DateTime.now());
```

#### Note
`setCustomDateTime` method will set the custom date time for entire app and it will be used by all DateTimeExtension method for comparison.
The `getMonthsPassed()` method uses the inDays property of the Duration class to calculate the number of months passed since the date, which assumes that all months have 30 days.

---

## CalendarUtils

A Dart library that provides utility functions for working with dates and calendars.

### Methods

- `addMonth(DateTime dateTime, int index)`: Adds the given number of months to the given date and returns the resulting date.
- `daysInRange(DateTime first, DateTime last)`: Returns a list of all days between the first and last dates, inclusive.
- `formatDateTimeToMonthYear(DateTime monthAndYear)`: Formats the given date as a string in the format "MMMM yyyy".
- `formatDateTimeToMonth(DateTime monthAndYear)`: Formats the given date as a string in the format "MMMM".
- `formatDateTimeToYear(DateTime monthAndYear)`: Formats the given date as a string in the format "yyyy".
- `getDaysOfWeek(String locale)`: Returns a list of short names for the days of the week in the given locale, starting with Monday.
- `getMonthAndYearFromIndex(int index)`: Returns the month and year corresponding to the given index, with 0 being the current month and year.
- `getMonthAndYearStringFromIndex(int index)`: Returns a string representation of the month and year corresponding to the given index, in the format "MMMM yyyy".

---

## LocalStorage

A Dart library that provides a wrapper for working with `SharedPreferences` for storing key-value pairs.

### Methods

- `init()`: Initializes the shared preferences object. This must be called before any other methods can be used.
- `getString(String key)`: Returns the value associated with the given key as a string. Returns `null` if the key is not found.
- `setString(String key, String value)`: Sets the value for the given key as a string. Returns a `Future<bool>` indicating success of the operation.
- `remove(String key)`: Removes the key-value pair associated with the given key. Returns a `Future<bool>` indicating success of the operation.
- `clear({List<String> whiteList = const []})`: Clears all key-value pairs, except those in the provided whitelist. Returns a `Future<void>`.
- `clearOnlyKeysWithPrefix(String prefix)`: Clear only key-value pairs that have the prefix provided. Returns a `Future<void>`.
- `getBool(String key)`: Returns the value associated with the given key as a boolean. Returns `null` if the key is not found.
- `setBool(String key, bool value)`: Sets the value for the given key as a boolean. Returns a `Future<bool>` indicating success of the operation.
- `getKeys()`: Returns a set of all keys in the shared preferences.
- `get(String key)`: Returns the value associated with the given key as an `Object`. Returns `null` if the key is not found.

---

## RestClient

A Dart library that provides a simple way to make HTTP requests using the `http` package. It includes options for authentication, caching, and custom endpoints.

### Properties

- `httpClient`: An instance of `http.Client` to use for making requests.
- `onTokenExpired`: A callback function that is called when an authenticated request is made and the token is expired.

### Methods

- `get({String api, String? endpoint, bool authenticated = true, CachingStrategy? cachingStrategy})`: Makes a GET request to the specified API endpoint. 
- `post({String api, Map<String, dynamic>? body, String? endpoint, bool authenticated = true})`: Makes a POST request to the specified API endpoint with the given JSON-encoded body. 
- `put({String api, Map<String, dynamic>? body, String? endpoint, bool authenticated = true})`: Makes a PUT request to the specified API endpoint with the given JSON-encoded body.
- `_getHeaders(bool authenticated)`: Returns headers for the requests, including an "Authorization" header with a JSON Web Token if the request is authenticated.
- `_getEndpoint(String? endpoint)`: Returns the endpoint for the request. If an endpoint is not provided, it will fallback to the endpoint defined in the dotenv file.

---

## NetworkCache

A Dart library that provides a caching mechanism for network requests. It includes options for cache expiration and custom caching strategies.

### Properties

- `cacheKey`: A unique key to identify the cache.
- `networkRequest`: A function that returns a `Future<http.Response>` representing the network request.
- `cachingStrategy`: A custom caching strategy. Default is `ExpiryCache()` which expires cache after 24 hours.

### Methods

- `getOrUpdate({String cacheKey, Function networkRequest, CachingStrategy cachingStrategy = const ExpiryCache()})`: Returns the cached response if it exists, otherwise it will perform the network request and cache the response.
- `cleanCache(CachingStrategy cachingStrategy)`: Cleans the cache by removing items whose keys start with `kCacheMagutString` and have expired according to the specified caching strategy.

### ExpiryCache

A caching strategy that expires the cache after a specified duration.

##### Properties

- `duration`: The duration after which the cache expires. Default is `Duration(hours: 24)`.

##### Methods

- `get(Function networkRequest, String key)`: Returns the cached response if it exists and has not expired, otherwise it will perform the network request and cache the response.
- `getValueFromStorage(String key)`: Returns the cached value from storage.
- `addToCache(http.Response networkValue, String key)`: adds the network value to the cache
- `hasCacheExpired(ResponseCacheItem cachedValue, Duration cacheDuration)`: returns true if the cached value has expired

---
