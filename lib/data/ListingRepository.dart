import 'package:flutter_blocexample/models/ImageForm.dart';
import 'package:flutter_blocexample/models/ListingForm.dart';

class ListingRepository {
  static final ListingRepository _singletonListingRepository =
  ListingRepository._internal();

  factory ListingRepository() {
    return _singletonListingRepository;
  }

  ListingRepository._internal();

  ListingForm loadListing(){

    ListingForm listingForm = ListingForm(
      imageFormList: <ImageForm>[
        new ImageForm(isEmpty: true)
      ],
    );

    return listingForm;
  }
}