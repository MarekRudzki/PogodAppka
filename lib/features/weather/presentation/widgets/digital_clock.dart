/// This is a slide_digital_clock 1.0.3 package from pub_dev
/// It is saved as .dart file, not used as import package
/// Due to the need to use other DateTime than DateTime.now()
/// and to adjust colon timer which was not modifiable in original package

import 'dart:async';
import 'package:flutter/material.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({
    super.key,
    this.is24HourTimeFormat,
    this.showSecondsDigit,
    this.colon,
    this.colonDecoration,
    this.areaWidth,
    this.areaHeight,
    this.areaDecoration,
    this.areaAligment,
    this.hourDigitDecoration,
    this.minuteDigitDecoration,
    this.secondDigitDecoration,
    this.digitAnimationStyle,
    this.hourMinuteDigitTextStyle,
    this.secondDigitTextStyle,
    this.amPmDigitTextStyle,
    this.dateTime,
    this.colonTimerInMiliseconds,
  });

  /// added parameters
  final DateTime? dateTime;
  final int? colonTimerInMiliseconds;

  /// am or pm
  final bool? is24HourTimeFormat;

  /// if you want use seconds this variable should be true
  final bool? showSecondsDigit;

  /// use ":"  or create your widget
  final Widget? colon;
  // colon area decoraiton
  final BoxDecoration? colonDecoration;

  /// clock area width
  final double? areaWidth;

  ///clock area height
  final double? areaHeight;

  /// clock area decoration
  final BoxDecoration? areaDecoration;

  final AlignmentDirectional? areaAligment;

  /// hour decoration
  final BoxDecoration? hourDigitDecoration;

  /// minute decoration
  final BoxDecoration? minuteDigitDecoration;

  /// seconds decoration
  final BoxDecoration? secondDigitDecoration;

  /// animation style
  final Curve? digitAnimationStyle;

  /// hour text style
  final TextStyle? hourMinuteDigitTextStyle;

  /// seconds text style,
  final TextStyle? secondDigitTextStyle;

  /// am-pm text style
  final TextStyle? amPmDigitTextStyle;

  @override
  DigitalClockState createState() => DigitalClockState();
}

class DigitalClockState extends State<DigitalClock> {
  late DateTime _dateTime;
  late ClockModel _clockModel;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _dateTime = widget.dateTime!;
    _clockModel = ClockModel();
    _clockModel.is24HourFormat = widget.is24HourTimeFormat ?? true;

    _dateTime = widget.dateTime!;
    _clockModel.hour = _dateTime.hour;
    _clockModel.minute = _dateTime.minute;
    _clockModel.second = _dateTime.second;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _dateTime = DateTime(
        widget.dateTime!.year,
        widget.dateTime!.month,
        widget.dateTime!.day,
        widget.dateTime!.hour,
        widget.dateTime!.minute,
        widget.dateTime!.second + timer.tick,
      );
      _clockModel.hour = _dateTime.hour;
      _clockModel.minute = _dateTime.minute;
      _clockModel.second = _dateTime.second;

      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: widget.areaWidth,
        height: widget.areaHeight,
        child: Container(
          alignment: widget.areaAligment ?? AlignmentDirectional.bottomCenter,
          decoration: widget.areaDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _amPm,
              _hour(),
              Container(
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsets.all(1.0),
                padding: const EdgeInsets.all(2.0),
                decoration: widget.colonDecoration,
                child: ColonWidget(
                  colon: widget.colon,
                  colonTimer: widget.colonTimerInMiliseconds!,
                ),
              ),
              _minute,
              _second,
            ],
          ),
        ),
      ),
    );
  }

  Widget _hour() => Container(
        padding: const EdgeInsets.all(2),
        alignment: AlignmentDirectional.center,
        decoration: widget.hourDigitDecoration,
        child: SpinnerText(
          text: _clockModel.is24HourTimeFormat
              ? hTOhh_24hTrue(_clockModel.hour)
              : hTOhh_24hFalse(_clockModel.hour)[0],
          animationStyle: widget.digitAnimationStyle,
          textStyle: widget.hourMinuteDigitTextStyle ??
              Theme.of(context).textTheme.bodyLarge,
        ),
      );

  Widget get _minute => Container(
        padding: const EdgeInsets.all(2),
        alignment: AlignmentDirectional.center,
        decoration: widget.minuteDigitDecoration,
        child: SpinnerText(
          text: mTOmm(_clockModel.minute),
          animationStyle: widget.digitAnimationStyle,
          textStyle: widget.hourMinuteDigitTextStyle ??
              Theme.of(context).textTheme.bodyLarge,
        ),
      );

  Widget get _second => widget.showSecondsDigit != false
      ? Container(
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.all(2),
          alignment: AlignmentDirectional.center,
          decoration: widget.secondDigitDecoration,
          child: SpinnerText(
              text: sTOss(_clockModel.second),
              animationStyle: widget.digitAnimationStyle,
              textStyle: widget.secondDigitTextStyle ??
                  Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 10)),
        )
      : const SizedBox();

  Widget get _amPm => _clockModel.is24HourTimeFormat
      ? const SizedBox()
      : Container(
          padding: const EdgeInsets.all(2),
          alignment: AlignmentDirectional.center,
          child: Text(
            " ${hTOhh_24hFalse(_clockModel.hour)[1]}",
            style: widget.amPmDigitTextStyle ??
                Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        );
}

