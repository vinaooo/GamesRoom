import 'package:flutter/material.dart';
import 'my_flutter_app_icons.dart';

class IconPickerDialog extends StatefulWidget {
  final List<IconData> icons;
  final void Function(IconData selectedIcon) onIconSelected;

  const IconPickerDialog({
    Key? key,
    required this.icons,
    required this.onIconSelected,
  }) : super(key: key);

  @override
  IconPickerDialogState createState() => IconPickerDialogState();
}

class IconPickerDialogState extends State<IconPickerDialog> {
  IconData? selectedIcon;
  Color? selectedColor;

  void onColorSelected(Color color) {
    setState(() {
      selectedColor = color;
      cor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          children: [
            GridView.count(
                crossAxisCount: 6,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                shrinkWrap: true,
                children: widget.icons
                    .map(
                      (iconData) => InkWell(
                        onTap: () {
                          widget.onIconSelected(iconData);
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          iconData,
                          size: 24,
                          color: selectedColor,
                        ),
                      ),
                    )
                    .toList()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () =>
                      onColorSelected(const Color.fromARGB(200, 33, 149, 243)),
                  icon: const Icon(Icons.circle,
                      color: Color.fromARGB(200, 33, 149, 243)),
                ),
                IconButton(
                  onPressed: () =>
                      onColorSelected(const Color.fromARGB(150, 233, 30, 98)),
                  icon: const Icon(
                    Icons.circle,
                    color: Color.fromARGB(150, 233, 30, 98),
                  ),
                ),
                IconButton(
                  onPressed: () => onColorSelected(Colors.orange),
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.yellow,
                  ),
                ),
                IconButton(
                  onPressed: () => onColorSelected(Colors.grey),
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () => onColorSelected(Colors.green),
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () => onColorSelected(Colors.amber),
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.amber,
                  ),
                ),
                IconButton(
                  onPressed: () => onColorSelected(Colors.red),
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () => onColorSelected(Colors.brown),
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.brown,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Color cor = Colors.grey;

class IconPicker extends StatefulWidget {
  const IconPicker({Key? key}) : super(key: key);

  @override
  IconPickerState createState() => IconPickerState();
}

class IconPickerState extends State<IconPicker> {
  late IconData selectedIcon = MyIcons.emoHappy;

  void onIconSelected(IconData icon) {
    setState(() {
      selectedIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: cor,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => IconPickerDialog(
            icons: const [
              MyIcons.emoHappy,
              MyIcons.emoWink,
              MyIcons.emoUnhappy,
              MyIcons.emoSleep,
              MyIcons.emoThumbsup,
              MyIcons.emoDevil,
              MyIcons.emoSurprised,
              MyIcons.emoTongue,
              MyIcons.emoCoffee,
              MyIcons.emoSunglasses,
              MyIcons.emoDispleased,
              MyIcons.emoGrin,
              MyIcons.emoAngry,
              MyIcons.emoSaint,
              MyIcons.emoCry,
              MyIcons.emoSquint,
              MyIcons.emoLaugh,
              MyIcons.emoWink2,
              MyIcons.smiley,
              MyIcons.user,
              MyIcons.smile,
              MyIcons.frown,
              MyIcons.meh,
              MyIcons.female,
              MyIcons.male,
              MyIcons.child,
              MyIcons.school,
              MyIcons.falling,
              MyIcons.skull,
              MyIcons.monsterSkull,
              MyIcons.userSecret,
              MyIcons.soccerBall,
              MyIcons.soccer,
              MyIcons.dribble,
              MyIcons.giraffe,
              MyIcons.crown,
              MyIcons.crownPlus,
              MyIcons.crownMinus,
              MyIcons.acorn,
              MyIcons.carrot,
              MyIcons.cheese,
              MyIcons.chickenLeg,
              MyIcons.crabClaw,
              MyIcons.footprint,
              MyIcons.gecko,
              MyIcons.rabbit,
              MyIcons.squirrel,
              MyIcons.ruby,
            ],
            onIconSelected: onIconSelected,
          ),
        );
      },
      icon: Icon(selectedIcon),
    );
  }
}
