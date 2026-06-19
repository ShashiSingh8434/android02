# Flutter Todo App (Hive + MVVM)

A simple Flutter Todo application built to practice:

* Flutter UI Development
* Hive Local Database
* MVVM (Model-View-ViewModel) Architecture
* CRUD Operations
* Local Data Persistence

This project was created as a learning exercise to understand how data flows through a Flutter application using a clean architecture approach.

---

# Features

* Add Tasks
* Mark Tasks as Completed
* Delete Individual Tasks
* Delete All Tasks
* Persistent Local Storage using Hive
* MVVM Architecture Implementation

---

# Project Structure

```text
lib/
│
├── main.dart
│
└── features/
    └── todo/
        │
        ├── models/
        │   └── todo_model.dart
        │
        ├── repositories/
        │   └── todo_repository.dart
        │
        ├── viewmodels/
        │   └── todo_viewmodel.dart
        │
        └── views/
            └── todo_page.dart
```

---

# MVVM Architecture

The project follows the MVVM design pattern.

```text
User Interface (View)
        ↓
ViewModel
        ↓
Repository
        ↓
Hive Database
```

## Model

The Model represents the data structure used throughout the application.

```dart
class TodoModel {
  final String title;
  final String description;
  final bool isCompleted;
}
```

Responsibilities:

* Represents a Todo item.
* Converts data to and from Hive-compatible Maps.

---

## View

The View is responsible only for UI.

Examples:

* TextFields
* Buttons
* ListView

Responsibilities:

* Display data.
* Capture user input.
* Forward actions to the ViewModel.

The View does not communicate directly with Hive.

---

## ViewModel

The ViewModel contains business logic.

Examples:

* Add Todo
* Delete Todo
* Toggle Completion

Responsibilities:

* Receive user actions from the View.
* Call Repository methods.
* Notify the UI when data changes.

---

## Repository

The Repository acts as a bridge between the ViewModel and Hive.

Responsibilities:

* Add data to Hive.
* Read data from Hive.
* Update data.
* Delete data.

The ViewModel never directly interacts with Hive.

---

# Hive Integration

## Initialization

Hive is initialized before the app starts.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('info');

  runApp(const MyApp());
}
```

---

## Opening a Box

```dart
final Box box = Hive.box('info');
```

A Hive Box works similarly to a lightweight local database table.

---

## Storing Data

```dart
box.add(todo.toMap());
```

Data is converted into a Map before storage.

Example:

```json
{
  "title": "Learn Hive",
  "description": "Practice local storage",
  "isCompleted": false
}
```

---

## Reading Data

```dart
box.values
```

The Repository converts stored Maps back into TodoModel objects.

```dart
TodoModel.fromMap(...)
```

---

## Updating Data

```dart
box.putAt(index, updatedTodo.toMap());
```

Used when:

* Renaming tasks
* Marking tasks as completed

---

## Deleting Data

Delete a single task:

```dart
box.deleteAt(index);
```

Delete all tasks:

```dart
box.clear();
```

---

# Reactive UI Updates

Hive provides a listenable object.

```dart
box.listenable()
```

Used with:

```dart
ValueListenableBuilder
```

This allows the UI to automatically rebuild whenever data inside the Hive Box changes.

```dart
ValueListenableBuilder(
  valueListenable: box.listenable(),
  builder: (...)
)
```

No manual refresh is required.

---

# Data Flow Example

Adding a Todo:

```text
User Clicks Submit
        ↓
TodoPage
        ↓
TodoViewModel.addTodo()
        ↓
TodoRepository.addTodo()
        ↓
Hive Box
        ↓
ValueListenableBuilder Rebuilds UI
```

Marking a Todo as Completed:

```text
Checkbox Clicked
        ↓
TodoPage
        ↓
TodoViewModel.toggleComplete()
        ↓
TodoRepository.updateTodo()
        ↓
Hive Box Updated
        ↓
UI Refreshes Automatically
```

---

# What I Learned

Through this project I learned:

* How Hive stores local data in Flutter
* Difference between UI and business logic
* MVVM Architecture fundamentals
* Repository Pattern basics
* Reactive UI updates using ValueListenableBuilder
* CRUD operations with Hive
* Managing application state cleanly

---

# Future Improvements

* Hive TypeAdapters
* Riverpod State Management
* Task Categories
* Search Functionality
* Due Dates
* Task Priority Levels
* Dark Mode
* Offline-First Synchronization

---

# Conclusion

This project serves as a practical introduction to local data persistence and clean architecture in Flutter. It demonstrates how Hive can be integrated into an MVVM-based application to build maintainable and scalable Flutter applications.
