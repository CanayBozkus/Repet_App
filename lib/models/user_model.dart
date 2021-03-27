import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/models/calendar_model.dart';
import 'package:repetapp/models/hive_models/hive_user_model.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/models/remainder_field_model.dart';
import 'package:repetapp/services/notification_plugin.dart';
import 'package:repetapp/services/database.dart';
import 'package:repetapp/utilities/constants.dart';

class UserModel {
  UserModel(
      {this.email,
      this.age,
      this.phoneNumber,
      this.gender = 'Female',
      this.nameSurname}) {
    _auth = FirebaseAuth.instance;
    _fireStore = FirebaseFirestore.instance;
  }

  String id;
  String email;
  String password;
  String nameSurname;
  int age;
  int phoneNumber;
  String gender = 'Female';
  List addresses;
  List pets = []; // Stores the ids of pets. it is a List<String> actually.
  String calendarId;
  CalendarModel calendar;
  FirebaseAuth _auth;
  FirebaseFirestore _fireStore;
  bool newsSetterConfirmation = true;

  Future<bool> createUser() async {
    /*
      Future<bool> createUser() async:

      Function for registering this user to cloud server and local database.
      First, it tries to save the user data into cloud server, and then into
      local database. If inserting data failes at any point for some reason, 
      function returns a future that will yield false. Otherwise it will return
      a future that yields true.

      Parameters:
        none
      
      Returns:
        Future<bool>: A future that resolves after registering the user to cloud
        server and saving the data to local database finishes or process fails.
        If process was successful, then Future yields true.Yields false otherwise
    */
    bool isCloudDataCreated = await this.createUserForCloud();
    if (isCloudDataCreated) {
      bool isLocalDataCreated = this.createUserForLocal();
      return isLocalDataCreated;
    }
    return isCloudDataCreated;
  }

