
class Validators{
  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
       return 'Vui lòng nhập email ';
    }
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'
    );
    if (!emailRegex.hasMatch(value)){
      return 'Email không hợp lệ';
    }
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'Vui lòng nhập mật khẩu ';
    }
    if (value.length < 8){
      return 'Mật khẩu phải có ít nhất 8 ký tự';
    }
    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Mật khẩu phải có ít nhất 1 chữ hoa';
    }
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Mật khẩu phải có ít nhất 1 số';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password){
    if(value == null || value.isEmpty){
      return 'Vui lòng xác nhận mật khẩu ';
    }
    if (value != password) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }

  static String? validateDisplayName(String? value){
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập tên hiển thị';
    }
    if (value.length < 2) {
      return 'Tên hiển thị phải có ít nhất 2 ký tự';
    }
    return null;
  }

  static String? validatePhone(String? value){
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }
    final phoneRegex = RegExp(
      r'^\+?(\d{1,3})?[-. (]*(\d{3,4})?[-. )]*(\d{3,4})?[-. ]*(\d{4,5})$',
    );
    if (!phoneRegex.hasMatch(value.trim()))
      return "Số điện thoại không hợp lệ";
    return null;
  }

  static int? getPasswordStrength(String password){
    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.length >= 12) strength++;
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp('[!@#%^&*(),.?":{}|<>]'))) strength++;
    return strength;
  }

  static String getPasswordStrengthText(int strength){
    if (strength <= 2) return 'Yếu';
    if (strength <= 4) return 'Trung bình';
        return 'Mạnh';
  }
}