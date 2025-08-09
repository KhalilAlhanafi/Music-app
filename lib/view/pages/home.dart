// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vipe_mind/view/pages/player.dart';

// Static constant data moved outside the widget
const List<Map<String, String>> recentlyPlayedSongs = [
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

const List<Map<String, String>> recommendedSongs = [
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

const List<Map<String, String>> artistsBasedOnTaste = [
  {'name': 'Yeat', 'image': 'assets/images/yeat.jpg'},
  {'name': 'Future', 'image': 'assets/images/future.jpg'},
  {'name': 'Shabjdeed', 'image': 'assets/images/shabjdeed.jpg'},
  {'name': 'Don Toliver', 'image': 'assets/images/don.jpg'},
  {'name': '21 Savage', 'image': 'assets/images/savage.jpg'},
  {'name': 'Travis Scott', 'image': 'assets/images/travis.jpg'},
  {'name': 'Marwan Pablo', 'image': 'assets/images/marwan.jpg'},
  {'name': 'Metro Boomin', 'image': 'assets/images/metro.jpg'},
];

const List<Map<String, String>> topCharts = [
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

const List<Map<String, String>> playlists = [
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 250),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _WelcomeSection(),
              const SizedBox(height: 24),

              _SectionHeader(title: 'Recently Played', onMorePressed: () {}),
              const SizedBox(height: 12),
              _HorizontalMusicList(songs: recentlyPlayedSongs),
              const SizedBox(height: 24),

              _SectionHeader(
                title: 'Recommended For You',
                onMorePressed: () {},
              ),
              const SizedBox(height: 12),
              _VerticalMusicList(songs: recommendedSongs),
              const SizedBox(height: 24),

              _SectionHeader(title: 'Popular Playlists', onMorePressed: () {}),
              const SizedBox(height: 12),
              _PlaylistGrid(),
              const SizedBox(height: 24),

              _SectionHeader(
                title: 'Artists based on your taste',
                onMorePressed: () {},
              ),
              const SizedBox(height: 12),
              _ArtistsList(artists: artistsBasedOnTaste),
              const SizedBox(height: 24),

              _SectionHeader(title: 'Top Charts', onMorePressed: () {}),
              const SizedBox(height: 12),
              _ChartList(songs: topCharts),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    final colorGrey800 = Colors.grey[800];
    final colorGrey600 = Colors.grey[600];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: colorGrey800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'What would you like to listen today?',
          style: TextStyle(fontSize: 16, color: colorGrey600),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onMorePressed;

  const _SectionHeader({required this.title, required this.onMorePressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onMorePressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'More',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _HorizontalMusicList extends StatelessWidget {
  final List<Map<String, String>> songs;

  const _HorizontalMusicList({required this.songs});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final song = songs[index];
          return _MusicCardHorizontal(
            title: song['title']!,
            artist: song['artist']!,
            imagePath: song['image']!,
            onTap: () => _navigateToPlayer(context, song),
          );
        },
      ),
    );
  }
}

class _MusicCardHorizontal extends StatelessWidget {
  final String title;
  final String artist;
  final String imagePath;
  final VoidCallback onTap;

  const _MusicCardHorizontal({
    required this.title,
    required this.artist,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              artist,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _VerticalMusicList extends StatelessWidget {
  final List<Map<String, String>> songs;

  const _VerticalMusicList({required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final song = songs[index];
        return _MusicCardVertical(
          title: song['title']!,
          artist: song['artist']!,
          imagePath: song['image']!,
          onTap: () => _navigateToPlayer(context, song),
        );
      },
    );
  }
}

class _MusicCardVertical extends StatelessWidget {
  final String title;
  final String artist;
  final String imagePath;
  final VoidCallback onTap;

  const _MusicCardVertical({
    required this.title,
    required this.artist,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath),
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
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  artist,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}

class _PlaylistGrid extends StatelessWidget {
  const _PlaylistGrid();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: playlists.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
        ),
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
                  padding: const EdgeInsets.all(8),
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
}

class _ArtistsList extends StatelessWidget {
  final List<Map<String, String>> artists;

  const _ArtistsList({required this.artists});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: artists.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final artist = artists[index];
          return SizedBox(
            width: 80,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(artist['image']!),
                ),
                const SizedBox(height: 8),
                Text(
                  artist['name']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ChartList extends StatelessWidget {
  final List<Map<String, String>> songs;

  const _ChartList({required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final song = songs[index];
        return GestureDetector(
          onTap: () => _navigateToPlayer(context, song),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(song['image']!),
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
                      song['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      song['artist']!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
        );
      },
    );
  }
}

void _navigateToPlayer(BuildContext context, Map<String, String> song) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlayerPage(
        audioPath: song['audio']!,
        songTitle: song['title']!,
        artist: song['artist']!, // changed here
        imagePath: song['image']!, // changed here
      ),
    ),
  );
}
