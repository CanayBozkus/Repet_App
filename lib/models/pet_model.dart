import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/models/hive_models/hive_pet_model.dart';
import 'package:repetapp/models/remainder_field_model.dart';
import 'package:repetapp/services/database.dart';
import 'package:repetapp/services/notification_plugin.dart';
import 'package:repetapp/utilities/constants.dart' as constants;
import 'package:repetapp/utilities/extensions.dart';

class PetModel {
  PetModel() {
    _fireStore = FirebaseFirestore.instance;
  }

  /*
    Each PetModel is a model for representing a pet that belongs to an user.
    
    Parameter definitions:
      String id: ID of the pet.
      String ownerId: UID of the owner of the pet.
      String name: Name of the pet.
      String gender: Gender of the pet.
      PetTypes type: Type of the pet. Initial value is PetTypes.dog.
      String species: Species of the pet.
      double weight: Weight of the pet in kg.
      double height: Height of the pet in meters.
      int year: Birth year of the pet.
      int month: Birth month of the pet.
      List allergies: List of allergies the pet has.
      List disabilities: List of disabilities the pet has.
      List sicknesses: List of sicknesses the pet has.
      Map routines: Contains list of routines scheduled by the owner.
  */

  String id;
  String ownerId;
  String name;
  String gender;
  constants.PetTypes type = constants.PetTypes.dog;
  String species;
  double weight;
  double height;
  int year;
  int month;
  List allergies = [];
  List disabilities = [];
  List sicknesses = [];
  Map routines = {
    //TODO: routinelerin içinde saat kısmı için string olarak değil datetime olarak tut.
    'feeding': [],
    'water': [],
    'walking': [],
    'grooming': [],
    'playing': [],
  };

  int petTrainingModelId;
  FirebaseFirestore _fireStore;

