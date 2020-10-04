import 'package:equatable/equatable.dart';
import 'package:flutter_blocexample/models/ImageForm.dart';

class ListingForm extends Equatable {
// Note that I will have multiple other attributes for listing form
  final List<ImageForm> imageFormList;

  const ListingForm({
    this.imageFormList = const [],
  });

  @override
  List<Object> get props => [imageFormList];
}
