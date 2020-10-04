import 'package:flutter_blocexample/models/ImageForm.dart';
import 'package:flutter_blocexample/models/ListingForm.dart';

class ListingRepository {
  ListingForm loadListing() {
    return ListingForm(
      imageFormList: [ImageForm(isEmpty: true)],
    );
  }
}
