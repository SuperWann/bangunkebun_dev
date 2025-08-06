import 'package:bangunkebun_dev/config.dart';
import 'package:bangunkebun_dev/pages/ecommercePage.dart/ecommercePage.dart';
import 'package:bangunkebun_dev/widgets/roundedNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Navbar extends StatefulWidget {
  static const routeName = '/navbar';

  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  int index = 0; 

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0; 
      });
      return false; 
    } else {
      if (index == 0) {
        Fluttertoast.showToast(
          msg: "Tekan sekali lagi untuk keluar",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xFF828282).withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0,

        );
        index++;

        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) { 
            setState(() {
              index = 0;
            });
          }
        });

        return false;
      } else {
        SystemNavigator.pop();
        return true;
      }
    }
  }

  final List<Widget> _pages = [ 
    const EcommercePage(),

  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is int) {
      setState(() {
        _currentIndex = arguments.clamp(0, _pages.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white, 
        statusBarIconBrightness: Brightness.dark, 
        statusBarBrightness: Brightness.light,
        systemStatusBarContrastEnforced: false,
      ),
      child: PopScope( 
        canPop: false,
        onPopInvoked: (didPop) async {
          if (!didPop) {
            final shouldPop = await _onWillPop();
            if (shouldPop && context.mounted) {
              SystemNavigator.pop();
            }
          }
        },
        child: Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              IndexedStack(index: _currentIndex, children: _pages),
              FloatingNavBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: NavBarConfig.mainNavItems,
                activeColor: const Color(0xFF007B29), 
                backgroundColor: Colors.white,
                bottomMargin: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}