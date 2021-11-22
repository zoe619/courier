import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tcourier/Model/receipt_dashboard_model.dart';
import 'package:tcourier/utils/margin_utils.dart';

class ShowDateRanges extends StatelessWidget {
  final String dateRanges;
  const ShowDateRanges({
    Key key,
    this.dateRanges,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          XMargin(10),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          ),
          XMargin(5),
          Text(
            dateRanges,
            style: TextStyle(color: Colors.white, fontSize: 12),
          )
        ],
      ),
    );
  }
}

class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  // final dynamic lastWeekSales, currentWeekSales;

  final List<Revenue> charts;

  BarChartSample1({
    Key key,
    this.charts,
    //  this.lastWeekSales, this.currentWeekSales,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf).withOpacity(0.3); //Colors.white,
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        color: const Color(0xff2c4260),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Spacer(),
                      ShowDateRanges(dateRanges: "Last 7 days"),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(widget.charts),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.green,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(List<Revenue> charts) => List.generate(charts.length, (i) {
        // print("widget total $i  ${charts[i].total}");
        switch (i) {
          case 0:
            return makeGroupData(0, double.parse(charts[i].total.toString()),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, double.parse(charts[i].total.toString()),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, double.parse(charts[i].total.toString()),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, double.parse(charts[i].total.toString()),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, double.parse(charts[i].total.toString()),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, double.parse(charts[i].total.toString()),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, double.parse(charts[i].total.toString()),
                isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, double.parse(charts[i].total.toString()),
                isTouched: i == touchedIndex);

          default:
            return throw Error();
        }
      });

  BarChartData mainBarData(List<Revenue> charts) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return charts[value.toInt()].day.substring(0, 1);
              case 1:
                return charts[value.toInt()].day.substring(0, 1);
              case 2:
                return charts[value.toInt()].day.substring(0, 1);
              case 3:
                return charts[value.toInt()].day.substring(0, 1);
              case 4:
                return charts[value.toInt()].day.substring(0, 1);
              case 5:
                return charts[value.toInt()].day.substring(0, 1);
              case 6:
                return charts[value.toInt()].day.substring(0, 1);
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(charts),
    );
  }
}
