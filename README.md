# pull_point

A new Flutter project.

## bloc

You should emit initial state before emit state you want. Something like this

Future<void> _selectTab(SelectTabEvent event, Emitter<HomeState> emit) async {
    emit(const InitialState());
    emit(TabSelectedState(tabIndex: event.tabIndex));
}

### Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
