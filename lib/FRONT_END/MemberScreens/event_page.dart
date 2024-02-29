import 'dart:collection';

import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/event_source_directory/add_event.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/event_source_directory/edit_event.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/event_source_directory/event_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'screen_pages/event_source_directory/event_source.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _events;

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents(_selectedDay);
  }

  _loadFirestoreEvents(DateTime selectedDay) async {
    final selectedDayStart = DateTime(selectedDay.year, selectedDay.month, selectedDay.day, 0, 0, 0);
    final selectedDayEnd = DateTime(selectedDay.year, selectedDay.month, selectedDay.day, 23, 59, 59);
    _events = {};

    final snap = await FirebaseFirestore.instance
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: selectedDayStart)
        .where('date', isLessThanOrEqualTo: selectedDayEnd)
        .get();
    for (var doc in snap.docs) {
      final event = Event.fromFirestore(doc.data(), doc.id);

      final day = DateTime.utc(
        event.date.year,
        event.date.month,
        event.date.day,
      );
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }

    setState(() {});
  }

  List<Event> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar App')),
      body: ListView(
        children: [
          TableCalendar(
            eventLoader: _getEventsForTheDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            focusedDay: _focusedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) async {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              await _loadFirestoreEvents(selectedDay);
            },
            calendarStyle: const CalendarStyle(
              weekendTextStyle: TextStyle(color: Colors.red),
              selectedDecoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.red),
            ),
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) => Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(_selectedDay.toString()), // Display selected day in header title
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _events.length,
            itemBuilder: (context, index) {
              final day = _events.keys.elementAt(index);
              final eventsForDay = _events[day]!;
              return Column(
                children: [
                  Text('Events for ${DateFormat('MMMM d, yyyy').format(day)}'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: eventsForDay.length,
                    itemBuilder: (context, index) {
                      final event = eventsForDay[index];
                      return ListTile(
                        title: Text(event.eventType),
                        subtitle: Text(event.description),
                        onTap: () async {
                          final res = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditEvent(
                                firstDate: _firstDay,
                                lastDate: _lastDay,
                                event: event,
                              ),
                            ),
                          );
                          if (res ?? false) {
                            _loadFirestoreEvents(_selectedDay);
                          }
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),

    );
  }
}
