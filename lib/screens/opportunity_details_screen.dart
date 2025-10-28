import 'package:flutter/material.dart';

class OpportunityDetailScreen extends StatelessWidget {
  final String name;
  final String company;
  final String status;
  final String? value;

  const OpportunityDetailScreen({required this.name, required this.company, required this.status, this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Opportunity: $name'),
        backgroundColor: Colors.blue[800]!,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStage('New Lead', Colors.grey),
                _buildArrow(),
                _buildStage('Qualified', Colors.grey),
                _buildArrow(),
                _buildStage('Proposal', status == 'Proposal' ? Colors.blue[800]! : Colors.grey),
                _buildArrow(),
                _buildStage('Won', status == 'Won' ? Colors.green : Colors.grey),
              ],
            ),
            SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100]!,
                  child: Icon(Icons.person, color: Colors.blue[800]!),
                ),
                title: Text(name),
                subtitle: Text(company),
                trailing: status == 'Won' ? Icon(Icons.check_circle, color: Colors.green) : null,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]!),
                  child: Text('Activity'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]!),
                  child: Text('Notes', style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]!),
                  child: Text('Details', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildActivityItem('2 hours ago', 'Follow-up email sent', '17:22:25'),
                  _buildActivityItem('Yesterday', 'Called $name', '12:22:25'),
                  _buildActivityItem('Yesterday', 'Moved to Proposal stage', 'Proposal stage'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue[800]!,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStage(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildArrow() {
    return Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16);
  }

  Widget _buildActivityItem(String time, String description, String timestamp) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100]!,
        child: Icon(Icons.access_time, color: Colors.blue[800]!),
      ),
      title: Text(description),
      subtitle: Text('$time - $timestamp'),
    );
  }
}