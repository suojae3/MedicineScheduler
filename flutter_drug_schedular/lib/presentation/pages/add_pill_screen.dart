import 'package:flutter/material.dart';

class AddPillScreen extends StatefulWidget {
  @override
  _AddPillScreenState createState() => _AddPillScreenState();
}

class _AddPillScreenState extends State<AddPillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('약 추가'),
        actions: [
          TextButton(
            onPressed: () {
              // 등록 버튼 클릭 시 로직
            },
            child: const Text(
              '등록',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: '약 이름',
                hintText: '예) 타이레놀',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text('약 사진'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // 사진 등록 로직
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('사진등록'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Text('복용기간')),
                Text('2023.08.01'),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    // 날짜 선택 로직
                  },
                ),
                Text('~'),
                Text('까지'),
              ],
            ),
            SizedBox(height: 20),
            Text('복용주기'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceChip(label: Text('매일'), selected: false),
                ChoiceChip(label: Text('평일'), selected: false),
                ChoiceChip(label: Text('주말'), selected: false),
                ChoiceChip(label: Text('직접 설정'), selected: false),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Text('알림')),
                Text('복용횟수 1'),
                Text('오전 8:00'),
              ],
            ),
            SizedBox(height: 20),
            Text('색상'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                8,
                (index) => CircleAvatar(
                  backgroundColor: Colors.primaries[index],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: '메모',
                hintText: '메모를 입력하세요.',
              ),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
