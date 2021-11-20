import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hackatum_sixt_flutter_app/global_state.dart';
import 'package:hackatum_sixt_flutter_app/models/ride_destination_model.dart';

class PlacesList extends StatefulWidget {
  PlacesList({Key? key, required this.query, required this.onSelect}) : super(key: key);

  @override
  State<PlacesList> createState() => _PlacesListState();
  final places = GoogleMapsPlaces(apiKey: "AIzaSyCLRBhbr9p-Y9hREdP-B4P3zz2f_K2GmJI");
  final RxString query;
  final Function(RideDestinationModel) onSelect;
}

class _PlacesListState extends State<PlacesList> {
  bool isLoading = false;
  List<Prediction> results = [];

  void searchForItems() async {
    setState(() {
      isLoading = true;
    });
    PlacesAutocompleteResponse response = await widget.places.queryAutocomplete(
      widget.query.value,
      language: "de",
      location: Location(
        lat: GlobalState.currentPosition.value!.latitude,
        lng: GlobalState.currentPosition.value!.longitude
      )
    );
    setState(() {
      results = response.predictions;
      isLoading = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      widget.query.listen((_) => searchForItems());
      searchForItems();
    });
    
    super.initState();
  }

  void select(Prediction item) async  {
     setState(() {
      isLoading = true;
    });
    PlacesDetailsResponse details = await widget.places.getDetailsByPlaceId(item.placeId!);
    widget.onSelect(RideDestinationModel(
      item.structuredFormatting!.mainText,
      item.structuredFormatting!.secondaryText!,
      details.result.geometry!.location.lat,
      details.result.geometry!.location.lng,
    ));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, i) {
          Prediction item = results[i];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18)
            ),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: Icon(Icons.place_rounded, size: 42, color: Color.fromRGBO(238, 127, 0, 1)),
              tileColor: Colors.transparent,
              title: Text(item.structuredFormatting!.mainText),
              subtitle: Text(item.structuredFormatting!.secondaryText!),
              onTap: () => select(item),
            )
          );
        }
      );
  }
}


