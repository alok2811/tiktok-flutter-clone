import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_tutorial/helper/constants.dart';
import 'package:tiktok_tutorial/models/user.dart' as model;
import 'package:tiktok_tutorial/views/home_screen.dart';
import 'package:image_cropper/image_cropper.dart';

import '../helper/dialog_helper.dart';
import '../views/login_screen.dart';
import '../views/update_image_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();



  late Rx<User?> _user;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
  }


  void forgotPass({required String email}) async {
    if (email.isEmpty) {
      DialogHelper.hideLoading();
      DialogHelper.showSnackBar(strMsg: 'Please fill valid email!');
    } else {

      if (Get.isDialogOpen!) Get.back();
      try {
        await firebaseAuth.sendPasswordResetEmail(
            email: email);
        DialogHelper.hideLoading();
        DialogHelper.showErrorDialog(title: "Reset Password", description:
        "Please check your email and click on the provided link to reset your password.");

      } on FirebaseAuthException catch (e) {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(strMsg: e.code);
      } catch (e) {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(strMsg: e.toString());
      }
    }
  }

  void pickImage() async {

    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
     await cropImage(pickedImage);
     Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
     DialogHelper.hideLoading();
      Get.off(() => const HomeScreen());
    }
  }

  Future<void> cropImage(pickedImage) async{
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.red,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    await uploadToStorage(File(croppedFile!.path));

  }

  // upload to firebase storage
  Future<void> uploadToStorage(File image) async {
    DialogHelper.showLoading();
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    firebaseAuth.currentUser!.updatePhotoURL(downloadUrl);
    await fireStore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({
      "profilePhoto": downloadUrl.toString(),
    });
    DialogHelper.hideLoading();
  }

  // registering the user
  void registerUser(
      String username, String email, String password) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        // save out user to our ath and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        String downloadUrl = "https://firebasestorage.googleapis.com/v0/b/tiktok-clone-29225.appspot.com/o/user.png?alt=media&token=a75e051e-4aec-4089-b829-47731345806f";
        firebaseAuth.currentUser!.updateDisplayName(username);
        model.User user = model.User(
          name: username.trim(),
          email: email.trim(),
          uid: cred.user!.uid,
          profilePhoto: downloadUrl,
        );
        await fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        DialogHelper.hideLoading();
        if(cred.additionalUserInfo!.isNewUser){
          Get.offAll(() => const UpdateImageScreen());
        }else{
         Get.offAll(() => const HomeScreen());
        }

      } else {
        DialogHelper.hideLoading();
        Get.snackbar(
            'Error Creating Account',
            'Please enter all the fields',
            snackPosition: SnackPosition.BOTTOM
        );
      }
    } catch (e) {
      DialogHelper.hideLoading();
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
          snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email.trim(), password: password.trim());
        DialogHelper.hideLoading();
        Get.offAll(() => const HomeScreen());
      } else {
        DialogHelper.hideLoading();
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
          snackPosition: SnackPosition.BOTTOM
        );
      }
    } catch (e) {
      DialogHelper.hideLoading();
      Get.snackbar(
        'Error Logging',
        e.toString(),
          snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
    DialogHelper.hideLoading();
    Get.offAll(() => LoginScreen());
  }
}
