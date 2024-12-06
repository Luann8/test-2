
import 'package:asyncstate/class/async_overlay.dart';
import 'package:asyncstate/class/async_value.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


final class Hrv4lifeLoader extends AsyncOverlay{
  Hrv4lifeLoader(): super(
    id: 0,
    builder: (BuildContext context,AsyncValue<RouteSettings> settings){
      return Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width *.8,
          child: LoadingAnimationWidget.beat(color: Colors.orange, size: 50),
        ),
      );
    }
  );
}