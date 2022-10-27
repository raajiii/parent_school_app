import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../const/colors.dart';
import '../../../const/contsants.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/utils.dart';

class SchoolCalenderScreen extends StatefulWidget {
  const SchoolCalenderScreen({Key? key}) : super(key: key);

  @override
  State<SchoolCalenderScreen> createState() => _SchoolCalenderScreenState();
}

class _SchoolCalenderScreenState extends State<SchoolCalenderScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar(Constants.SCHOOLCALENDER),
      body: Column(
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rowHeight: 75.0,
            headerStyle: const HeaderStyle(
              titleCentered: true,
              titleTextStyle:
                  TextStyle(fontSize: 17.0, color: AppColors.whiteColor),
              decoration: BoxDecoration(color: AppColors.darkPinkColor),
              headerMargin: EdgeInsets.only(top: 8.0, bottom: 8.0),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: AppColors.whiteColor,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: AppColors.whiteColor,
              ),
            ),
            calendarFormat: _calendarFormat,
            sixWeekMonthsEnforced: false,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              canMarkersOverflow: false,
              rangeHighlightScale: 0.5,
              markerSizeScale: 0.5,
              markersAnchor: 0.5,
              markersMaxCount: 1,
              rowDecoration: const BoxDecoration(
                  border: Border.fromBorderSide(BorderSide(
                      width: 0.5,
                      color: AppColors.greyColor,
                      style: BorderStyle.solid))),
              cellAlignment: Alignment.center,
              cellMargin: const EdgeInsets.all(10.0),
              markersAlignment:
                  const Alignment(0.0, 0.7).add(Alignment.bottomCenter),
              markerMargin: const EdgeInsets.symmetric(vertical: 10),
              markerDecoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        "https://spng.pinpng.com/pngs/s/27-278581_check-mark-computer-icons-clip-art-green-check.png",
                      ),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle),
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
