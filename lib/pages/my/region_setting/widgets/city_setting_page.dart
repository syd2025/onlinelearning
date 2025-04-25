import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class CitySettingPage extends StatelessWidget {
  CitySettingPage({super.key});

  final controller = Get.put(RegionSettingController());

  // 主视图
  Widget _buildView(BuildContext context) {
    final regions = controller.regions;
    if (regions?.isEmpty ?? true) {
      return EmptyContentWidget(
        loading: controller.loading,
        error: controller.error,
        reloadAction: controller.loadRegions,
      );
    } else {
      return _buildRegionList(context);
    }
  }

  Widget _buildRegionList(BuildContext context) {
    final regions = controller.regions!;
    final Color dividerColor;
    if (Theme.of(context).brightness == Brightness.light) {
      dividerColor = Colors.grey[200]!;
    } else {
      dividerColor = Colors.grey[800]!;
    }
    return ListView.separated(
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 15, right: 20),
        child: Divider(
          color: dividerColor,
          height: 0.25,
        ),
      ),
      itemCount: regions.length,
      itemBuilder: (context, index) {
        final region = regions[index];
        return ListTile(
          title: Text(region.name),
          trailing: controller.selectedCode == region.code
              ? Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                )
              : controller.level < 5 && region.category != 10000
                  ? Icon(
                      Icons.arrow_forward_ios,
                      color: dividerColor,
                      size: 15,
                    )
                  : null,
          onTap: () {
            controller.regionRowTapped(region);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionSettingController>(
      init: controller,
      id: "city_setting",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              controller.title,
              style: TextStyle(fontSize: 14),
            ),
          ),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
