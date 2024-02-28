import 'package:flutter/material.dart';
import 'package:missyy/_core/screen_colors.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/page_manager.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {required this.iconData, required this.title, required this.page});
  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page;
    final Color primaryColor = ScreenColors.corPadraoApp;
    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: curPage == page ? Colors.pink[300] : primaryColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page ? Colors.pink[300] : primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
