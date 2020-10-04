part of 'ListingFormBloc.dart';

abstract class ListingFormEvent extends Equatable {
  const ListingFormEvent();

  @override
  List<Object> get props => [];
}

class InitImageFormList extends ListingFormEvent {
  const InitImageFormList({this.imageFormList});

  final List<ImageForm> imageFormList;

  @override
  List<Object> get props => [imageFormList];
}

class AddNewImage extends ListingFormEvent {
  final ImageForm imageForm;

  const AddNewImage({this.imageForm});

  @override
  List<Object> get props => [imageForm];
}
