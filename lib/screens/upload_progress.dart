import 'package:flutter/material.dart';
import 'package:narr/widgets/container_with_shadow.dart';

class UploadProcessProgress extends StatefulWidget {
  UploadProcessProgress({Key key}) : super(key: key);

  @override
  _UploadProcessProgressState createState() => _UploadProcessProgressState();
}

class _UploadProcessProgressState extends State<UploadProcessProgress> {
  List<ProcessesData> processes = <ProcessesData>[];
  @override
  void initState() {
    processes.add(ProcessesData(
      proccessName: 'testing',
      processStatus: 'Processing',
      isProccessing: true,
      done: false,
    ));
    super.initState();
  }

  bool isDone1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[600],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Processes',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ContainerWithShadow(
          child: Column(
            children: [
              Text(
                'Document Processing',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              Divider(),
              ListView.separated(
                itemCount: processes.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final int steps = index + 1;

                  return ProcessesContainer(
                    step: steps.toString(),
                    isStart: processes[index].isProccessing,
                    isDone: processes[index].done,
                    proccessName: processes[index].proccessName,
                    stage: processes[index].processStatus,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProcessesData {
  String proccessName;
  String processStatus;
  bool isProccessing;
  bool done;

  ProcessesData({
    this.processStatus,
    this.isProccessing,
    this.done,
    this.proccessName,
  });
}

class ProcessesContainer extends StatelessWidget {
  const ProcessesContainer({
    Key key,
    this.isStart,
    this.isDone,
    this.step,
    this.proccessName,
    this.stage = 'Waiting',
  }) : super(key: key);
  final bool isStart;
  final bool isDone;
  final String step;
  final String proccessName;
  final String stage;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Text('step $step'),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$proccessName'),
                  Text('[$stage]'),
                ],
              ),
            ),
            subtitle: isStart
                ? LinearProgressIndicator(
                    value: isDone ? 1 : null,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
