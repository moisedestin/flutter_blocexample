import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blocexample/data/ListingRepository.dart';
import 'package:flutter_blocexample/models/ImageForm.dart';
import 'package:flutter_blocexample/models/ListingForm.dart';
import 'package:meta/meta.dart';

part 'ListingFormEvent.dart';
part 'ListingFormState.dart';

class ListingFormBloc extends Bloc<ListingFormEvent, ListingFormState> {


  final ListingRepository listingRepository = ListingRepository();


  ListingFormBloc() : super( ListingFormInitialState());

  @override
  void onTransition(Transition<ListingFormEvent, ListingFormState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<ListingFormState> mapEventToState(ListingFormEvent event) async* {


    if (event is InitImageFormList) {
      final ListingForm listingForm = listingRepository.loadListing();
      yield ListingFormLoaded(listingForm);
    }

    else if (event is AddNewImage) {

      final ListingForm listingForm =  state.listingForm ;

      listingForm.imageFormList.add(new ImageForm(image: event.imageForm.image));

//      yield ListingFormLoaded( listingForm);

      yield  state.copyWith(
        listingForm:  listingForm,
      );

    }

  }
}