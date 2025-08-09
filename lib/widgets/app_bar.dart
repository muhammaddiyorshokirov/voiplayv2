import 'package:flutter/material.dart';
import 'package:anime_tv/utils.dart';

class AnimeTVAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? borderColor;

  const AnimeTVAppBar({
    Key? key,
    this.title = 'Anime TV',
    this.borderColor,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final titleWidgets = <Widget>[];

    // Agar orqaga qaytish mumkin bo'lmasa — logo + bo'sh joy qo'shish
    if (!(ModalRoute.of(context)?.canPop ?? false)) {
      titleWidgets.add(
        Image.asset(
          'assets/icon.png',
          fit: BoxFit.fitHeight,
          height: 50,
        ),
      );
      titleWidgets.add(const SizedBox(width: 15));
    }

    // Sarlavha matni
    titleWidgets.add(
      Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );

    return AppBar(
      shape: Border(
        bottom: BorderSide(
          color: borderColor ?? Theme.of(context).colorScheme.primary,
        ),
      ),
      elevation: 10,
      backgroundColor:
          Theme.of(context).colorScheme.background.lighten(0.06), // YANGILANDI
      title: Row(children: titleWidgets),
    );
  }
}