  Future<bool> createPet() async {
    /*
      Future<bool> createPet() async:

      Saves the pet data in both cloud firestore and local database.

      Parameters:
        none

      Returns:
        Future<bool>: A future that resolves when the pet data is successfully
        stored both in local database and cloud. Yields true if storing process
        executed successfully, false otherwise.
    */
    try {
      this.createPetForCloud();
      this.createPetForLocal();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> createPetForCloud() async {
    /*
      Future<void> createPetForCloud() async:

      Saves the pet data in cloud firestore.

      Parameters:
        none

      Returns:
        Future<void>: A future that resolves when the pet data is successfully
        stored in cloud firestore.
    */
    DocumentReference newPet = _fireStore.collection('PetModel').doc(id);
    await newPet.set({
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'gender': gender,
      'type': constants.petTypeNames[type],
      'species': species,
      'weight': weight,
      'height': height,
      'year': year,
      'month': month,
      'allergies': allergies,
      'disabilities': disabilities,
      'sicknesses': sicknesses,
      'routines': routines,
      'petTrainingModelId': -1,
    });
  }

  void createPetForLocal() {
    /*
      createPetForLocal():

      Saves the pet data in local NOSQL database.

      Parameters:
        none

      Returns:
        none
    */
    HivePetModel localPetData = HivePetModel(
      id: this.id,
      name: this.name,
      ownerId: this.ownerId,
      gender: this.gender,
      type: constants.petTypeNames[this.type],
      species: this.species,
      weight: this.weight,
      height: this.height,
      year: this.year,
      month: this.month,
      allergies: this.allergies,
      disabilities: this.disabilities,
      sicknesses: this.sicknesses,
      routines: this.routines,
      petTrainingModelId: -1,
    );
    databaseManager.addData(model: 'petModel', data: localPetData);
  }

  Future<bool> getPetData(id) async {
    /*
     Future<bool> getPetData(id) async:

      Function for getting the pet data with given [id]. Function first tries to
      get the local data. If local data does not exist, then it tries to get the
      data from cloud.

      Parameters:
        String id: ID of the pet.

      Returns
        Future<bool>: A future that resolves when data getting process ends. Yields 
        true if there was such a pet with given id in either local database or 
        cloud firestore. Yields false otherwise.

    */

    bool isLocalDataExist = this.getLocalPetData(id);

    if (!isLocalDataExist) {
      try {
        bool isCloudDataExist = await this.getCloudPetData(id);
        return isCloudDataExist;
      } catch (e) {
        print(e);
        return false;
      }
    }
    return isLocalDataExist;
  }

  bool getLocalPetData(String id) {
    /*
     bool getLocalPetData(String id):

      Function for getting the pet data with given [id] in the local database.
      If there is a pet associated with [id] in the local database, function reads
      the data stored locally and writes it into the PetModel.

      Parameters:
        String id: ID of the pet.

      Returns
        bool: Result of the select query. Is true when there was such a pet with
        given id in the local database. Is false otherwise.

    */
    HivePetModel localPetData = databaseManager.getLocalPet(id);

    if (localPetData != null) {
      this.id = id;
      name = localPetData.name;
      ownerId = localPetData.ownerId;
      gender = localPetData.gender;
      type = constants.petTypeNamesReverse[localPetData.type];
      species = localPetData.species;
      weight = localPetData.weight;
      height = localPetData.height;
      year = localPetData.year;
      month = localPetData.month;
      allergies = localPetData.allergies;
      disabilities = localPetData.disabilities;
      sicknesses = localPetData.sicknesses;
      localPetData.routines.keys.forEach((key) {
        localPetData.routines[key].forEach((e) {
          routines[key]
              .add(RemainderFieldModel.fromMap(data: e, isLocal: true));
        });
      });
      return true;
    }
    return false;
  }

  Future<bool> getCloudPetData(String id) async {
    /*
     Future<bool> getCloudPetData(String id) async:

      Function for getting the pet data with given [id] in the cloud firestore.
      If there is a pet associated with [id] in the cloud, function reads
      the data stored in the cloud and writes it into the PetModel and stores 
      the data in local database.

      Parameters:
        String id: ID of the pet.

      Returns
        Future<bool>: A future that resolves into the result of the select query. 
        Result is true when there was such a pet with given id in the cloud, 
        false otherwise.

    */

    DocumentSnapshot pet =
        await _fireStore.collection('PetModel').doc(id).get();
    Map petData = pet.data();
    this.id = id;
    name = petData['name'];
    ownerId = petData['owner_id'];
    gender = petData['gender'];
    type = constants.petTypeNamesReverse[petData['type']];
    species = petData['species'];
    weight = petData['weight'];
    height = petData['height'];
    year = petData['year'];
    month = petData['month'];
    allergies = petData['allergies'];
    disabilities = petData['disabilities'];
    sicknesses = petData['sicknesses'];
    petData['routines'].keys.forEach((key) {
      petData['routines'][key].forEach((e) {
        routines[key].add(RemainderFieldModel.fromMap(data: e, isLocal: false));
      });
    });
    HivePetModel localPetData = HivePetModel(
      id: this.id,
      name: this.name,
      ownerId: this.ownerId,
      gender: this.gender,
      type: petData['type'],
      species: this.species,
      weight: this.weight,
      height: this.height,
      year: this.year,
      month: this.month,
      allergies: this.allergies,
      disabilities: this.disabilities,
      sicknesses: this.sicknesses,
      routines: petData['routines'],
    );
    databaseManager.addData(model: 'petModel', data: localPetData);
    return true;
  }

  // Should be a dynamic process in the future.
  List getAllergies() {
    /*
     List getAllergies():

      Function for getting all the possible allergies data.

      Parameters:
        none

      Returns
        List<String>: all possible allergies.

    */
    return constants.allergies;
  }

  // Should be a dynamic process in the future.
  List getDisabilities() {
    /*
     List getDisabilities():

      Function for getting all the possible disabilities data.

      Parameters:
        none

      Returns
        List<String>: All possible disabilities.

    */
    return constants.disabilities;
  }

  Future<bool> addRoutine(constants.Remainders remainder, DateTime time, int id,
      bool isActive) async {
    /*
     Future<bool> addRoutine
      (constants.Remainders remainder, DateTime time, int id,bool isActive) async:

      Function for scheduling a routine for the pet. If [isActive], function sets 
      up a daily notification at given [time].

      Parameters:
        enum Remainders: Type of the daily routine.
        DateTime time: Time of the daily routine.
        int id: Unique ID of the routine. (??)
        bool isActive: If true, daily notification will be set and vice versa.

      Returns
        Future<bool>: A future that resolves after routine is scheduled. Yields
        the success of the scheduling process.

    */
    RemainderFieldModel newRemainder =
        RemainderFieldModel(time: time, isActive: isActive, id: id);
    String remainderTitle = constants.remainderTitles[remainder];
    this.routines[remainderTitle.toLowerCase()].add(newRemainder);
    try {
      isActive
          ? notificationPlugin.showDailyAtTimeNotification(
              id: id,
              title: '$remainderTitle Time',
              body: '${this.name} needs ${remainderTitle.toLowerCase()}.',
              payload: null,
              time: time)
          : null;
      addUpdateRoutineToCloud(remainderTitle);
      addUpdateRoutineToLocal();
      databaseManager.addNewNotification(
        remainderTitle + this.name + id.toString(),
        id,
        this.ownerId,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeReminder(
      constants.Remainders reminderType, int reminderModelId) async {
    String reminderTitle = constants.remainderTitles[reminderType];
    // Get the element and its index that corresponds to reminderModelId
    int removedElementIndex = this
        .routines[reminderTitle.toLowerCase()]
        .indexWhere((reminder) => reminder.id == reminderModelId);
    RemainderFieldModel removedElement =
        this.routines[reminderTitle.toLowerCase()][removedElementIndex];
    try {
      // Remove the element
      this.routines[reminderTitle.toLowerCase()].removeAt(removedElementIndex);
      // Try updating the databases.
      await addUpdateRoutineToCloud(reminderTitle);
      addUpdateRoutineToLocal();
      // Cancel notifications if refresh was successful.
      notificationPlugin.cancelNotification(id: reminderModelId);
      databaseManager.removeNotification(reminderModelId);
      return true;
    } catch (error) {
      // If error occured, add back the removed element at its own index.
      this
          .routines[reminderTitle.toLowerCase()]
          .insert(removedElementIndex, removedElement);
      print(error);
      return false;
    }
  }

  Future<void> updateReminder(
    constants.Remainders reminderType,
    int reminderModelId,
    Map<String, dynamic> reminderData,
  ) async {
    String reminderTitle = constants.remainderTitles[reminderType];

    RemainderFieldModel currReminder = this
        .routines[reminderTitle.toLowerCase()]
        .firstWhere((reminder) => reminder.id == reminderModelId);

    DateTime prevTime = currReminder.time;
    DateTime newTime = reminderData["newTime"];

    bool prevStatus = currReminder.isActive;
    bool newStatus = reminderData["isActive"];

    if (currReminder.time == newTime && currReminder.isActive == newStatus) {
      return;
    }

    currReminder.time = newTime;
    currReminder.isActive = newStatus;

    try {
      // Update databases
      await addUpdateRoutineToCloud(reminderTitle);
      addUpdateRoutineToLocal();

      // Cancel current notification
      notificationPlugin.cancelNotification(id: reminderModelId);
      databaseManager.removeNotification(reminderModelId);

      // Add new notification
      currReminder.isActive
          ? notificationPlugin.showDailyAtTimeNotification(
              id: reminderModelId,
              title: '$reminderTitle Time',
              body: '${this.name} needs ${reminderTitle.toLowerCase()}.',
              payload: null,
              time: newTime)
          : null;

      databaseManager.addNewNotification(
        reminderTitle + this.name + id.toString(),
        reminderModelId,
        this.ownerId,
      );
    } catch (error) {
      currReminder.time = prevTime;
      currReminder.isActive = prevStatus;
      print(error);
    }
  }

  Future<void> addUpdateRoutineToCloud(String routineName) async {
    /*
    Future<void> addUpdateRoutineToCloud(String routineName) async:

      Updates the routine with name [routineName] of the pet in cloud firestore.

      Parameters:
        String routineName: Name of the routine of the pet that will be updated.

      Returns
        Future<void>: A future that resolves after the routine data is updated.
        Yields nothing.

    */
    DocumentReference document =
        await _fireStore.collection('PetModel').doc(this.id);
    await document.update({
      'routines.${routineName.toLowerCase()}': this
          .routines[routineName.toLowerCase()]
          .map((e) => e.toMap())
          .toList(),
    });
  }

  void addUpdateRoutineToLocal() {
    /*
    void addUpdateRoutineToLocal():

      Updates all the routines of the pet in local database.

      Parameters:
        none

      Returns
        none

    */
    Map newRoutines = {};
    this.routines.keys.forEach((key) {
      newRoutines[key] = [];
      routines[key].forEach((e) {
        newRoutines[key].add(e.toMap());
      });
    });
    databaseManager.updatePetRoutine(this.id, newRoutines);
  }

  Future<void> cancelRoutine(id, routineName) async {
    /*
      Future<void> cancelRoutine(id, routineName):
      
      Function for cancelling an existing routine.

      Parameters:
        int id: ID of the routine.
        String routineName: Name of the routine.
      
      Returns:
        Future<void>: A future that resolves when cancelling is done.
    */
    DocumentReference document =
        await _fireStore.collection('PetModel').doc(this.id);
    await document.update({
      'routines.$routineName': this.routines[routineName],
    });
    notificationPlugin.cancelNotification(id: id);
  }

  void updateRemainderStatus(RemainderFieldModel remainderField,
      constants.Remainders remainder, bool newStatus) {
    /*
      void updateRemainderStatus(RemainderFieldModel remainderField,
        constants.Remainders remainder, bool newStatus):
      
      Function for updating the status of a remainder with type [remainder]
      and id [remainderField.id] from [remainderField.status] to [newStatus]. 

      Parameters:
        RemainderFieldModel remainderField: Model of the routine that will be updated
        Remainders remainder: enum value that describes the type of the routine
        bool newStatus: New status of the remainder.
      
      Returns:
        none
    */

    // Get the list of routines with type of [remainder]
    List routineField =
        this.routines[constants.remainderTitles[remainder].toLowerCase()];
    // Find the model that is identical with [remainderField]
    // NOTE from @UtkuUyar: Not sure if this is necessary.
    RemainderFieldModel model =
        routineField.where((element) => element.id == remainderField.id).first;
    String remainderTitle = constants.remainderTitles[remainder];
    model.isActive = newStatus; // update the status.
    // Set up a notification if status == true:
    newStatus
        ? notificationPlugin.showDailyAtTimeNotification(
            id: remainderField.id,
            title: '$remainderTitle Time',
            body: '${this.name} needs ${remainderTitle.toLowerCase()}.',
            payload: null,
            time: remainderField.time)
        : notificationPlugin.cancelNotification(id: remainderField.id);
    // Update the databases.
    addUpdateRoutineToLocal();
    addUpdateRoutineToCloud(constants.remainderTitles[remainder]);
  }

  Future<bool> updateData(Map<String, dynamic> data) async {
    /*
      Future<bool> updateData(Map<String, dynamic> data) async:

      Function for updating the pet data. Function first updates the cloud data.
      If update was successful, function then updates the local data since it
      means that there is such a pet registered in the system. And finally,
      function updates the temporary data.

      Parameters:
        Map<String, dynamic> data: The pet data. Contains the changed parts.
      
      Returns:
        Future<bool>: A future that resolves after updating finishes. Yields true
        if updating was successful, false otherwise.
    */
    bool isCloudUpdated = await this.updateCloudData(data);
    if (isCloudUpdated) {
      this.updateLocalData(data);
      this.name = data['name'] ?? this.name;
      this.species = data['species'] ?? this.species;
      this.gender = data['gender'] ?? this.gender;
      this.month = data['month'] ?? this.month;
      this.year = data['year'] ?? this.year;
      this.height = data['height'] ?? this.height;
      this.weight = data['weight'] ?? this.weight;
      return true;
    }
    return false;
  }

  void updateLocalData(Map<String, dynamic> data) {
    databaseManager.updatePetData(id, data);
  }

  Future<bool> updateCloudData(Map<String, dynamic> data) async {
    try {
      DocumentReference document =
          await _fireStore.collection('PetModel').doc(this.id);
      await document.update(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
