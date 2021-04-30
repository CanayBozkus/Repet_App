import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/models/vaccine_model.dart';
import 'package:repetapp/models/pet_model.dart';

import 'base_checkbox.dart';

class VaccineListItem extends StatefulWidget {
  final VaccineModel vaccine;

  VaccineListItem(this.vaccine);

  @override
  _VaccineListItemState createState() => _VaccineListItemState();
}

class _VaccineListItemState extends State<VaccineListItem> {
  bool _state = false;

  String getNextDate(PetModel pet) {
    DateTime deadline = pet.trackedVaccines[widget.vaccine.docId];
    if (deadline != null) {
      return DateFormat("hh:mm dd/MM/yyyy").format(deadline);
    } else {
      return null;
    }
  }

  Color getStatusColor(PetModel pet) {
    DateTime deadline = pet.trackedVaccines[widget.vaccine.docId];
    DateTime today = DateTime.now();

    if (deadline == null) return Colors.white;

    int diff = deadline.difference(today).inDays;

    if (diff < 0) {
      return Color.fromRGBO(255, 110, 110, 1);
    } else if (diff <= 14) {
      return Color.fromRGBO(255, 229, 51, 1);
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final generalData = context.read<GeneralProviderData>();
    final pet = generalData.pets[generalData.currentShownPetIndex];
    String dateString = getNextDate(pet);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: BaseShadow(
        child: ListTile(
          tileColor: getStatusColor(pet),
          title: Text(
            widget.vaccine.name,
            style: TextStyle(
              fontSize: 20,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: dateString == null
              ? null
              : Text(
                  dateString,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
          trailing: BaseCheckBox(
            color: kColorGreen,
            value: this._state,
            onChanged: (newVal) {
              if (newVal) {
                pet.addVaccine(widget.vaccine);
              } else {
                pet.removeVaccine(widget.vaccine);
              }

              setState(() {
                this._state = newVal;
              });
            },
          ),
        ),
      ),
    );
  }
}
