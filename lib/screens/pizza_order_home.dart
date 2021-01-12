import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_ap/models/incredients.dart';

const _pizzaCartSize = 48.0;

class PizzaOrderHome extends StatefulWidget {
  @override
  _PizzaOrderHomeState createState() => _PizzaOrderHomeState();
}

class _PizzaOrderHomeState extends State<PizzaOrderHome> {
  final _listIncredient = List<Incredients>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pizza Animation",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.brown,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 50.0,
            left: 10,
            right: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 10.0,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: _PizzaDetails(),
                  ),
                  Expanded(
                    flex: 2,
                    child: _PizzaIncrediantItems(),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            child: _PizzaCartButton(
              onTap: () {
                print("cart");
              },
            ),
            bottom: 25,
            height: _pizzaCartSize,
            width: _pizzaCartSize,
            left: MediaQuery.of(context).size.width / 2 - _pizzaCartSize / 2,
          )
        ],
      ),
    );
  }
}

class _PizzaDetails extends StatefulWidget {
  @override
  __PizzaDetailsState createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final _listIngredients = <Incredients>[];
  bool _focused = false;
  int _total = 15;
  final _notifierFocused = ValueNotifier(false);
  List<Animation> _animationList = <Animation>[];
  BoxConstraints _pizzaConstraints;

  Widget _buildIngredientWidget() {
    List<Widget> elemnts = [];
    if (_animationList.isNotEmpty) {
      print(_listIngredients.toString() + "listof incrediant");

      for (int i = 0; i < _listIngredients.length; i++) {
        Incredients incredient = _listIngredients[i];
        final incredientWidget = Image.asset(
          incredient.image,
          height: 40,
        );
        for (int j = 0; j < incredient.position.length; j++) {
          final animation = _animationList[i];
          final position = incredient.position[j];
          final positionX = position.dx;
          final positionY = position.dy;
          double fromX = 0.0, fromY = 0.0;
          if (i == _listIngredients.length - 1) {
            if (j < 1) {
              fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = -_pizzaConstraints.maxHeight * (1 - animation.value);
            } else {
              fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
            }

            final opacity = animation.value;

            if (animation.value > 0) {
              elemnts.add(
                Opacity(
                  opacity: opacity,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..translate(
                        fromX + _pizzaConstraints.maxWidth * positionX,
                        fromY + _pizzaConstraints.maxHeight * positionY,
                      ),
                    child: incredientWidget,
                  ),
                ),
              );
            }
          } else {
            elemnts.add(
              Transform(
                transform: Matrix4.identity()
                  ..translate(
                    fromX + _pizzaConstraints.maxWidth * positionX,
                    fromY + _pizzaConstraints.maxHeight * positionY,
                  ),
                child: incredientWidget,
              ),
            );
          }
        }
      }

      return Stack(children: elemnts);
    }
    return SizedBox.fromSize();
  }

  void _buildIncredientsAnimation() {
    _animationList.clear();
    _animationList.add(
      CurvedAnimation(
        curve: Interval(
          0.0,
          0.8,
          curve: Curves.decelerate,
        ),
        parent: _animationController,
      ),
    );
    _animationList.add(
      CurvedAnimation(
        curve: Interval(
          0.2,
          0.8,
          curve: Curves.decelerate,
        ),
        parent: _animationController,
      ),
    );
    _animationList.add(
      CurvedAnimation(
        curve: Interval(
          0.4,
          1.0,
          curve: Curves.decelerate,
        ),
        parent: _animationController,
      ),
    );
    _animationList.add(
      CurvedAnimation(
        curve: Interval(
          0.1,
          0.7,
          curve: Curves.decelerate,
        ),
        parent: _animationController,
      ),
    );
    _animationList.add(
      CurvedAnimation(
        curve: Interval(
          0.3,
          1.0,
          curve: Curves.decelerate,
        ),
        parent: _animationController,
      ),
    );
    _animationList.add(
      CurvedAnimation(
        curve: Interval(
          0.3,
          1.0,
          curve: Curves.decelerate,
        ),
        parent: _animationController,
      ),
    );
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 400,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: DragTarget<Incredients>(
                onAccept: (ingredient) {
                  _notifierFocused.value = false;
                  setState(() {
                    _total++;
                  });
                  _listIngredients.add(ingredient);
                  _buildIncredientsAnimation();
                  _animationController.forward(from: 0.0);
                },
                onWillAccept: (ingredient) {
                  _notifierFocused.value = true;

                  for (Incredients incredient in _listIngredients) {
                    if (incredient.compare(ingredient)) {
                      return false;
                    }
                  }

                  return true;
                },
                onLeave: (ingredient) {
                  print('onLeave');
                  _notifierFocused.value = false;
                },
                builder: (context, list, rejects) {
                  return LayoutBuilder(builder: (context, constrains) {
                    _pizzaConstraints = constrains;
                    return Center(
                        child: ValueListenableBuilder(
                      valueListenable: _notifierFocused,
                      builder: (context, focused, child) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          height: focused
                              ? constrains.maxHeight
                              : constrains.maxHeight - 10,
                          child: Stack(
                            children: [
                              Image.asset('assets/part1/dish.png'),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset('assets/part1/pizza-1.png'),
                              )
                            ],
                          ),
                        );
                      },
                    ));
                  });
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: Offset(0.0, 0.0),
                      end: Offset(
                        0.0,
                        animation.value - 0.5,
                      ),
                    ),
                  ),
                  child: child,
                );
              },
              child: Text(
                '\$$_total',
                key: Key(_total.toString()),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            )
          ],
        ),
        AnimatedBuilder(
            animation: _animationController,
            builder: (contex, snapShot) {
              return _buildIngredientWidget();
            }),
      ],
    );
  }
}

class _PizzaCartButton extends StatefulWidget {
  final VoidCallback onTap;
  _PizzaCartButton({this.onTap});
  @override
  __PizzaCartButtonState createState() => __PizzaCartButtonState();
}

class __PizzaCartButtonState extends State<_PizzaCartButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future _animateButton() async {
    _animationController.forward(from: 0.0);
    _animationController.reverse(from: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _animateButton();
      },
      child: AnimatedBuilder(
        child: Container(
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 35.0,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.orange.withOpacity(0.5),
                  Colors.orange,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 4.0,
                ),
              ]),
        ),
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: (1 - Curves.easeOut.transform(_animationController.value))
                .clamp(0.5, 1.0),
            child: child,
          );
        },
      ),
    );
  }
}

class _PizzaIncrediantItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var incredient = ingredients.elementAt(index);
        return _PizzaIncredientItem(
          incredient: incredient,
        );
      },
      itemCount: ingredients.length,
    );
  }
}

class _PizzaIncredientItem extends StatelessWidget {
  Incredients incredient;
  _PizzaIncredientItem({
    this.incredient,
  });
  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Color(0xffF5EED3),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            incredient.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
    return Draggable(
      data: incredient,
      feedback: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.black87.withOpacity(.3),
              offset: Offset(
                0.0,
                5.0,
              ),
              spreadRadius: 5.0,
            ),
          ],
        ),
        child: child,
      ),
      child: child,
    );
  }
}
