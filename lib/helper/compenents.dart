import 'package:alloha/localization/language_constrants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/src/tweens/delay_tween.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomTextField extends StatefulWidget {
  @required
  final String labelText;
  @required
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final Key? key;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Color? fillColor;
  final int maxLines;
  final bool isPassword;
  final bool? isCountryPicker;
  final bool? isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  bool isShowPrefixIcon;
  final GestureTapCallback? onTap;
  final ValueChanged? onChanged;
  final VoidCallback? onSuffixTap;
  final String? suffixIconUrl;
  String? prefixIconUrl;
  final bool? isSearch;
  final ValueChanged? onSubmit;
  final bool? isEnabled;
  final TextCapitalization? capitalization;
  FormFieldValidator<String>? validator;

  CustomTextField({
    this.key,
    this.hintText,
    this.validator,
    this.labelText = 'Write something...',
    required this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSuffixTap,
    this.fillColor,
    this.onSubmit,
    this.onChanged,
    this.capitalization = TextCapitalization.none,
    this.isCountryPicker = false,
    this.isShowBorder = false,
    this.isShowSuffixIcon = false,
    this.isShowPrefixIcon = false,
    this.onTap,
    this.isIcon = false,
    this.isPassword = false,
    this.suffixIconUrl,
    this.prefixIconUrl,
    this.isSearch = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: widget.key,
      validator: widget.validator != null ? widget.validator : null,
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      // style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.FONT_SIZE_LARGE),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      enabled: widget.isEnabled,
      autofocus: false,

      //onChanged: widget.isSearch ? widget.languageProvider.searchLanguage : null,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
            ]
          : null,

      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
              style: BorderStyle.none, width: .8, color: Color(0xffdbdbdb)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              style: BorderStyle.solid, width: .8, color: Color(0xffdbdbdb)),
        ),
        floatingLabelStyle: TextStyle(fontSize: 16, color: Colors.black38),
        isDense: true,
        labelText: widget.hintText,
        // hintText: widget.hintText,
        fillColor: widget.fillColor != null
            ? widget.fillColor
            : Theme.of(context).cardColor,
        // hintStyle: Theme.of(context).textTheme.headline2.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_GREY_CHATEAU),
        filled: true,
        prefixIcon:
            widget.isShowPrefixIcon ? Image.asset(widget.prefixIconUrl!) : null,
        prefixIconConstraints:
            const BoxConstraints(minWidth: 23, maxHeight: 20),
        suffixIcon: !widget.isShowSuffixIcon
            ? widget.isPassword
                ? IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: _toggle)
                : widget.isIcon
                    ? IconButton(
                        onPressed: widget.onSuffixTap != null
                            ? widget.onSuffixTap
                            : null,
                        icon: Image.asset(
                          widget.suffixIconUrl!,
                          width: 15,
                          height: 15,
                          // color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      )
                    : null
            : null,
      ),
      onTap: widget.onTap != null ? widget.onTap : null,
      onFieldSubmitted: (text) => widget.nextFocus != null
          ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null
              ? widget.onSubmit!(text)
              : null,
      onChanged: widget.onChanged,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

class MyOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle? style;
  final Gradient? gradient;
  final double thickness;
  final double raduis;

  const MyOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.raduis,
    required this.child,
    this.style,
    this.gradient,
    this.thickness = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.all(Radius.circular(raduis))),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // color: Colors.white,
        margin: EdgeInsets.all(thickness),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Colors.transparent,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class SpinKitFadingCircle extends StatefulWidget {
  const SpinKitFadingCircle({
    Key? key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        super(key: key);

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  _SpinKitFadingCircleState createState() => _SpinKitFadingCircleState();
}

class _SpinKitFadingCircleState extends State<SpinKitFadingCircle>
    with SingleTickerProviderStateMixin {
  final List<double> delays = [
    .0,
    -1.1,
    -1.0,
    -0.9,
    -0.8,
    -0.7,
    -0.6,
    -0.5,
    -0.4,
    -0.3,
    -0.2,
    -0.1
  ];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Stack(
          children: List.generate(12, (i) {
            final _position = widget.size * .5;
            return Positioned.fill(
              left: _position,
              top: _position,
              child: Transform(
                transform: Matrix4.rotationZ(30.0 * i * 0.0174533),
                child: Align(
                  alignment: Alignment.center,
                  child: FadeTransition(
                    opacity: DelayTween(begin: 0.0, end: 1.0, delay: delays[i])
                        .animate(_controller),
                    child: SizedBox.fromSize(
                        size: Size.square(widget.size * 0.15),
                        child: _itemBuilder(i)),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration:
              BoxDecoration(color: widget.color, shape: BoxShape.circle));
}

showError(
  BuildContext context,
  error,
) =>
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      // animType: AnimType.BOTTOMSLIDE,
      btnOkColor: Colors.red,
      title: getTranslated('error', context),
      desc: error,
      btnOkOnPress: () {},
    )..show();

showSuccess(
  BuildContext context,
    message,
) =>
    Fluttertoast.showToast(
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 15.0);
