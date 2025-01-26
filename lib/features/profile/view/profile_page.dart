import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:receptico/core/authorization/authorization.dart';
import 'package:receptico/features/profile/widget/promo_banner.dart';

import '../bloc/profile_bloc.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Отправляем событие загрузки профиля
    context.read<ProfileBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded) {
            print('User loaded: ${state.user.plan}');
            return CustomScrollView(
              slivers: [
                // Используем SliverAppBar для фиксации верхнего градиента
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width *
                      0.558, //218, // Высота градиента
                  pinned: true, // Этот параметр делает AppBar фиксированным
                  automaticallyImplyLeading: false, // Убираем стрелку назад
                  backgroundColor: Color(0xFFFFA11E), //FFD60A 0xFFFFA11E
                  elevation: 0, // Убираем тень
                  shadowColor: Colors.transparent, // Убираем тень
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 0, top: 0), // Отступы
                      child: Text(
                        'Профіль', // Заголовок "Профіль"
                        style: TextStyle(
                          color: Color(0xFFF6F6F6), // Цвет текста на AppBar
                          fontFamily: 'SFProText-Bold.ttf', // Указываем шрифт
                          fontWeight: FontWeight.bold, // Толщина шрифта
                          fontSize: 28, // Размер шрифта
                        ),
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFFFC60F), // Цвет 29% (желтый)
                              Color(0xFFFF9F0A), // Цвет 82% (оранжевый)
                            ],
                            stops: [
                              0.29,
                              1.0
                            ], // Указываем проценты: 29% для жёлтого, 82% для оранжевого
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 18),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(state.user.profilePictureUrl),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.04),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                //НУЖНО ПОСТАВИТЬ ОТСТУП 4 МЕЖДУ ИМИНЕМ И ПОЧТОЙ И ПОМЕНЯТЬ ШРИФТ
                                children: [
                                  Text(
                                    state.user.name,
                                    style: TextStyle(
                                      color: Color(
                                          0xFFFFFFFF), // Цвет текста на AppBar
                                      fontFamily:
                                          'SFProText-Bold.ttf', // Указываем шрифт
                                      fontWeight:
                                          FontWeight.bold, // Толщина шрифта
                                      fontSize: 22, // Размер шрифта
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    state.user.email,
                                    style: TextStyle(
                                      color: Color(
                                          0xFFFFFFFF), // Цвет текста на AppBar
                                      fontFamily:
                                          'SFProText-Regular.ttf', // Указываем шрифт
                                      //fontWeight:
                                      //FontWeight., // Толщина шрифта
                                      fontSize: 15, // Размер шрифта
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.10),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF), // Цвет круга
                                  shape: BoxShape.circle, // Форма круга
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    print('Редагувати нажата');
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.pencil, // Иконка карандаша
                                    color: Color(0xFFFF9500), // Цвет иконки
                                    size: 13, // Размер иконки
                                  ),
                                  padding: EdgeInsets
                                      .zero, // Убираем отступы внутри кнопки
                                  constraints:
                                      BoxConstraints(), // Убираем дополнительные ограничения
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Поточний план',
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily:
                                        'SFProText-Bold.ttf', // Указываем шрифт
                                    fontWeight:
                                        FontWeight.bold, // Толщина шрифта
                                    fontSize: 20, // Размер шрифта
                                  ),
                                ),
                                Text(
                                  state.user.plan,
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily:
                                        'SFProText-Regular.ttf', // Указываем шрифт
                                    fontWeight:
                                        FontWeight.w400, // Толщина шрифта
                                    fontSize: 13, // Размер шрифта
                                  ),
                                ),
                              ]),
                          SizedBox(height: 16),
                          PromoBanner(),
                          SizedBox(height: 24),
                          Divider(
                            height: 1, // Высота линии
                            color: Color(0xFFDEDEDE), // Цвет линии DEDEDE
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Система',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily:
                                  'SFProText-Bold.ttf', // Указываем шрифт
                              fontWeight: FontWeight.bold, // Толщина шрифта
                              fontSize: 20, // Размер шрифта
                            ),
                          ),
                          SizedBox(height: 18),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/lang.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              'Мови',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print('Система -> Мови');
                            },
                            //contentPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/bels.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              'Повідомлення',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print('Система -> Повідомлення');
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/sun.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              'Дисплей',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print('Система -> Дисплей');
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.icons,
                                  size: 18, // Размер иконки
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              'Іконки додатку',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print('Система -> Іконки додатку');
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 24),
                          Divider(
                            height: 1, // Высота линии
                            color: Color(0xFFDEDEDE), // Цвет линии DEDEDE
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Підтримка',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily:
                                  'SFProText-Bold.ttf', // Указываем шрифт
                              fontWeight: FontWeight.bold, // Толщина шрифта
                              fontSize: 20, // Размер шрифта
                            ),
                          ),
                          SizedBox(height: 18),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/callback.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              "Зворотній зв'язок",
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print("Система -> Зворотній зв'язок");
                            },
                            //contentPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/error.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              'Повідомити про помилку',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print('Система -> Повідомити про помилку');
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/qvestion.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              'Поширені запитання',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print('Система -> Поширені запитання');
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 24),
                          Divider(
                            height: 1, // Высота линии
                            color: Color(0xFFDEDEDE), // Цвет линии DEDEDE
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Рекомендація',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily:
                                  'SFProText-Bold.ttf', // Указываем шрифт
                              fontWeight: FontWeight.bold, // Толщина шрифта
                              fontSize: 20, // Размер шрифта
                            ),
                          ),
                          SizedBox(height: 18),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/recomend.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              "Розповісти другу!",
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print("Система -> Розповісти другу!");
                            },
                            //contentPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/star.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              'Оцінити додаток',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print('Система -> Оцінити додаток');
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 24),
                          Divider(
                            height: 1, // Высота линии
                            color: Color(0xFFDEDEDE), // Цвет линии DEDEDE
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Інформація',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily:
                                  'SFProText-Bold.ttf', // Указываем шрифт
                              fontWeight: FontWeight.bold, // Толщина шрифта
                              fontSize: 20, // Размер шрифта
                            ),
                          ),
                          SizedBox(height: 18),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/FAQ.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              "Про нас",
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print("Система -> Про нас");
                            },
                            //contentPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/info.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              'Правова інформація',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () {
                              print('Система -> Правова інформація');
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 24),
                          Divider(
                            height: 1, // Высота линии
                            color: Color(0xFFDEDEDE), // Цвет линии DEDEDE
                          ),
                          SizedBox(height: 24),
                          ListTile(
                            leading: SizedBox(
                              width: 18, // Ширина области для иконки
                              height: 18, // Высота области для иконки
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/logOut.svg',
                                  width: 18,
                                  height: 18,
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            trailing: //Icon(FontAwesomeIcons.greaterThan),
                                SizedBox(
                              width: 12, // Ширина области для знака "больше"
                              height: 6, // Высота области для знака "больше"
                              child: Center(
                                child: SvgPicture.asset(
                                  'asset/icon/arrow_right.svg',
                                  width: 6,
                                  height: 12,
                                  color: Color(
                                      0xFFFF3B30), // Устанавливаем цвет иконки
                                  //fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(
                              "Вийти",
                              style: TextStyle(
                                color: Color(0xFFFF3B30),
                                fontFamily:
                                    'SFProText-Bold.ttf', // Указываем шрифт
                                fontWeight: FontWeight.w500, // Толщина шрифта
                                fontSize: 17, // Размер шрифта
                              ),
                            ),
                            onTap: () async {
                              print("Система -> Вийти");
                              await GetIt.I<IAuthorization>().logOut();
                              AutoRouter.of(context).navigateNamed('/');
                            },
                            //contentPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            minVerticalPadding: 0,
                            minTileHeight: 0,
                            dense: true,
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            );
          }

          if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown state!'));
          }
        },
      ),
    );
  }
}
