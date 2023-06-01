import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  
  GlobalKey<FormState> postKey= GlobalKey<FormState>();
  

  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  set isLoading(bool value){
    _isLoading=value;
    notifyListeners();
  }

  bool isValidForm(){
   
   
    return postKey.currentState?.validate()?? false;
  }



}