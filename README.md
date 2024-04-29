# pull_point

Pull Point Flutter app for street artists and audience

## bloc

You should emit initial state before emit state you want. Something like this

emit(const InitialState());
emit(TabSelectedState(tabIndex: event.tabIndex));

### Flutter Version

3.10.5
