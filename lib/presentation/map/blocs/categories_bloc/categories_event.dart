part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class CategoriesEventLoad extends CategoriesEvent {
  const CategoriesEventLoad();
}

class CategoriesEventReset extends CategoriesEvent {
  const CategoriesEventReset();
}
