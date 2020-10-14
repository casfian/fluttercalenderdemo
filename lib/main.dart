import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calendar Demo'),
        ),
        body: Container(
          child: CalendarPage(),
        ),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

//This one you can JSON
List<DateTime> presentDates = [
  DateTime(2020, 10, 1),
  DateTime(2020, 10, 3),
  DateTime(2020, 10, 4),
  DateTime(2020, 10, 5),
  DateTime(2020, 10, 6),
  DateTime(2020, 10, 9),
  DateTime(2020, 10, 10),
  DateTime(2020, 10, 11),
  DateTime(2020, 10, 15),
  DateTime(2020, 10, 11),
  DateTime(2020, 10, 15),
  DateTime(2020, 10, 19),
];

//This one you can JSON
List<DateTime> absentDates = [
  DateTime(2020, 10, 2),
  DateTime(2020, 10, 7),
  DateTime(2020, 10, 8),
  DateTime(2020, 10, 12),
  DateTime(2020, 10, 13),
  DateTime(2020, 10, 14),
  DateTime(2020, 10, 16),
  DateTime(2020, 10, 17),
  DateTime(2020, 10, 18),
  DateTime(2020, 10, 17),
  DateTime(2020, 10, 18),
  DateTime(2020, 10, 20),
];

class _CalendarPageState extends State<CalendarPage> {
  
  static Widget _presentIcon(String day) => Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(
            Radius.circular(1000),
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
  static Widget _absentIcon(String day) => Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(1000),
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  /*
  //example for the above EventList for Day
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );
  */

  CalendarCarousel _calendarCarouselNoHeader;

  //get the numbers of days for the loops
  var lenPresent = presentDates.length;
  var lenAbsent = absentDates.length;

  double cHeight;

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < lenPresent; i++) {
      _markedDateMap.add(
        presentDates[i],
        Event(
          date: presentDates[i],
          title: 'Day Present',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );}

      for (int i = 0; i < lenAbsent; i++) {
        _markedDateMap.add(
          absentDates[i],
          Event(
            date: absentDates[i],
            title: 'Day Absent',
            icon: _absentIcon(
              absentDates[i].day.toString(),
            ),
          ),
        );
      }
    

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.54,
      weekendTextStyle: TextStyle(
        color: Colors.grey,
      ),
      todayButtonColor: Colors.blue,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal:
          null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          _calendarCarouselNoHeader,
            markerRepresent(Colors.red, "Absent"),
            markerRepresent(Colors.green, "Present"),
          ],
        ),
      
    );
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        radius: cHeight * 0.022,
      ),
      title: new Text(
        data,
      ),
    );
  }
}