import 'package:flutter/material.dart';
import 'package:hotstar/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerButton extends StatelessWidget {
  const ShimmerButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {},
      child: Container(
        width: 80,
        height: 20,
        decoration: kGradientBoxDecoration,
        child: Container(
          decoration: kInnerDecoration,
          child: Stack(
            children: [
              Shimmer.fromColors(
                period: const Duration(milliseconds: 2000),
                baseColor: Colors.black26.withOpacity(.8),
                highlightColor: gold.withOpacity(.8),
                direction: ShimmerDirection.ltr,
                child: Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black38.withOpacity(.4),
                        gold,
                        Colors.black38.withOpacity(.4)
                      ],
                    ),
                  ),
                  // child: const Text('asdf'),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => const LinearGradient(
                        colors: [gold, Colors.yellow, gold]).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Text(text,
                        style: const TextStyle(
                          fontSize: 10,
                          color: gold,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final kInnerDecoration = BoxDecoration(
  color: Colors.transparent,
  border: Border.all(color: Colors.transparent),
  borderRadius: BorderRadius.circular(5),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [
    Colors.black38.withOpacity(.7),
    gold,
    Colors.black38.withOpacity(.7)
  ]),
  border: Border.all(
    width: .3,
    color: Colors.transparent,
  ),
  borderRadius: BorderRadius.circular(5),
);


// class ShimmerButton extends StatelessWidget {
//   const ShimmerButton({
//     super.key,
//     required this.onPressed,
//     required this.text,
//   });

//   final VoidCallback onPressed;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(5),
//       onTap: () {},
//       child: Stack(
//         children: [
//           Shimmer.fromColors(
//             period: const Duration(milliseconds: 2000),
//             baseColor: Colors.black26,
//             highlightColor: gold,
//             direction: ShimmerDirection.ltr,
//             child: Container(
//               height: 20,
//               width: 80,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 gradient: const LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Colors.black, gold, Colors.black],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Center(
//               child: ShaderMask(
//                 blendMode: BlendMode.srcIn,
//                 shaderCallback: (bounds) =>
//                     const LinearGradient(colors: [gold, Colors.yellow, gold])
//                         .createShader(
//                   Rect.fromLTWH(0, 0, bounds.width, bounds.height),
//                 ),
//                 child: Text(text,
//                     style: const TextStyle(
//                       fontSize: 11,
//                       color: gold,
//                       fontWeight: FontWeight.bold,
//                     )),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
