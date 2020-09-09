part of 'ListingFormBloc.dart';


class ListingFormState extends Equatable {
  const ListingFormState({
    this.listingForm = const ListingForm() ,
  });


  final ListingForm listingForm;

  ListingFormState copyWith({
    ListingForm listingForm,
  }) {
    return ListingFormState(
      listingForm: listingForm ?? this.listingForm,
    );
  }

  @override
  List<Object> get props => [listingForm ];
}

class ListingFormInitialState extends ListingFormState{

  @override
  List<Object> get props => [ ];
}

class ListingFormLoaded extends ListingFormState{

  final ListingForm listingForm;

  ListingFormLoaded(this.listingForm) ;

  @override
  List<Object> get props => [listingForm];
}


