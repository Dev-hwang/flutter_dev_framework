import 'package:flutter_dev_framework/flutter_dev_framework.dart';
import 'package:flutter_dev_framework_example/blocs/main_bloc.dart';
import 'package:flutter/material.dart';

/// 메인 페이지
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _mainBloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return WithWillPopScope(
      moveBackground: true,
      child: Scaffold(
        appBar: AppBar(title: const Text('flutter_dev_framework')),
        body: _buildContentView()
      ),
    );
  }

  Widget _buildContentView() {
    return Center(
      child: StreamBuilder<StreamResponse<int>>(
        stream: _mainBloc.dataStream,
        initialData: _mainBloc.response,
        builder: (context, snapshot) {
          Widget childWidget;
          if (snapshot.data?.state == StreamResponseState.none)
            childWidget = Text('번호 조회 버튼을 눌러보세요.');
          else if (snapshot.data?.state == StreamResponseState.loading)
            childWidget = CircularProgressIndicator();
          else if (snapshot.data?.state == StreamResponseState.error)
            childWidget = Text('번호 조회 중 오류가 발생했습니다.');
          else
            childWidget = Text('조회 결과: ${snapshot.data?.data}');

          Widget fetchButton;
          if (childWidget is Text)
            fetchButton = ElevatedButton(
              child: Text('번호 조회'),
              onPressed: () => _mainBloc.fetchRandomNumber()
            );
          else
            fetchButton = SizedBox.shrink();

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              childWidget,
              SizedBox(height: 8.0),
              fetchButton
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _mainBloc.dispose();
    super.dispose();
  }
}
