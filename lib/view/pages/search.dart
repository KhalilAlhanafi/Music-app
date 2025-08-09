import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';
  int _selectedCategoryIndex = 0;

  // Sample data - replace with your actual data
  final List<String> _searchCategories = [
    'All',
    'Songs',
    'Artists',
    'Albums',
    'Playlists',
    'Podcasts',
  ];

  final List<Map<String, dynamic>> _recentSearches = [
    {'title': 'Pop Mix', 'type': 'Playlist'},
    {'title': 'The Weeknd', 'type': 'Artist'},
    {'title': 'Summer Hits 2023', 'type': 'Album'},
    {'title': 'Deep Focus', 'type': 'Playlist'},
  ];

  final List<Map<String, dynamic>> _trendingNow = [
    {
      'title': 'Today\'s Top Hits',
      'image': 'assets/trending1.jpg',
      'type': 'Playlist',
    },
    {'title': 'RapCaviar', 'image': 'assets/trending2.jpg', 'type': 'Playlist'},
    {
      'title': 'All Out 2010s',
      'image': 'assets/trending3.jpg',
      'type': 'Playlist',
    },
    {
      'title': 'Rock Classics',
      'image': 'assets/trending4.jpg',
      'type': 'Playlist',
    },
  ];

  final List<Map<String, dynamic>> _browseAll = [
    {
      'title': 'Podcasts',
      'color': Colors.orange,
      'image': 'assets/podcasts.jpg',
    },
    {
      'title': 'Made For You',
      'color': Colors.purple,
      'image': 'assets/made_for_you.jpg',
    },
    {'title': 'Charts', 'color': Colors.blue, 'image': 'assets/charts.jpg'},
    {
      'title': 'New Releases',
      'color': Colors.green,
      'image': 'assets/new_releases.jpg',
    },
    {'title': 'Discover', 'color': Colors.red, 'image': 'assets/discover.jpg'},
    {'title': 'Concerts', 'color': Colors.teal, 'image': 'assets/concerts.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _isSearching = _searchController.text.isNotEmpty;
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: _buildSearchBar(),
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: _isSearching
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    FocusScope.of(context).unfocus();
                  },
                )
              : null,
          hintText: 'What do you want to listen to?',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isSearching) {
      return _buildSearchResults();
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategories(),
            SizedBox(height: 20),
            _buildRecentSearches(),
            SizedBox(height: 20),
            _buildTrendingNow(),
            SizedBox(height: 20),
            _buildBrowseAll(),
          ],
        ),
      );
    }
  }

  Widget _buildCategories() {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _searchCategories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedCategoryIndex == index
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _searchCategories[index],
                  style: TextStyle(
                    color: _selectedCategoryIndex == index
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent searches',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Column(
            children: _recentSearches.map((search) {
              return ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getIconForType(search['type']),
                    color: Colors.grey,
                  ),
                ),
                title: Text(
                  search['title'],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  search['type'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
                onTap: () {
                  // Handle recent search tap
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingNow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending now',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _trendingNow.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          _trendingNow[index]['image'],
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _trendingNow[index]['title'],
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _trendingNow[index]['type'],
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrowseAll() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Browse all',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: _browseAll.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(color: _browseAll[index]['color']),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(15 / 360),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              _browseAll[index]['image'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Text(
                          _browseAll[index]['title'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    // This would be replaced with actual search results from your API
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildResultSection('Top result', [_buildTopResultCard()]),
        _buildResultSection(
          'Songs',
          List.generate(5, (index) => _buildSongTile(index)),
        ),
        _buildResultSection(
          'Artists',
          List.generate(3, (index) => _buildArtistTile(index)),
        ),
        _buildResultSection(
          'Albums',
          List.generate(3, (index) => _buildAlbumTile(index)),
        ),
        _buildResultSection(
          'Playlists',
          List.generate(2, (index) => _buildPlaylistTile(index)),
        ),
      ],
    );
  }

  Widget _buildResultSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ...items,
      ],
    );
  }

  Widget _buildTopResultCard() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              image: DecorationImage(
                image: AssetImage('assets/artist1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Artist',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'The Weeknd',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'PLAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongTile(int index) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: AssetImage('assets/album${index % 3 + 1}.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        'Song Title ${index + 1}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        'Artist Name',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
      trailing: IconButton(
        icon: Icon(Icons.more_vert, color: Colors.grey),
        onPressed: () {},
      ),
    );
  }

  Widget _buildArtistTile(int index) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/artist${index % 3 + 1}.jpg'),
      ),
      title: Text(
        'Artist ${index + 1}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        'Artist',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
      trailing: IconButton(
        icon: Icon(Icons.more_vert, color: Colors.grey),
        onPressed: () {},
      ),
    );
  }

  Widget _buildAlbumTile(int index) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: AssetImage('assets/album${index % 3 + 1}.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        'Album ${index + 1}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        'Artist Name • Album',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
      trailing: IconButton(
        icon: Icon(Icons.more_vert, color: Colors.grey),
        onPressed: () {},
      ),
    );
  }

  Widget _buildPlaylistTile(int index) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
            colors: [
              Colors.primaries[index % Colors.primaries.length],
              Colors.primaries[(index + 2) % Colors.primaries.length],
            ],
          ),
        ),
        child: Icon(Icons.playlist_play, color: Colors.white),
      ),
      title: Text(
        'Playlist ${index + 1}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        'By Spotify • Playlist',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
      trailing: IconButton(
        icon: Icon(Icons.more_vert, color: Colors.grey),
        onPressed: () {},
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Artist':
        return Icons.person;
      case 'Album':
        return Icons.album;
      case 'Playlist':
        return Icons.playlist_play;
      case 'Podcast':
        return Icons.mic;
      default:
        return Icons.music_note;
    }
  }
}
