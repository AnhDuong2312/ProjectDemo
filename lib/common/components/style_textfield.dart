import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../colors/colors.dart';
import '../fonts/fonts.dart';
import '../images/images.dart';

class StyleTextField extends StatelessWidget {
  final List<TextInputFormatter>? formatNumber;
  final String? value;
  final bool isDropdown;
  final bool? enabledCopyPaste;
  final bool enabled;
  final Color textColor;
  final String textFontName;
  final double textFontSize;
  final String hintText;
  final Color titleColor;
  final Function(String)? onChanged;
  final bool isSecurity;
  final Widget? iconPrefix;
  final Widget? iconSuffix;
  final TextEditingController? controller;
  final TextInputAction inputAction;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final Function()? onGetDate;
  final String? errorText;
  final Color? fillColor;
  final double? height;

  const StyleTextField(
      {Key? key,
      this.textColor = AppColors.secondary,
      this.textFontName = FontFamily.inter,
      this.textFontSize = 14,
      required this.hintText,
      this.titleColor = AppColors.secondary,
      this.isSecurity = false,
      this.iconPrefix,
      this.iconSuffix,
      this.onChanged,
      this.controller,
      this.inputAction = TextInputAction.next,
      this.focusNode,
      this.onEditingComplete,
      this.keyboardType,
      this.onGetDate,
      this.errorText,
      this.enabled = true,
      this.isDropdown = false,
      this.value,
      this.formatNumber,
      this.enabledCopyPaste = true,
      this.fillColor,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
          spellCheckConfiguration: const SpellCheckConfiguration.disabled(),
          smartDashesType: SmartDashesType.disabled,
          autocorrect: false,
          enableSuggestions: false,
          inputFormatters: formatNumber,
          enabled: enabled,
          enableInteractiveSelection: enabledCopyPaste!,
          onTap: onGetDate,
          keyboardType: keyboardType,
          textInputAction: inputAction,
          autofocus: false,
          focusNode: focusNode,
          onChanged: onChanged,
          controller: controller,
          obscureText: isSecurity,
          cursorColor: AppColors.secondary,
          style: TextStyle(
              color: textColor,
              fontFamily: textFontName,
              fontWeight: FontType.regular,
              fontSize: textFontSize),
          decoration: InputDecoration(
            fillColor: fillColor ?? AppColors.transparent,
            filled: fillColor == null ? false : true,
            //labelText: hintText,
            errorText: errorText,
            contentPadding: EdgeInsets.only(
                top: 16.sp,
                left: 16.sp,
                right: iconSuffix == null && iconPrefix == null ? 16.sp : 0),
            prefixIcon: iconPrefix,
            suffixIcon: iconSuffix,
            border: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.secondaryLight, width: 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                )),
            hintText: hintText,
            hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: AppColors.secondary2,
                fontFamily: textFontName,
                fontWeight: FontType.regular,
                fontSize: textFontSize),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.secondaryLight, width: 0.5),
              borderRadius: BorderRadius.circular(6),
            ),

            enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.secondaryLight, width: 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                )),
            disabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.secondaryLight, width: 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                )),
          )),
    );
  }
}

class SecureTextField extends StatefulWidget {
  final Color textColor;
  final String textFontName;
  final Function(String)? onChanged;
  final double textFontSize;
  final String hintText;
  final Color titleColor;
  final Widget? iconPrefix;
  final TextEditingController? controller;
  final TextInputAction inputAction;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;

  const SecureTextField(
      {Key? key,
      this.textColor = AppColors.secondary,
      this.textFontName = FontFamily.inter,
      this.textFontSize = 14,
      required this.hintText,
      this.titleColor = AppColors.secondary,
      this.iconPrefix,
      this.onChanged,
      this.controller,
      this.focusNode,
      this.onEditingComplete,
      this.inputAction = TextInputAction.done})
      : super(key: key);

  @override
  _SecureTextFieldState createState() => _SecureTextFieldState();
}

class _SecureTextFieldState extends State<SecureTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      onEditingComplete: widget.onEditingComplete,
      controller: widget.controller,
      autofocus: false,
      cursorColor: AppColors.secondary,
      onChanged: widget.onChanged,
      obscureText: _isObscure,
      style: TextStyle(
          color: widget.textColor,
          fontFamily: widget.textFontName,
          fontWeight: FontType.regular,
          fontSize: widget.textFontSize),
      decoration: InputDecoration(
        // /  labelText: widget.hintText,
        contentPadding:
            EdgeInsets.only(top: 12, left: widget.iconPrefix == null ? 16 : 0),
        hintText: widget.hintText,
        hintStyle: TextStyle(
            fontStyle: FontStyle.italic,
            color: widget.titleColor,
            fontFamily: widget.textFontName,
            fontWeight: FontType.regular,
            fontSize: widget.textFontSize),
        prefixIcon: widget.iconPrefix,
        suffixIcon: IconButton(
          icon: _isObscure
              ? Icon(
                  Icons.visibility_off,
                  size: 24.sp,
                )
              : Icon(
                  Icons.visibility,
                  size: 24.sp,
                ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryLight, width: 0.5),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            )),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryLight, width: 0.5),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            )),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryLight, width: 0.5),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            )),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.secondaryLight, width: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

class StyleDropdownButton extends StatelessWidget {
  final String? hintText;
  final List<DropdownMenuItem<dynamic>>? items;
  final dynamic value;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? onSave;
  final Color? backgroundColor;
  final TextStyle? textStyleItemSelected;

  const StyleDropdownButton(
      {Key? key,
      this.hintText,
      this.items,
      this.onChanged,
      this.onSave,
      this.value,
      this.backgroundColor,
      this.textStyleItemSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<dynamic>(
      isExpanded: true,
      decoration: InputDecoration(
        fillColor: backgroundColor ?? const Color(0x208E8E8E),
        filled: true,
        constraints: const BoxConstraints(maxHeight: 40),
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.secondaryLight, width: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.secondaryLight, width: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.secondaryLight, width: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.secondaryLight, width: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        // Add more decoration..
      ),
      hint: Text(
        hintText ?? "",
        style: TextStyle(
          fontSize: 16.sp,
          fontStyle: FontStyle.italic,
        ),
      ),
      value: value,
      items: items,
      onChanged: onChanged,
      onSaved: onSave,
      buttonStyleData: const ButtonStyleData(
        height: 40,
        padding: EdgeInsets.only(),
      ),
      iconStyleData: const IconStyleData(
        icon: Center(
          child: Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
        ),
        iconSize: 20,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        // offset: Offset(0, -15.h)
      ),
      style: textStyleItemSelected,
      // selectedItemBuilder: (context) {
      //   return [Text(value.toString())];
      // },
      menuItemStyleData: const MenuItemStyleData(
          //padding: EdgeInsets.symmetric(horizontal: 16),
          ),
    );
  }
}
