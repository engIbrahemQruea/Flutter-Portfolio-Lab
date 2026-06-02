import 'package:advanced/022_responsive/animations/animations.dart';
import 'package:advanced/022_responsive/models/models.dart';
import 'package:advanced/022_responsive/transitions/list_detail_transition.dart';
import 'package:advanced/022_responsive/widgets/animated_floating_action_button.dart';
import 'package:advanced/022_responsive/widgets/disappearing_bottom_navigation_bar.dart';
import 'package:advanced/022_responsive/widgets/disappearing_navigation_rail.dart';
import 'package:advanced/022_responsive/widgets/email_list_view.dart';
import 'package:advanced/022_responsive/widgets/reply_list_view.dart';
import 'package:flutter/material.dart';

// class FeedMainScreen extends StatelessWidget {
//   const FeedMainScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Main Responsive Screen')),
//       body: Column(
//         children: [
//           Text('This is the main responsive screen.'),

//           StarButton(),

//           // SearchBar(currentUser: User(name: 'John Doe', avatarUrl: 'assets/avatar.png')),
//         ],
//       ),
//     );
//   }
// }

class FeedMainScreen extends StatefulWidget {
  const FeedMainScreen({super.key, required this.currentUser});

  final User currentUser;

  @override
  State<FeedMainScreen> createState() => _FeedMainScreenState();
}

class _FeedMainScreenState extends State<FeedMainScreen>
    with TickerProviderStateMixin {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(
    _colorScheme.primary.withAlpha(36),
    _colorScheme.surface,
  );

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    reverseDuration: const Duration(milliseconds: 1250),
    value: 0,
    vsync: this,
  );
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _railFabAnimation = RailFabAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);

  int selectedIndex = 0;
  bool controllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;

    final AnimationStatus status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          body: Row(
            children: [
              DisappearingNavigationRail(
                railAnimation: _railAnimation,
                railFabAnimation: _railFabAnimation,
                selectedIndex: selectedIndex,
                backgroundColor: _backgroundColor,
                onDestinationSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              Expanded(
                child: Container(
                  color: _backgroundColor,
                  child: ListDetailTransition(
                    animation: _railAnimation,
                    one: EmailListView(
                      selectedIndex: selectedIndex,
                      onSelected: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      currentUser: widget.currentUser,
                    ),
                    two: const ReplyListView(),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: AnimatedFloatingActionButton(
            animation: _barAnimation,
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: DisappearingBottomNavigationBar(
            barAnimation: _barAnimation,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
