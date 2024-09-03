import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubicate_usc/utils/color_string_util.dart';

final _icons = <String, IconData>{
  'apple': FontAwesomeIcons.appleAlt,
  'archive': FontAwesomeIcons.archive,
  'atom': FontAwesomeIcons.atom,
  'balanceScale': FontAwesomeIcons.balanceScale,
  'basketballBall': FontAwesomeIcons.basketballBall,
  'book': FontAwesomeIcons.book,
  'bookReader': FontAwesomeIcons.bookReader,
  'briefcase': FontAwesomeIcons.briefcase,
  'building': FontAwesomeIcons.building,
  'chalkboardTeacher': FontAwesomeIcons.chalkboardTeacher,
  'chartLine': FontAwesomeIcons.chartLine,
  'church': FontAwesomeIcons.church,
  'cogs': FontAwesomeIcons.cogs,
  'coins': FontAwesomeIcons.coins,
  'comments': FontAwesomeIcons.comments,
  'dna': FontAwesomeIcons.dna,
  'dumbbell': FontAwesomeIcons.dumbbell,
  'flask': FontAwesomeIcons.flask,
  'graduationCap': FontAwesomeIcons.graduationCap,
  'handHoldingHeart': FontAwesomeIcons.handHoldingHeart,
  'heartbeat': FontAwesomeIcons.heartbeat,
  'microscope': FontAwesomeIcons.microscope,
  'parking': FontAwesomeIcons.parking,
  'school': FontAwesomeIcons.school,
  'shoppingBag': FontAwesomeIcons.shoppingBag,
  'solidComments': FontAwesomeIcons.solidComments,
  'solidFutbol': FontAwesomeIcons.solidFutbol,
  'store': FontAwesomeIcons.store,
  'swimmingPool': FontAwesomeIcons.swimmingPool,
  'userGraduate': FontAwesomeIcons.userGraduate,
  'userTie': FontAwesomeIcons.userTie,
  'utensils': FontAwesomeIcons.utensils,
  'volleyballBall': FontAwesomeIcons.volleyballBall,
  'fileSignature': FontAwesomeIcons.fileSignature,
  'water': FontAwesomeIcons.water,
  'monument': FontAwesomeIcons.monument,
  'running': FontAwesomeIcons.running,
  'idCard': FontAwesomeIcons.idCard,
  // Se importan los dos nuevos iconos a usar
  'houseUser': FontAwesomeIcons.houseUser,
  'graduate': FontAwesomeIcons.graduationCap,
};

FaIcon getIcon(String iconName) {
  return FaIcon(_icons[iconName]);
}

FaIcon getIconWithColor(String iconName, String colorName) {
  return FaIcon(
    _icons[iconName],
    color: getColor(colorName),
  );
}
