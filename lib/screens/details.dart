// import 'package:flutter/material.dart';
//
// import '../widgets/details/detail_back_button.dart';
// import '../widgets/details/item_details_data.dart';
//
// class Details extends StatelessWidget {
//   const Details({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final arguments =
//         ModalRoute.of(context)!.settings.arguments as ClothingItem;
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             ItemDetails(image: arguments.img),
//             ItemTitle(id: arguments.id, name: arguments.name),
//             DetailData(
//                 id: arguments.id,
//                 description: arguments.description,
//                 price: arguments.price),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
//       floatingActionButton: const DetailBackButton(),
//     );
//   }
// }
