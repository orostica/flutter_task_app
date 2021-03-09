import 'package:flutter/material.dart';
import 'package:flutter_task_app/src/ui/home/projects_tab/projects_tab.dart';
import 'package:flutter_task_app/src/ui/home/search_tab/search_tab.dart';
import 'package:flutter_task_app/src/ui/home/tasks_tab/tasks_tab.dart';

//Crtl + . converter para stateful widget
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
with SingleTickerProviderStateMixin {

  int currentIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3, initialIndex: currentIndex);
  }

@override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
          child: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ProjectsTab(),
            TasksTab(),
            SearchTab()
          ],),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 32, 16),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavigationBar(        
              currentIndex: currentIndex,
              onItemTap: (index) {
                _tabController.index = index;
                currentIndex = index;
                setState(() {
                  
                });
              },
              items: <Icon>[
                Icon(Icons.description),
                Icon(Icons.check_circle),
                Icon(Icons.search)
              ],

            ),
            _AddButton(onTap: () {}, icon: Icon(Icons.add, color: Colors.white,),)
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Icon icon;
  final GestureTapCallback onTap;

  const _AddButton({
    @required this.icon,
    @required this.onTap
  }): 
  assert(icon != null),
  assert(onTap != null);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        shape: BoxShape.circle
      ),
      child: Center(child: icon,),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final Function(int) onItemTap;
  final List<Widget> items;
  final int currentIndex;

const _BottomNavigationBar({
   @required this.items,
   @required this.onItemTap, 
   @required this.currentIndex}) 
      : assert(items != null), 
        assert(onItemTap != null), 
        assert(currentIndex != null);

  @override
  Widget build(BuildContext context) {

    return Expanded(child: 
    
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.map((icon) {
        final index = items.indexOf(icon);
        final isSelected = (index == currentIndex);

      return IconButton(
      icon: icon,
      color: isSelected ? Theme.of(context).accentColor : Colors.grey,
      onPressed:() => onItemTap(index));
    }).toList(),));
  }
}