import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
//     final payload = payloadFromJson(jsonString);
import 'dart:convert';
import 'package:johir_bhai_work/bloc/slider_bloc.dart';
import 'package:johir_bhai_work/repository.dart';

List<Payload> payloadFromJson(String str) =>
    List<Payload>.from(json.decode(str).map((x) => Payload.fromJson(x)));

String payloadToJson(List<Payload> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payload {
  String sponsorlogo;

  Payload({
    this.sponsorlogo,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        sponsorlogo: json["sponsorlogo"] == null ? null : json["sponsorlogo"],
      );

  Map<String, dynamic> toJson() => {
        "sponsorlogo": sponsorlogo == null ? null : sponsorlogo,
      };
}

void main() {
  runApp(BlocProvider(
    create: (_) => SliderBloc(repository: Repository())..add(FetchSlider()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SponsorSlider(),
    );
  }
}

class SponsorSlider extends StatefulWidget {
  @override
  _SponsorSliderState createState() => _SponsorSliderState();
}

class _SponsorSliderState extends State<SponsorSlider> {
  SliderBloc _sliderBloc;

  @override
  void initState() {
    _sliderBloc = context.read<SliderBloc>();
    _sliderBloc.add(FetchSlider());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Card(
          child:
              BlocBuilder<SliderBloc, SliderState>(builder: (context, state) {
            if (state is SliderLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SliderFailure) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else if (state is SliderLoaded) {
              if (state.payload != null) {
                print(state.payload[1].sponsorlogo);
                return SponsorList(
                  list: state.payload,
                );
              }
            }

            return Container();
          }),
        ),
      ),
    );
  }
}

class SponsorList extends StatefulWidget {
  final List<Payload> list;
  SponsorList({this.list});

  @override
  _SponsorListState createState() => _SponsorListState();
}

class _SponsorListState extends State<SponsorList> {
  int _current = 0;

  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            height: 200.0,
            initialPage: 0,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            reverse: false,
            items: widget.list.map((imageUrl) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Image.network(
                    imageUrl.sponsorlogo,
                    fit: BoxFit.fill,
                  ),
                );
              });
            }).toList(),
          )
        ],
      ),
    );
  }
}