  Future<bool> createUserForCloud() async {
    /*
      Future<bool> createUserForCloud() async:

      Function for registering the user to the cloud server. Firstly, the
      function will try to authenticate the user to the firebase. If that was
      successful, then the user data will be inserted into the cloud firestore.

      Parameters:
        none
      
      Returns:
        Future<bool>: A future that resolves after registering the user to cloud
        server finishes or process fails. If registering was successful, then 
        Future yields true. Yields false otherwise.
    */
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password); // authenticate the user.
      if (newUser != null) {
        // if authenticated successfully
        // save the user data in cloud firestore
        DocumentReference newDocument =
            await _fireStore.collection('UserModel').doc(newUser.user.uid);
        await newDocument.set({
          'name_surname': nameSurname,
          'age': age,
          'phone_number': phoneNumber,
          'gender': gender,
          'id': newUser.user.uid,
          'addresses': [],
          'pets': pets,
          'newsSetterConfirmation': newsSetterConfirmation,
          'calendar_id': await CalendarModel.createCalendar(newUser.user.uid),
        });
        this.id = newUser.user.uid;
        return true; // indicates that process executed successfully
      }
      // If auth failed, unauthenticate the user and delete all data associated
      // with the user.
      await _deleteUser();
      return false; // indicates that process failed.
    } catch (e) {
      print(e);
      await _deleteUser();
      return false;
    }
  }

  bool createUserForLocal() {
    /*
      bool createUserForLocal():

      Function for saving the user data in local database.

      Parameters:
        none
      
      Returns:
        bool: represents the success status of the process. Is true if storing
        the data was successful, false otherwise.
    */
    HiveUserModel localUser = HiveUserModel(
      id: this.id,
      nameSurname: this.nameSurname,
      gender: this.gender,
      phoneNumber: this.phoneNumber,
      age: this.age,
      pets: this.pets,
      addresses: this.addresses,
      calendarId: this.calendarId,
      email: this.email,
    );
    databaseManager.addData(model: 'userModel', data: localUser);
    return true;
  }

  //TODO: static method haline getir, return olarak UserModel() döndür.
  Future<bool> getUserData() async {
    /*
      Future<bool> getUserData() async:

      Wrapper function for writing the data stored in databases into this
      UserModel. If local data exists, local data will be read and written into
      the model. Else, data will be read from cloud database. If that also fails,
      then function will return a Future which will yield false. Will return a 
      Future that will yield true otherwise.

      Parameters:
        none
      
      Returns:
        Future<bool>: a Future which will resolve after getting the data from
        databases and writing it into this UserModel finishes. Will yield true if
        process is successful, false otherwise.
    */
    bool isLocalDataExist = this.getLocalUserData();
    if (!isLocalDataExist) {
      bool isCloudDataExist = await this.getCloudUserData();
      return isCloudDataExist;
    }
    return isLocalDataExist;
  }

  bool getLocalUserData() {
    /*
      Function for getting the user data from local database and writing that into
      this UserModel.

      Parameters:
        none
      
      Returns:
        bool: Indicates the status of the process. Will be false if process failed,
        true otherwise.
    */
    HiveUserModel localUser =
        databaseManager.getLocalUserData(_auth.currentUser.uid);

    if (localUser != null) {
      nameSurname = localUser.nameSurname;
      gender = localUser.gender;
      phoneNumber = localUser.phoneNumber;
      age = localUser.age;
      pets = localUser.pets;
      addresses = localUser.addresses;
      calendarId = localUser.calendarId;
      id = _auth.currentUser.uid;
      email = _auth.currentUser.email;
      return true;
    }
    return false;
  }

  Future<bool> getCloudUserData() async {
    /*
      Function for getting the user data from cloud database and writing that into
      this UserModel. If data associated with this user exists in cloud database,
      same data will be inserted into local database and function will return a 
      future which will yield true.

      Parameters:
        none
      
      Returns:
        Future<bool>: A future that resolves after data is retrieved from cloud and
        written into both this UserModel and local database. Will yield true if
        process was successful, false otherwise.
    */

    // Since all authenticated users will be present on cloud database as well,
    // Checking if user is authenticated is sufficent.
    if (FirebaseAuth.instance.currentUser != null) {
      // Get the user data from cloud firestore.
      DocumentSnapshot user = await _fireStore
          .collection('UserModel')
          .doc(_auth.currentUser.uid)
          .get();
      Map userData = user.data();

      // Write the data into UserModel.
      nameSurname = userData['name_surname'];
      gender = userData['gender'];
      phoneNumber = userData['phone_number'];
      age = userData['age'];
      pets = userData['pets'];
      addresses = userData['addresses'];
      calendarId = userData['calendar_id'];
      id = _auth.currentUser.uid;
      email = _auth.currentUser.email;

      // Save it locally.
      HiveUserModel localUser = HiveUserModel(
        id: this.id,
        nameSurname: this.nameSurname,
        gender: this.gender,
        phoneNumber: this.phoneNumber,
        age: this.age,
        pets: this.pets,
        addresses: this.addresses,
        calendarId: this.calendarId,
        email: this.email,
      );
      databaseManager.addData(model: 'userModel', data: localUser);

      // Indicate that process was successful.
      return true;
    }
    // Indicate that process failed.
    return false;
  }

  Future<bool> addPet(PetModel newPet, bool isUserRegistration) async {
    /*
      Function for associating a new pet with the user.

      Parameters:
        PetModel newPet: Pet object that will be associated with the user.
        bool isUserRegistration: A boolean that indicates if this function is
          called from registration screen (??)
      
      Returns:
        Future<bool>: A future that resolves after pet is associated with the 
        user (after updating the list of pets of user that is both stored locally 
        and in the cloud). Yields true if process was successful, false otherwise.
    */

    //TODO: üzerinden yeniden geçmek ve hata senaryolarını düzeltmek gerekli
    newPet.id = (this.id + newPet.name).replaceAll(' ', '');
    newPet.ownerId = this.id;
    bool result = await newPet.createPet();
    if (result) {
      this.pets.add(newPet.id);
      bool isLocalDataUpdated = this.updateLocalPetList();
      bool isCloudDataUpdated = await this.updateCloudPetList();

      return isLocalDataUpdated || isCloudDataUpdated;
    }
    isUserRegistration ? await _deleteUser() : null;
    return false;
  }

  Future<bool> updateCloudPetList() async {
    /*
      Function for updating the "pets" list under the collection associated with
      this user model in cloud firestore.

      Parameters:
        none
      
      Returns:
        Future<bool>: A function that resolves after patch request is done. Yields
        true if update was successful, false otherwise.
    */
    try {
      DocumentReference userModel =
          await _fireStore.collection('UserModel').doc(this.id);
      await userModel.update({
        'pets': this.pets,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool updateLocalPetList() {
    // Function for uplading the list of pets in local database.
    return databaseManager.updatePetList(id, pets);
  }

  Future<void> signOut() async {
    // Function for logging out the user.
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _deleteUser() async {
    /*
      Function for "deleting" a user. This function unauthenticates the user and
      deletes all the data associated with this user in the cloud database.

      Parameters:
        none
      
      Returns:
        Future<void>: A function that resolves after delete request is done. 
        Yields nothing.
    */
    User user = _auth.currentUser;
    await user.delete();
    await _fireStore.collection('UserModel').doc(user.uid).delete();
    for (int i = 0; i < pets.length; i++) {
      //TODO: PetModel.deletePet() yazılacak ve böylelikle pet'e bağlı olan collectionlar da silinecek.
      await _fireStore.collection('PetModel').doc(pets[i]).delete();
    }
    await _fireStore.collection('CalendarModel').doc(user.uid).delete();
  }

  Future<Map<String, PetModel>> getPets() async {
    /*
      Function for getting the information of all the pets of the user as a map.

      Parameters:
        none
      
      Returns:
        Future<Map<String, PetModel>>: A future that resolves after all the data
        is retrieved. Yields into a map.
          -- Keys: String -> ID of a individual pet.
          -- Values: PetModel -> PetModel object that carries all the sufficent
            data about the pet itself.
    */
    Map<String, PetModel> petModels = {};
    for (int i = 0; i < pets.length; i++) {
      PetModel pet = PetModel();
      bool result = await pet.getPetData(pets[i]);
      petModels[pets[i]] = result ? pet : null;
    }
    return petModels;
  }

  void setNotificationSettings() {
    // Function for setting notification settings.
    notificationPlugin.setListenerForLowerVersions(() {});
    notificationPlugin.setOnNotificationClick((String payload) {});
  }

  Future<void> addRemainder(PetModel pet, Remainders remainder, DateTime time,
      int notificationId, bool isActive) async {
    /*
      Wrapper function for setting a daily reminder of type [remainder] at [time] for a 
      specific [pet] of a user, only if [isActive] is true. The notification will
      have the id of [notificationId]

      Parameters:
        PetModel pet: PetModel that represents a specific pet of the user.
        Remainders remainder: Reminder category.
        DateTime time: A Datetime object that specifies the time of the reminder.
        int notificationId: ID that will be possesed by newly created notification.
        bool isActive: Indicates that if this reminder is enabled or not.
      
      Returns:
        Future<void>: A future that resolves after routine is added. Yields
        nothing.
    */
    bool result =
        await pet.addRoutine(remainder, time, notificationId, isActive);
  }

  Future<void> removeReminder(
    PetModel pet,
    Remainders reminder,
    int reminderModelId,
  ) async {
    bool result = await pet.removeReminder(reminder, reminderModelId);
  }

  Future<void> updateReminder(
    PetModel pet,
    Remainders reminder,
    int reminderModelId,
    Map<String, dynamic> reminderData,
  ) async {
    await pet.updateReminder(reminder, reminderModelId, reminderData);
  }

  Future<void> updateRemainderStatus(
      /*
      Wrapper function for updating the status an existing daily reminder
      [remainderField] of type [remainder] for a specific [pet] of a user to
      the value [newStatus].

      Parameters:
        PetModel pet: PetModel that represents a specific pet of the user.
        Remainders remainder: Reminder category.
        RemainderFieldModel remainderField: Model of the reminder.
        bool newStatus: The status that will be replaced with the old one.
      
      Returns:
        Future<void>: A future that resolves after routine is updated. Yields
        nothing.
    */
      PetModel pet,
      RemainderFieldModel remainderField,
      Remainders remainder,
      bool newStatus) async {
    pet.updateRemainderStatus(remainderField, remainder, newStatus);
  }

  Future<void> cancelRemainder(PetModel pet, id, routineName) async {
    // await pet.cancelRoutine(currentNotifications[id], routineName);
  }

  Future<bool> updateData(Map<String, dynamic> data) async {
    bool isCloudUpdated = await this.updateCloudData(data);
    if (isCloudUpdated) {
      this.updateLocalData(data);
      this.email = data['email'] ?? this.email;
      this.gender = data['gender'] ?? this.gender;
      this.age = data['age'] ?? this.age;
      this.addresses = data['addresses'] ?? this.addresses;
      this.phoneNumber = data['phoneNumber'] ?? this.phoneNumber;
      this.nameSurname = data['nameSurname'] ?? this.nameSurname;
      return true;
    }
    return false;
  }

  void updateLocalData(Map<String, dynamic> data) {
    databaseManager.updatePersonalData(id, data);
  }

  Future<bool> updateCloudData(Map<String, dynamic> data) async {
    try {
      DocumentReference document =
          await _fireStore.collection('UserModel').doc(this.id);
      await document.update(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> updateEmail(String email, String password) async {
    /*
      Function for updating the credentials of the user.

      Parqmeters:
        String email: new email of the user.
        String password: new password of the user.

      Returns:
        Future<String>: A future that resolves after update is finished. Yields
        null if no error has occured while updating the credentials. Yields the
        error message as String if an error has occured while updating.
    */
    try {
      await _auth.currentUser.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: this.email,
          password: password,
        ),
      );
      _auth.currentUser.getIdToken();
      await _auth.currentUser.updateEmail(email);
      this.updateLocalData({'email': email});
      this.email = email;
      return null;
    } on FirebaseAuthException catch (e) {
      print(e);
      switch (e.code) {
        case 'invalid-email':
          return 'Invalid email. Please enter a valid email.';
          break;
        case 'email-already-in-use':
          return 'This email is being used by another user. Please try with another email';
          break;
        case 'wrong-password':
          return 'Wrong password entered. Please try again.';
          break;
        default:
          return 'An error happened please try again later.';
      }
      return null;
    }
  }
}
