// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CustomProfileAppBar extends StatelessWidget {
//   final String title; // Заголовок
//   final String userName; // Имя пользователя
//   final String userEmail; // Почта пользователя
//   final String userImageUrl; // URL аватарки пользователя
//   final VoidCallback onEditPressed; // Действие при нажатии на "Редактировать"

//   const CustomProfileAppBar({
//     Key? key,
//     required this.title,
//     required this.userName,
//     required this.userEmail,
//     required this.userImageUrl,
//     required this.onEditPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       expandedHeight: 200, // Высота градиента
//       pinned: true, // Делает AppBar фиксированным
//       automaticallyImplyLeading: false, // Убираем стрелку назад
//       backgroundColor: const Color(0xFFFFA11E),
//       elevation: 0,
//       shadowColor: Colors.transparent,
//       title: Align(
//         alignment: Alignment.centerLeft,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 0, top: 0), // Отступы
//           child: Text(
//             title,
//             style: const TextStyle(
//               color: Color(0xFFF6F6F6), // Цвет текста
//               fontFamily: 'SFProText-Bold.ttf', // Указываем шрифт
//               fontWeight: FontWeight.bold,
//               fontSize: 28,
//             ),
//           ),
//         ),
//       ),
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xFFFFC60F), // Желтый
//                 Color(0xFFFF9F0A), // Оранжевый
//               ],
//               stops: [0.29, 1.0], // Проценты градиента
//             ),
//           ),
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, top: 76),
//                 child: CircleAvatar(
//                   radius: 40,
//                   backgroundImage: NetworkImage(userImageUrl),
//                 ),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width * 0.04),
//               Padding(
//                 padding: const EdgeInsets.only(top: 76),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       userName,
//                       style: const TextStyle(
//                         color: Color(0xFFFFFFFF),
//                         fontFamily: 'SFProText-Bold.ttf',
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22,
//                       ),
//                       softWrap: true,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       userEmail,
//                       style: const TextStyle(
//                         color: Color(0xFFFFFFFF),
//                         fontFamily: 'SFProText-Regular.ttf',
//                         fontSize: 15,
//                       ),
//                       softWrap: true,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.only(top: 76, right: 15),
//                 child: IconButton(
//                   onPressed: onEditPressed,
//                   icon: SvgPicture.asset(
//                     'asset/icon/light_theme/edit.svg',
//                     width: 32,
//                     height: 32,
//                   ),
//                   padding: EdgeInsets.zero,
//                   iconSize: 32,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProfileAppBar extends StatelessWidget {
  final String title; // Заголовок
  final String userName; // Имя пользователя
  final String userEmail; // Почта пользователя
  final String userImageUrl; // URL аватарки пользователя
  final VoidCallback onEditPressed; // Действие при нажатии на "Редактировать"

  const CustomProfileAppBar({
    Key? key,
    required this.title,
    required this.userName,
    required this.userEmail,
    required this.userImageUrl,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200, // Высота градиента
      pinned: true, // Делает AppBar фиксированным
      automaticallyImplyLeading: false, // Убираем стрелку назад
      backgroundColor: const Color(0xFFFFA11E),
      elevation: 0,
      shadowColor: Colors.transparent,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, top: 0), // Отступы
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFFF6F6F6), // Цвет текста
              fontFamily: 'SFProText-Bold.ttf', // Указываем шрифт
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFC60F), // Желтый
                Color(0xFFFF9F0A), // Оранжевый
              ],
              stops: [0.29, 1.0], // Проценты градиента
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 76),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(userImageUrl),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 76),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'SFProText-Bold.ttf',
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEmail,
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'SFProText-Regular.ttf',
                          fontSize: 15,
                        ),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 76, right: 15),
                child: IconButton(
                  onPressed: onEditPressed,
                  icon: SvgPicture.asset(
                    'asset/icon/light_theme/edit.svg',
                    width: 32,
                    height: 32,
                  ),
                  padding: EdgeInsets.zero,
                  iconSize: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
