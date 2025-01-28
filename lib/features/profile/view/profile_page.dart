import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:receptico/core/FirebaseAuthService/FirebaseAuthManager.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/profile/service/PlanTranslator.dart';
import 'package:receptico/features/profile/widget/%D1%81ustomProfileAppBar.dart';
import 'package:receptico/features/profile/widget/customListTile.dart';
import 'package:receptico/features/profile/widget/freePlanbanner.dart';
import 'package:receptico/generated/l10n.dart';
import 'package:receptico/providers/locale_provider.dart';
import 'package:provider/provider.dart';

import '../bloc/profile/profile_bloc.dart';

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
    final router = AutoRouter.of(context);
    final localithation = S.of(context);
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    final planTranslator = PlanTranslator(context);
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                size: 40,
                color: Color(0xFF9601CC),
              ),
            );
          }

          if (state is ProfileLoaded) {
            print('User loaded: ${state.user.plan}');
            return CustomScrollView(
              slivers: [
                // Используем SliverAppBar для фиксации верхнего градиента
                CustomProfileAppBar(
                  title:
                      localithation.profilePageTitle, //'Профіль', // Заголовок
                  userName: state.user.name, // Имя пользователя
                  userEmail: state.user.email, // Почта пользователя
                  userImageUrl: state.user.profilePictureUrl, // URL изображения
                  onEditPressed: () {
                    print('Редагувати нажата'); // Действие при нажатии
                  },
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
                                  localithation.currentPlanLable,
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
                                  planTranslator.translate(state.user.plan),
                                  style: TextStyle(
                                    color: Color(0xFF9601CC),
                                    fontFamily:
                                        'SFProText-Regular.ttf', // Указываем шрифт
                                    fontWeight:
                                        FontWeight.w400, // Толщина шрифта
                                    fontSize: 13, // Размер шрифта
                                  ),
                                ),
                              ]),
                          SizedBox(height: 16),
                          if (state.user.plan.toLowerCase() == "free") ...[
                            FreePlanBanner(), // Виджет для бесплатного плана
                          ] else ...[
                            FreePlanBanner(), // Виджет для платного плана
                          ],
                          SizedBox(height: 24),
                          Divider(
                            height: 1, // Высота линии
                            color: Color(0xFFDEDEDE),
                          ),
                          SizedBox(height: 24),
                          Text(
                            localithation.systemTitleList,
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily:
                                  'SFProText-Bold.ttf', // Указываем шрифт
                              fontWeight: FontWeight.bold, // Толщина шрифта
                              fontSize: 20, // Размер шрифта
                            ),
                          ),
                          SizedBox(height: 18),
                          CustomListTile(
                            title: localithation.langLableCustomList,
                            iconPath: 'asset/icon/light_theme/lang.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              final provider = Provider.of<LocaleProvider>(
                                  context,
                                  listen: false);
                              final newLocale = locale.languageCode == 'en'
                                  ? Locale('uk')
                                  : Locale('en');
                              provider.setLocale(newLocale);
                              print('Система -> Мови');
                            },
                          ),
                          SizedBox(height: 16),
                          CustomListTile(
                            title: localithation.notificationLableCustomList,
                            iconPath: 'asset/icon/light_theme/bels.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              print('Система -> Повідомлення');
                            },
                          ),
                          SizedBox(height: 16),
                          CustomListTile(
                            title: localithation.displayLableCustomList,
                            iconPath: 'asset/icon/light_theme/sun.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              print('Система -> Дисплей');
                            },
                          ),
                          SizedBox(height: 16),
                          CustomListTile(
                            title: localithation.iconsLableCustomList,
                            iconPath: 'asset/icon/light_theme/icons_thin.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              print('Система -> Іконки додатку');
                            },
                          ),
                          SizedBox(height: 24),
                          Divider(
                            height: 1, // Высота линии
                            color: Color(0xFFDEDEDE),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            localithation.helpTitleList,
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily:
                                  'SFProText-Bold.ttf', // Указываем шрифт
                              fontWeight: FontWeight.bold, // Толщина шрифта
                              fontSize: 20, // Размер шрифта
                            ),
                          ),
                          SizedBox(height: 18),
                          CustomListTile(
                            title: localithation.callbackLableCustomList,
                            iconPath: 'asset/icon/light_theme/callback.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              print("Підтримка -> Зворотній зв'язок");
                            },
                          ),
                          SizedBox(height: 16),
                          CustomListTile(
                            title: localithation.helpLableCustomList,
                            iconPath: 'asset/icon/light_theme/error.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              print('Підтримка -> Повідомити про помилку');
                            },
                          ),
                          SizedBox(height: 16),
                          CustomListTile(
                            title: localithation.questionLableCustomList,
                            iconPath: 'asset/icon/light_theme/question.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              print('Підтримка -> Поширені запитання');
                            },
                          ),
                          SizedBox(height: 24),
                          Divider(
                            height: 1, // Высота линии
                            color: Color(0xFFDEDEDE),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            localithation.recomendTitleList,
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily:
                                  'SFProText-Bold.ttf', // Указываем шрифт
                              fontWeight: FontWeight.bold, // Толщина шрифта
                              fontSize: 20, // Размер шрифта
                            ),
                          ),
                          SizedBox(height: 18),
                          CustomListTile(
                            title: localithation.recomendLableCustomList,
                            iconPath: 'asset/icon/light_theme/recomend.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              print('Рекомендація -> Розповісти другу!');
                            },
                          ),
                          SizedBox(height: 16),
                          CustomListTile(
                            title: localithation.starLableCustomList,
                            iconPath: 'asset/icon/light_theme/star.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              print('Рекомендація -> Оцінити додаток');
                            },
                          ),
                          SizedBox(height: 24),
                          Divider(
                            height: 1, // Высота линии
                            color: Color(0xFFDEDEDE),
                          ),
                          SizedBox(height: 24),
                          Text(
                            localithation.infoTitleList,
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily:
                                  'SFProText-Bold.ttf', // Указываем шрифт
                              fontWeight: FontWeight.bold, // Толщина шрифта
                              fontSize: 20, // Размер шрифта
                            ),
                          ),
                          SizedBox(height: 18),
                          CustomListTile(
                            title: localithation.aboutUsLableCustomList,
                            iconPath: 'asset/icon/light_theme/FAQ.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              print('Інформація -> Про нас');
                            },
                          ),
                          SizedBox(height: 16),
                          CustomListTile(
                            title: localithation.infoLableCustomList,
                            iconPath: 'asset/icon/light_theme/info.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            onTap: () {
                              print('Інформація -> Правова інформація');
                            },
                          ),
                          SizedBox(height: 24),
                          Divider(
                            height: 1, // Высота линии
                            color: Color(0xFFDEDEDE),
                          ),
                          SizedBox(height: 24),
                          CustomListTile(
                            title: localithation.logOutLableCustomList,
                            iconPath: 'asset/icon/light_theme/logOut.svg',
                            trailingIconPath:
                                'asset/icon/light_theme/arrow.svg',
                            titleColor: Color(0xFFFF271B), // Цвет текста
                            iconColor: Color(0xFFFF271B), // Цвет иконки слева
                            trailingIconColor:
                                Color(0xFFFF271B), // Цвет иконки справа
                            onTap: () async {
                              await GetIt.I<FirebaseAuthManager>().logOut();
                              router.popForced();
                              router.navigate(const LoginRoute());
                              print('Вийти');
                            },
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
