import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:pull_point/presentation/map/ui/screens/pick_location_screen.dart';
import '../../../ui_kit/ui_kit.dart';

class CreatePullPointScreen extends StatefulWidget {
  const CreatePullPointScreen({Key? key}) : super(key: key);

  @override
  State<CreatePullPointScreen> createState() => _CreatePullPointScreenState();
}

class _CreatePullPointScreenState extends State<CreatePullPointScreen> {
  LatLng? pickedLocation;

  void updateLocation(LatLng? location) {
    setState(() {
      pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      appBar: AppBar(title: const Text("Создание выступления")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TouchableOpacity(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => PickLocationScreen(
                        onSubmit: updateLocation,
                        initialCenter: pickedLocation,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: mediaQuery.size.width,
                  height: 100,
                  decoration: const BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Center(
                    child: Text(pickedLocation == null
                        ? "Выбрать место проведения"
                        : "lat: ${pickedLocation!.latitude.toStringAsFixed(4)} , lon: ${pickedLocation!.longitude.toStringAsFixed(4)}"),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const AppTextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              const SizedBox(height: 16),
              // LongButton(
              //   backgroundGradient: AppGradients.main,
              //   child: AppText("Создать", textColor: Colors.white),
              // ),
              TouchableOpacity(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: mediaQuery.size.width,
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: const Center(child: Text("confirm", style: TextStyle(color: Colors.white))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
