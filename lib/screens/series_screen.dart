import 'package:entertainmenttracker/model/series.dart';
import 'package:entertainmenttracker/widgets/filter_button.dart';
import 'package:entertainmenttracker/widgets/series_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../networking/networking.dart';
import 'package:http/http.dart' as http;

class SeriesScreen extends StatefulWidget {
  static const String id = 'series_screen';

  @override
  _SeriesScreenState createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  String filterSelected = 'popular';
  List<bool> buttonPressed = [true, false, false, false];

  ScrollController _scrollController;

  void onButtonPressed(String apiFilterName, int index) {
    setState(() {
      filterSelected = apiFilterName;
      for (int i = 0; i < buttonPressed.length; i++) {
        if (i == index) {
          buttonPressed[i] = true;
        } else {
          buttonPressed[i] = false;
        }
      }
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Series'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 2.0,
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FilterButton(
                  colour:
                      buttonPressed[0] ? Color(0xFFFFC491) : Colors.transparent,
                  textColour:
                      buttonPressed[0] ? Color(0xFF2E2D2D) : Color(0xFFA2A2A2),
                  filterName: 'Popular',
                  onPressed: () => onButtonPressed('popular', 0),
                ),
                FilterButton(
                  colour:
                      buttonPressed[1] ? Color(0xFFFFC491) : Colors.transparent,
                  textColour:
                      buttonPressed[1] ? Color(0xFF2E2D2D) : Color(0xFFA2A2A2),
                  filterName: 'Airing Today',
                  onPressed: () => onButtonPressed('airing_today', 1),
                ),
                FilterButton(
                  colour:
                      buttonPressed[2] ? Color(0xFFFFC491) : Colors.transparent,
                  textColour:
                      buttonPressed[2] ? Color(0xFF2E2D2D) : Color(0xFFA2A2A2),
                  filterName: 'On TV',
                  onPressed: () => onButtonPressed('on_the_air', 2),
                ),
                FilterButton(
                  colour:
                      buttonPressed[3] ? Color(0xFFFFC491) : Colors.transparent,
                  textColour:
                      buttonPressed[3] ? Color(0xFF2E2D2D) : Color(0xFFA2A2A2),
                  filterName: 'Top Rated',
                  onPressed: () => onButtonPressed('top_rated', 3),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Series>>(
                future:
                    NetworkHelper.fetchSeries(http.Client(), filterSelected),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? SeriesGridList(
                          series: snapshot.data,
                          scrollController: _scrollController,
                        )
                      : Center(
                          child: SpinKitDoubleBounce(
                            color: Colors.white,
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
