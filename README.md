# flutter_2_todo_app

A shiny version of the Todo App.

This project is an updated version of the Todo App I've done in the past. The new features are as follows:
- Full use of Stateless widgets instead of methods returning widgets.
- Managing List of items on the ListItemWidget instead of the root Widget.
  - This means using a GlobalKey to access the navigation method, in the child Widget, for the FloatingActionButton.
- Using CheckBoxListTile for CheckBox Animation.
- Using Dismissible for both removing and editing items.
- Using Google's MontSerrat font for a nicer UI.
- Less shocking choice of colors.

This also means I will be making a new video for this app.

## Getting Started with Flutter

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
