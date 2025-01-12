import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width, // Ширина блока
        height: 148, // Высота блока
        decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xFF8300B2), width: 1), // Фиолетовая обводка
          borderRadius: BorderRadius.circular(12), // Скругленные углы
        ),
        child: Stack(
          children: [
            // Белый фон
            Container(
              width: MediaQuery.of(context).size.width,
              height: 148,
              decoration: BoxDecoration(
                color: Colors.white, // Белый фон
                borderRadius: BorderRadius.circular(12), // Скругленные углы
              ),
            ),
            // Наложенное SVG изображение
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // Скругляем углы
              child: SvgPicture.asset(
                'asset/icon/subscribe_back.svg',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                //allowDrawingOutsideViewBox: true,
                width: MediaQuery.of(context).size.width,
                // Растягиваем изображение по размеру контейнера
              ),
            ),
            // Слой с текстом и кнопкой
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Спробуйте всі функції',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFProText-Regular.ttf',
                            color: Color(0xFF000000),
                            height: 1.3,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  PRO',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'SFProText-Bold.ttf',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFC60F),
                              ),
                            ),
                            TextSpan(
                                text:
                                    '\nпідписки безкоштовно протягом\n14-денного пробного періоду!'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextButton(
                          onPressed: () {
                            // Здесь будет ваш код, который выполняется при нажатии на кнопку
                            print('Спробувати нажата!');
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size(100,
                                28), // Устанавливаем минимальную ширину в 0
                            //shrinkWrap: true, // Разрешаем кнопке сжиматься по ширине
                            fixedSize: Size(149, 28),
                            backgroundColor: Color(0xFF8300B2),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12), // При необходимости измените радиус скругления
                            ),
                            padding:
                                EdgeInsets.zero, // Убираем внутренние отступы
                          ),
                          child: Text(
                            'Спробувати',
                            style: TextStyle(
                              fontSize: 15, // Размер шрифта можно настроить
                              fontFamily: 'SFProText-Bold.ttf',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Image.asset(
                //   'asset/icon/grape_baner.png',
                //   width: 50,
                //   height: 50,
                //   //fit: BoxFit.cover,
                // ),
              ],
            ),
            Positioned(
              bottom: 5, // Отступ снизу в 13 пикселей
              right:
                  -10, // Отступ справа (можно настроить по своему усмотрению)
              child: SvgPicture.asset(
                'asset/icon/grape.svg',
                width: 63,
                height: 88,
                //fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
