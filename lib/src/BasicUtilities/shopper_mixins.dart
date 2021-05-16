class ShopperMixins{
  String validateWebLink(String value) {
    if (value.isEmpty) {
      return null;
    } else {
      var regex = new RegExp(r"((https?:www\.)|(https?:\/\/)|(www\.))?[\w\-?=%.][-a-zA-Z0-9@:%.\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%\+.~#?&\/=]*)?");
      var matchRegex =regex.hasMatch(value);
      if(matchRegex)
        return null;
      else
        return 'Enter a valid web-link';
    }
  }

  String validateTextField(String value) {
    if (value.isEmpty) {
      return "This field is empty";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "This field is empty";
    } else if(value.length < 8){
      return "Password length must be at least 8 characters";
    } else{
      return null;
    }
  }

  String validateConfirmPassword(String value, String value1) {
    if (value1.isEmpty) {
      return "This field is empty";
    } else if(value1.length < 8){
      return "Password length must be at least 8 characters";
    } else if (value != value1){
      return "Passwords don't match";
    }else{
      return null;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value))
      return 'Enter a valid Email Address';
    else
      return null;
  }
}