import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_state/controller/controller.dart';
import 'package:lottie/lottie.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    //Merubah Thema
    // return Obx(() => MaterialApp(
    //       title: 'Getx state ${_controller.loading.value}',
    //       theme:_controller.loading.isTrue ? ThemeData.dark() : ThemeData.light(),
    //       home: MyHomePage(title: 'Getx state ${_controller.loading.isTrue}'),
    //     ));

    return MaterialApp(
      title: 'Getx state ${_controller.loading.value}',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Getx state',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    filled: true,
                    isDense: true,
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (value) {
                    if (value == null) {
                      return 'Email is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    isDense: true,
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null) {
                      return 'Password is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    child: const Text('LOG IN'),
                    onPressed: () {
                      _controller.handleLoading();
                      _controller.login(
                        context,
                        _emailController.text,
                        _passwordController.text,
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                if (_controller.loading.value)
                  Lottie.asset(
                    'images/loader.json',
                    repeat: true,
                    reverse: false,
                    animate: true,
                  ),
                // const Center(
                //   child: CircularProgressIndicator(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