class ColonWidget extends StatefulWidget {
  final Widget? colon;
  final int colonTimer;

  const ColonWidget({
    Key? key,
    this.colon,
    required this.colonTimer,
  }) : super(key: key);

  @override
  State<ColonWidget> createState() => _ColonWidgetState();
}

class _ColonWidgetState extends State<ColonWidget> {
  late Timer timer;

  bool visible = true;

  _ColonWidgetState();
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: widget.colonTimer), (timer) {
      setState(() {
        visible = !visible;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: widget.colon ??
          Text(
            ":",
            style: Theme.of(context).textTheme.bodySmall,
          ),
    );
  }
}

class ClockModel {
  late int hour;
  late int minute;
  late int second;
  late bool is24HourFormat;

  get is24HourTimeFormat => is24HourFormat;
}

hTOhh_24hTrue(int hour) {
  late String sHour;
  if (hour < 10) {
    sHour = "0$hour";
  } else {
    sHour = "$hour";
  }
  return sHour;
}

hTOhh_24hFalse(int hour) {
  late String sHour;
  late String h12State;
  var times = [];
  if (hour < 10) {
    sHour = "0$hour";
    h12State = "AM";
  } else if (hour > 9 && hour < 12) {
    sHour = "$hour";
    h12State = "AM";
  } else if (hour == 12) {
    sHour = "12";
    h12State = "PM";
  } else if (hour > 12 && hour < 22) {
    sHour = "0${hour % 12}";
    h12State = "PM";
  } else if (hour > 21) {
    sHour = "${hour % 12}";
    h12State = "PM";
  }
  times.add(sHour);
  times.add(h12State);
  return times;
}

mTOmm(int minute) {
  late String sMinute;
  if (minute < 10) {
    sMinute = "0$minute";
  } else {
    sMinute = "$minute";
  }
  return sMinute;
}

sTOss(int second) {
  late String sSecond;
  if (second < 10) {
    sSecond = "0$second";
  } else {
    sSecond = "$second";
  }
  return sSecond;
}

class SpinnerText extends StatefulWidget {
  const SpinnerText(
      {super.key, required this.text, this.textStyle, this.animationStyle});

  final String text;
  final TextStyle? textStyle;
  final Curve? animationStyle;

  @override
  SpinnerTextState createState() => SpinnerTextState();
}

class SpinnerTextState extends State<SpinnerText>
    with SingleTickerProviderStateMixin {
  String topText = "";
  String bottomText = "";

  late AnimationController _spinTextAnimationController;
  late Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    bottomText = widget.text;
    _spinTextAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            bottomText = topText;
            topText = "";
            _spinTextAnimationController.value = 0.0;
          });
        }
      });

    _spinAnimation = CurvedAnimation(
        parent: _spinTextAnimationController,
        curve: widget.animationStyle ?? Curves.ease);
  }

  @override
  void dispose() {
    _spinTextAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SpinnerText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      //Need to spin new value
      topText = widget.text;
      _spinTextAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipper: RectClipper(),
      child: Stack(
        children: <Widget>[
          FractionalTranslation(
            translation: Offset(0.0, 1 - _spinAnimation.value),
            child: Text(
              topText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: widget.textStyle,
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.0, _spinAnimation.value),
            child: Text(bottomText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: widget.textStyle),
          ),
        ],
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height + 1);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
