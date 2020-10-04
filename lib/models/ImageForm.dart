import 'package:equatable/equatable.dart';

class ImageForm extends Equatable {
  final String imagePath;
  final bool isEmpty;

  ImageForm({
    this.imagePath,
    this.isEmpty = false,
  });

  @override
  List<Object> get props => [imagePath, isEmpty];
}
