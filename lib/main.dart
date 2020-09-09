import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blocexample/models/ImageForm.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'bloc/ListingFormBloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  final ListingFormBloc _listingFormBloc = new ListingFormBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<ListingFormBloc>(
        create: (_) => _listingFormBloc,
        child: ListingFormPage(),
      ),
    );
  }
}




class ListingFormPage  extends   StatelessWidget {

  final _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {


    return BlocListener<ListingFormBloc, ListingFormState>(

      listener:(context, state){

      },
      child:  Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(

          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.30,

            child: BlocBuilder<ListingFormBloc,ListingFormState>(
                buildWhen: (previous, current){
                  print(previous.listingForm.imageFormList.length);
                  print(current.listingForm.imageFormList.length);
                  return previous.listingForm.imageFormList  != current.listingForm.imageFormList ;
                }   ,
                builder: (context, state) {


                  if(state is ListingFormInitialState){
                    context.bloc<ListingFormBloc>().add(InitImageFormList());

                  }

                  if(state is ListingFormLoaded){
                    return  ListView.builder(
                        shrinkWrap: true,

                        scrollDirection: Axis.horizontal,
                        itemCount: state.listingForm.imageFormList.length, itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 150,
                          width: 150,

                          child: GestureDetector(
                              child: Card(

                                  shape: RoundedRectangleBorder(side: BorderSide(
                                      width: 3, color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,

                                  child: _displayMedia(state.listingForm.imageFormList[index],context,index)
                              ),
                              onTap: () async {
                                var imgFile = await _picker.getImage(
                                    source: ImageSource.camera
                                );
                                File file = File(imgFile.path);


                                context.bloc<ListingFormBloc>().add(AddNewImage(imageForm: ImageForm(image: Image.file(file,  fit:BoxFit.cover,
                                  height: 400.0,))));


                              }
                          ),

                        ),



                      );
                    });
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
            ),

          ),

        ),

      ),
    ) ;
  }

}

Widget _displayMedia(ImageForm imgForm,BuildContext context,int indexCurrentElement) {
  if(imgForm.isEmpty) {
    return Icon(
      Icons.camera_alt,
      color: Colors.blue,
      size: 36.0,
    );
  }

  else {

    return
      Container(
        child: new Stack(children: <Widget>[
          new Container(
            width: double.infinity,
            height: double.infinity,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),child:imgForm.image),
          ),

          new Container(

            alignment: Alignment.topRight,
            child: IconButton(

              padding: EdgeInsets.all(0.0),
              icon: Icon( Icons.cancel,color: Colors.redAccent, size: 24.0,)
              ,onPressed: (){


            },)  ,
          ),

        ],
        ),
      );

  }

}
