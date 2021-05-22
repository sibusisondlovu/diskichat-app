import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildCollapsingBar(context));
  }

  Widget _buildCollapsingBar(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    //titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 80),
                    centerTitle: true,
                    title: Text("DISKILIVE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.asset(
                      "assets/images/home_screen_app_bar_background.jpg",
                      fit: BoxFit.cover,
                    )),
                //bottom:
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      new Tab(icon: new Icon(Icons.info), text: "Following"),
                      new Tab(
                          icon: new Icon(Icons.lightbulb_outline),
                          text: "Videos"),
                      new Tab(
                          icon: new Icon(Icons.lightbulb_outline),
                          text: "My Team"),
                    ],
                  ),
                ),
                floating: false,
                pinned: true,
              ),
            ];
          },
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _buildFollowingMatchCard(context))),
    );
  }

  Widget _buildFollowingMatchCard(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              Container(
                color: Colors.black,
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'DSTV PREMIEMERSHIP',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/away_team_logo.png',
                        width: 70,
                        height: 70,
                      ),
                      Text('Home Team')
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '0 : 0',
                        style: TextStyle(fontSize: 38),
                      ),
                      Chip(
                        labelPadding: EdgeInsets.all(2.0),
                        label: Text(
                          'Live 72 \' ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.red,
                        elevation: 3.0,
                        shadowColor: Colors.grey[60],
                        padding: EdgeInsets.all(5.0),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/images/away_team_logo.png',
                          width: 70, height: 70),
                      Text('Away Team')
                    ],
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people),
                          Text(' 1,234 following')
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.chat_sharp),
                          Text(' 53,301 comments')
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
