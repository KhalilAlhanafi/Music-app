// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_2/view/pages/player.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Sample song data with images and audio paths
  final List<Map<String, String>> recentlyPlayedSongs = const [
    {
      'title': 'PUFFIN ON ZOOTIEZ',
      'artist': 'Futur',
      'image': 'assets/images/Zootiez.png',
      'audio': 'assets/audio/PUFFIN.mp3',
    },
    {
      'title': 'Flocky Flocky (feat.Traviss Scott)',
      'artist': 'Don Toliver',
      'image': 'assets/images/Flocky.png',
      'audio': 'assets/audio/Flocky.mp3',
    },
    {
      'title': 'Lelly Yah',
      'artist': 'Marwan Pablo',
      'image': 'assets/images/Lelly.png',
      'audio': 'assets/audio/Lelly.mp3',
    },
    {
      'title': 'Amrikkka',
      'artist': 'Shabjdeed,Al Nather',
      'image': 'assets/images/Amrikkka.jpg',
      'audio': 'assets/audio/Amrikkka.mp3',
    },
    {
      'title': 'Blinding Lights',
      'artist': 'The Weeknd',
      'image': 'assets/images/blinding.jpg',
      'audio': 'assets/audio/song5.mp3',
    },
  ];

  final List<Map<String, String>> recommendedSongs = const [
    {
      'title': 'Ghaba',
      'artist': 'Marwan Pablo',
      'image': 'assets/images/Ghaba.png',
      'audio': 'assets/audio/song6.mp3',
    },
    {
      'title': 'PURPLE RAIN (FEAT.FUTURE & METRO BOOMIN)',
      'artist': 'Don Toliver',
      'image': 'assets/images/Purple.jpg',
      'audio': 'assets/audio/song7.mp3',
    },
    {
      'title': 'EVIL JORDAN',
      'artist': 'PlayboyCarti',
      'image': 'assets/images/Evil.jpg',
      'audio': 'assets/audio/song8.mp3',
    },
    {
      'title': 'Chitheb',
      'artist': 'Shabjdeed,Al Nather',
      'image': 'assets/images/Chetheb.jpg',
      'audio': 'assets/audio/song9.mp3',
    },
    {
      'title': 'Thank God',
      'artist': 'traviss Scott',
      'image': 'assets/images/Thank.jpg',
      'audio': 'assets/audio/song10.mp3',
    },
  ];

  final List<Map<String, String>> artistsBasedOnTaste = const [
    {'name': 'Yeat', 'image': 'assets/images/yeat.jpg'},
    {'name': 'Future', 'image': 'assets/images/future.jpg'},
    {'name': 'Shabjdeed', 'image': 'assets/images/shabjdeed.jpg'},
    {'name': 'Don Toliver', 'image': 'assets/images/don.jpg'},
    {'name': '21 Savage', 'image': 'assets/images/savage.jpg'},
    {'name': 'Travis Scott', 'image': 'assets/images/travis.jpg'},
    {'name': 'Marwan Pablo', 'image': 'assets/images/marwan.jpg'},
    {'name': 'Metro Boomin', 'image': 'assets/images/metro.jpg'},
  ];

  final List<Map<String, String>> topCharts = const [
    {
      'title': 'Leather Coat',
      'artist': 'Don Toliver',
      'image': 'assets/images/Leather.jpg',
      'audio': 'assets/audio/song11.mp3',
    },
    {
      'title': 'Overload',
      'artist': 'Future , Metro Boomin',
      'image': 'assets/images/Overload.jpg',
      'audio': 'assets/audio/song12.mp3',
    },
    {
      'title': 'If We Being Real',
      'artist': 'Yeat',
      'image': 'assets/images/if_we.jpg',
      'audio': 'assets/audio/song13.mp3',
    },
    {
      'title': 'Creepin\'',
      'artist': 'Metro Boomin, The Weeknd, 21 Savage',
      'image': 'assets/images/Creepin.jpg',
      'audio': 'assets/audio/song14.mp3',
    },
    {
      'title': 'ALL RED',
      'artist': 'Playboy Carti',
      'image': 'assets/images/all_red.png',
      'audio': 'assets/audio/song15.mp3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 250),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeSection(),
              const SizedBox(height: 24),

              _buildSectionHeader('Recently Played'),
              const SizedBox(height: 12),
              _buildHorizontalMusicList(context, recentlyPlayedSongs),
              const SizedBox(height: 24),

              _buildSectionHeader('Recommended For You'),
              const SizedBox(height: 12),
              _buildVerticalMusicList(context, recommendedSongs),
              const SizedBox(height: 24),

              _buildSectionHeader('Popular Playlists'),
              const SizedBox(height: 12),
              _buildPlaylistGrid(context), // now fixed height
              const SizedBox(height: 24),

              _buildSectionHeader('Artists based on your taste'),
              const SizedBox(height: 12),
              _buildArtistsList(artistsBasedOnTaste),
              const SizedBox(height: 24),

              _buildSectionHeader('Recently Played'),
              const SizedBox(height: 12),
              _buildHorizontalMusicList(context, recentlyPlayedSongs),
              const SizedBox(height: 24),

              _buildSectionHeader('Top Charts'),
              const SizedBox(height: 12),
              _buildChartList(context, topCharts),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'What would you like to listen today?',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'More',
            style: TextStyle(
              color: Colors.blue, // Or use your app's primary color
              fontWeight: FontWeight.w500,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero, // Removes extra padding
            minimumSize: Size.zero, // Makes button as small as its content
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalMusicList(
    BuildContext context,
    List<Map<String, String>> songs,
  ) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToPlayer(context, songs[index]),
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(songs[index]['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    songs[index]['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    songs[index]['artist']!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalMusicList(
    BuildContext context,
    List<Map<String, String>> songs,
  ) {
    return Column(
      children: List.generate(songs.length, (index) {
        return GestureDetector(
          onTap: () => _navigateToPlayer(context, songs[index]),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(songs[index]['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songs[index]['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        songs[index]['artist']!,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPlaylistGrid(BuildContext context) {
    final List<Map<String, String>> playlists = const [
      {
        'name': 'Today\'s Top Hits',
        'description': 'The most popular songs right now',
        'image': 'assets/images/Creepin.jpg',
        'audio': 'assets/audio/song1.mp3',
      },
      {
        'name': 'Chill Vibes',
        'description': 'Relaxing tunes for your day',
        'image': 'assets/images/Free.jpg',
        'audio': 'assets/audio/song2.mp3',
      },
      {
        'name': 'Workout Energy',
        'description': 'Pump up your exercise routine',
        'image': 'assets/images/Drake.jpg',
        'audio': 'assets/audio/song3.mp3',
      },
      {
        'name': 'Focus Flow',
        'description': 'Concentration enhancing tracks',
        'image': 'assets/images/VULTURES.png',
        'audio': 'assets/audio/song4.mp3',
      },
    ];

    return SizedBox(
      height: 300, // Or calculate dynamically based on item count
      child: GridView.builder(
        physics:
            const NeverScrollableScrollPhysics(), // disable internal scroll
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
        ),
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return GestureDetector(
            onTap: () => _navigateToPlayer(context, {
              'title': playlist['name']!,
              'artist': 'Various Artists',
              'image': playlist['image']!,
              'audio': playlist['audio']!,
            }),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(playlist['image']!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        playlist['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        playlist['description']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildArtistsList(List<Map<String, String>> artists) {
    return SizedBox(
      height: 120, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: artists.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80, // Adjust width as needed
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                // Circle Avatar
                CircleAvatar(
                  radius: 40, // Adjust size as needed
                  backgroundImage: AssetImage(artists[index]['image']!),
                ),
                const SizedBox(height: 8),
                // Artist Name
                Text(
                  artists[index]['name']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChartList(
    BuildContext context,
    List<Map<String, String>> songs,
  ) {
    return Column(
      children: List.generate(songs.length, (index) {
        return GestureDetector(
          onTap: () => _navigateToPlayer(context, songs[index]),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: AssetImage(songs[index]['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songs[index]['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        songs[index]['artist']!,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _navigateToPlayer(context, songs[index]),
                  icon: const Icon(Icons.play_circle_fill, color: Colors.blue),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _navigateToPlayer(BuildContext context, Map<String, String> songData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerPage(
          songTitle: songData['title']!,
          artist: songData['artist']!,
          imagePath: songData['image']!,
          audioPath: songData['audio']!,
        ),
      ),
    );
  }
}
