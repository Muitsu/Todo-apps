import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/assets_color.dart';

class TodoWidget extends StatefulWidget {
  final String title;
  final bool? isComplete;
  final DateTime startDate;
  final DateTime endDate;
  final void Function()? onTap;
  final void Function(bool?)? onChanged;
  const TodoWidget({
    super.key,
    required this.title,
    required this.isComplete,
    required this.onChanged,
    required this.startDate,
    required this.endDate,
    this.onTap,
  });

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late Timer _timer;
  late String timeLeft;
  @override
  void initState() {
    super.initState();
    //calculate timeleft and update it every seconds
    _startCountdown();
  }

  void _startCountdown() {
    setState(() => timeLeft = _getTimeLeft());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(
        () {
          final Duration difference = widget.endDate.difference(DateTime.now());
          timeLeft = _getTimeLeft(diff: difference);
          if (difference.inSeconds > 0) {
            difference - const Duration(seconds: 1);
          } else {
            _timer.cancel();
          }
        },
      );
    });
  }

  _changeDateFormat({required DateTime date}) =>
      DateFormat('dd MMM yyyy').format(date);

  _getTimeLeft({Duration? diff}) {
    Duration difference = diff ?? widget.endDate.difference(DateTime.now());

    int hours = difference.inHours < 0 ? 0 : difference.inHours;
    int minutes = difference.inMinutes.remainder(60) < 0
        ? 0
        : difference.inMinutes.remainder(60);
    return '$hours hrs $minutes min';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.16))
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 18, 10, 0),
                    child: Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  GridView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 2,
                    ),
                    children: [
                      _todoData(
                          title: 'Start Date',
                          subtitle: _changeDateFormat(date: widget.startDate)),
                      _todoData(
                          title: 'End Date',
                          subtitle: _changeDateFormat(date: widget.endDate)),
                      _todoData(title: 'Time Left', subtitle: timeLeft),
                    ],
                  ),
                  Container(
                    color: AssetsColor.dimYellow,
                    child: CheckboxListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.only(left: 12, right: 4),
                      value: widget.isComplete,
                      onChanged: widget.onChanged,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Status    ',
                                  style: TextStyle(color: Colors.black54)),
                              TextSpan(
                                  text: widget.isComplete != null &&
                                          widget.isComplete == true
                                      ? 'Complete'
                                      : widget.isComplete != null &&
                                              widget.isComplete == false
                                          ? 'Incomplete'
                                          : '',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ),
                          const Text('Tick if complete')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _todoData({required String title, required String subtitle}) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
