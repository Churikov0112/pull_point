# pull_point

Pull Point flutter app for street artists

## bloc

You should emit initial state before emit state you want. Something like this

emit(const InitialState());
emit(TabSelectedState(tabIndex: event.tabIndex));

### Flutter Version

3.10.5
