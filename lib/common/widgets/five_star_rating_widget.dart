import 'package:flutter/material.dart';
import 'package:onlinelearning/common/index.dart';

class FiveStarRatingWidget extends StatefulWidget {
  final int rating;
  final double starSize;
  final ValueChanged<int>? onRatingChanged;

  const FiveStarRatingWidget(
      {super.key,
      required this.rating,
      required this.starSize,
      this.onRatingChanged});

  @override
  _FiveStarRatingWidgetState createState() => _FiveStarRatingWidgetState();
}

class _FiveStarRatingWidgetState extends State<FiveStarRatingWidget> {
  int _currentRating = 0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  @override
  void didUpdateWidget(covariant FiveStarRatingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rating != oldWidget.rating) {
      _currentRating = widget.rating;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lightColor = AppTheme.commonTipColor;
    final greyColor = AppTheme.greyColor;
    return Row(
      children: List.generate(
        5,
        (index) {
          if (widget.onRatingChanged != null) {
            return SizedBox(
              width: widget.starSize + 8,
              height: widget.starSize + 8,
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.star,
                    color: index < _currentRating ? lightColor : greyColor,
                    size: widget.starSize,
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _currentRating = index + 1;
                    });
                    widget.onRatingChanged?.call(_currentRating);
                  },
                ),
              ),
            );
          } else {
            return IconWidget.icon(
              Icons.star,
              color: index < _currentRating ? lightColor : greyColor,
              size: widget.starSize,
            );
          }
        },
      ),
    );
  }
}
