part of 'categories_bloc.dart';

abstract class CategoriesEvent {
  const CategoriesEvent();
}

class CategoriesEventLoad extends CategoriesEvent {
  const CategoriesEventLoad();
}

class CategoriesEventReset extends CategoriesEvent {
  const CategoriesEventReset();
}
