import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golf/golf_components2.dart';
import 'controller/golf_bloc.dart';
import 'controller/golf_event.dart';
import 'controller/golf_state.dart';
import 'golf_components.dart'; // Your component class

class GolfTablePage extends StatelessWidget {
  final GolfTableComponents components; // Declare components

  GolfTablePage({Key? key})
      : components = GolfTableComponents(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GolfBloc()..add(LoadGolfData()),
      // Initialize GolfBloc and trigger LoadGolfData event
      child: Scaffold(
        appBar: AppBar(title: const Text('Golf Score Table')),
        body: BlocBuilder<GolfBloc, GolfState>(
          builder: (context, state) {
            if (state is GolfLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GolfLoaded) {

              return GolfTableComponents2(
                      playerDetails: state.playerDetails,
                      scoreDetails: state.scoreDetails,
                      sloapSss: state.slopeAndSSS,startHole: 5)
                  .buildGolfTable(context);
            } else if (state is GolfError) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'controller.dart';
// import 'golf_components.dart';
//
// class GolfTablePage extends StatelessWidget {
//   final GolfController controller = Get.put(GolfController());
//   final GolfTableComponents components; // Declare components
//
//   GolfTablePage({Key? key})
//       : components = GolfTableComponents(Get.find<GolfController>()),
//         super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Golf Score Table')),
//       body: Obx(() {
//         if (controller.playerDetails.isEmpty ||
//             controller.scoreDetails.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           return components
//               .buildGolfTable(context); // Use the components class to build the table
//         }
//       }),
//     );
//   }
// }
