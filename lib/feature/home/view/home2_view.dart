import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_excercise/feature/home/view/mixin/home_view_mixin.dart';
import 'package:health_excercise/product/init/cache/shared_manager.dart';
import 'package:health_excercise/product/init/config/app_enviroment.dart';
import 'package:health_excercise/product/init/localization/product_localization.dart';
import 'package:health_excercise/product/navigation/app_router.dart';
import 'package:health_excercise/product/utility/constants/enums/locales.dart';
import 'package:kartal/kartal.dart';

/// Home view
@RoutePage()
final class HomeView extends StatefulWidget {
  /// Home view constructor
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            TextButton(
              onPressed: () {
                SharedManager.setDataUsage(answer: false);
                _determinePosition();
                context.router.push(const SunnyDayRoute());
              },
              child: const Text('CountDown'),
            ),
            const CustomNetworkImage(
              imageUrl: 'https://picsum.photos/250?image=9',
              size: Size(200, 200),
            ),
            Assets.icons.icLove.svg(
              package: 'gen',
            ),
            Assets.lottie.animZombie.lottie(
              package: 'gen',
            ),
            Assets.images.imgFlags.image(
              package: 'gen',
            ),
            ElevatedButton(
              onPressed: () {
                ProductLocalization.updateLanguage(
                  context: context,
                  value: Locales.en,
                );
              },
              child: Text(
                AppEnviormentItem.baseUrl.value,
                style: context.general.textTheme.bodySmall?.copyWith(
                  color: ColorName.crimsonRed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
