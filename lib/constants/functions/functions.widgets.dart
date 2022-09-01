import 'package:bechdal_app/constants/colors.constants.dart';
import 'package:flutter/material.dart';

loadingDialogBox(BuildContext context, String loadingMessage) {
  AlertDialog alert = AlertDialog(
    content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(greyColor!),
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            loadingMessage,
            style: TextStyle(
              color: blackColor,
            ),
          )
        ]),
  );

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

customSnackBar({required BuildContext context, required String content}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: blackColor,
    content: Text(
      content,
      style: TextStyle(color: whiteColor, letterSpacing: 0.5),
    ),
  ));
}

Widget roundedButton({
  context,
  required Color? bgColor,
  required Function()? onPressed,
  Color? textColor,
  double? width,
  double? heightPadding,
  required String? text,
  Color? borderColor,
}) {
  return SizedBox(
    width: width ?? double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                color: borderColor ?? secondaryColor,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(bgColor)),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: heightPadding ?? 15),
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    ),
  );
}

wrongDetailsAlertBox(String text, BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Text(
      text,
      style: TextStyle(
        color: blackColor,
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Ok',
          )),
    ],
  );

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

customHomeAppBar(
    {required TextEditingController controller, required FocusNode focusNode}) {
  return AppBar(
    toolbarHeight: 150,
    elevation: 0,
    backgroundColor: whiteColor,
    automaticallyImplyLeading: false,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Bechdal",
              style: TextStyle(
                color: blackColor,
                fontSize: 34,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: blackColor,
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart,
                      color: blackColor,
                    ))
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.search),
              labelText: 'Search mobile, cars equipments and many more..',
              labelStyle: const TextStyle(
                fontSize: 14,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
        )
      ],
    ),
  );
}

openBottomSheet(
    {required BuildContext context,
    required Widget child,
    String? appBarTitle,
    double? height}) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        primary: Colors.white,
                      ),
                      child: Icon(Icons.close, color: blackColor),
                    ),
                  ),
                ],
              ),
              appBarTitle != null
                  ? Container(
                      color: Colors.transparent,
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: secondaryColor,
                        title: Text(
                          appBarTitle,
                          style: TextStyle(color: whiteColor, fontSize: 18),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight:
                            height ?? MediaQuery.of(context).size.height / 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                      ),
                      child: child,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
