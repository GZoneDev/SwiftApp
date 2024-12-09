import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final double width, height;
  final EdgeInsets margin, padding;
  final double borderRadius;
  final String placeholder;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const TextInputWidget({
    super.key,
    required this.placeholder,
    this.width = 278,
    this.height = 42,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.only(bottom: 3, left: 16, right: 16),
    this.borderRadius = 8,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: margin,
  //     child: Stack(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.only(top: 3),
  //           width: width,
  //           height: height,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(borderRadius),
  //           ),
  //         ),
  //         Container(
  //           padding: padding,
  //           child: TextFormField(
  //             controller: controller,
  //             validator: validator,
  //             onTap: onTap,
  //             decoration: InputDecoration(
  //               hintText: placeholder,
  //               hintStyle: TextStyle(
  //                 color: Color(0xFF8E8E93),
  //                 fontSize: 17,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //               border: InputBorder.none,
  //               enabledBorder: InputBorder.none,
  //               focusedBorder: InputBorder.none,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

// class _TextInputWidgetState extends State<TextInputWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       height: widget.height,
//       margin: widget.margin,
//       padding: widget.padding,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(widget.borderRadius),
//       ),
//       child: TextField(
//         onTap: widget.onTab,
//         decoration: InputDecoration(
//           hintText: widget.placeholder,
//           hintStyle: TextStyle(
//             color: Color(0xFF8E8E93),
//             fontSize: 17,
//             fontWeight: FontWeight.w400,
//           ),
//           border: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//         ),
//       ),
//     );
//     // bool _isError = false;

//     // @override
//     // void initState() {
//     //   super.initState();
//     //   _isError = widget.errorMessage.isNotEmpty;
//     // }

//     // @override
//     // Widget build(BuildContext context) {
//     //   return Column(
//     //     children: [
//     //       if (_isError)
//     //         Text(
//     //           widget.errorMessage,
//     //           style: TextStyle(
//     //             color: Colors.red,
//     //             fontSize: 15,
//     //             fontWeight: FontWeight.w400,
//     //           ),
//     //         ),
//     //       Container(
//     //         width: widget.width,
//     //         height: widget.height,
//     //         margin: widget.margin,
//     //         padding: widget.padding,
//     //         decoration: BoxDecoration(
//     //           color: Colors.white,
//     //           borderRadius: BorderRadius.circular(widget.borderRadius),
//     //         ),
//     //         child: TextField(
//     //           onTap: () => setState(() {
//     //             _isError = false;
//     //           }),
//     //           decoration: InputDecoration(
//     //             hintText: widget.placeholder,
//     //             hintStyle: TextStyle(
//     //               color: Color(0xFF8E8E93),
//     //               fontSize: 17,
//     //               fontWeight: FontWeight.w400,
//     //             ),
//     //             border: InputBorder.none,
//     //             enabledBorder: InputBorder.none,
//     //             focusedBorder: InputBorder.none,
//     //           ),
//     //         ),
//     //       ),
//     //     ],
//     //   );
//   }
// }
