import 'package:flutter/material.dart';
import 'package:travelcommunity/screens/post_place_screen.dart';
import 'package:travelcommunity/utils/helper_functions.dart';

class TopPlacesScreen extends StatefulWidget {
  const TopPlacesScreen({super.key});

  @override
  State<TopPlacesScreen> createState() => _TopPlacesScreenState();
}

class _TopPlacesScreenState extends State<TopPlacesScreen> {
  final List<String> places = [
    'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//1.jpg',
    'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//2.jpg',
    'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//3.webp',
    'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//4.jpg',
    'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//5.jpg',
    'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//6.jpg',
    'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//7.webp',
    'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//8.jpg',
    'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//9.jpg',
    'https://iudrtzlfoonghkyqkzty.supabase.co/storage/v1/object/public/images//10.jpg',
  ];

  final List<String> names = [
    "Paris",
    "Bali",
    "Tokyo",
    "Rome",
    "Dubai",
    "New York",
    "Istanbul",
    "Cape Town",
    "Barcelona",
    "Santorini",
  ];

  final List<String> locations = [
    "Paris, France",
    "Bali, Indonesia",
    "Tokyo, Japan",
    "Rome, Italy",
    "Dubai, UAE",
    "New York City, USA",
    "Istanbul, Türkiye",
    "Cape Town, South Africa",
    "Barcelona, Spain",
    "Santorini, Greece",
  ];

  final List<String> captions = [
    "City of lights and love — Paris never disappoints ✨",
    "Tropical paradise with soul-soothing sunsets 🌴",
    "The future meets tradition in vibrant Tokyo 🏮",
    "Ancient ruins and timeless beauty 🇮🇹",
    "From deserts to skyscrapers — Dubai dreams 🏙️",
    "The city that never sleeps and always shines 🌆",
    "Where East meets West in magical harmony 🌉",
    "Mountains, beaches, and pure adventure 🌄",
    "Colorful streets and Gaudí's genius 🏛️",
    "Blue domes and endless views — a Greek fantasy 💙",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            HelperFunctions.customAppBar("Top Places", context),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7, // Slightly wider cards
                  ),
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            // Image with shimmer effect
                            Image.network(
                              places[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.broken_image),
                              ),
                            ),

                            // Gradient overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Content
                            Positioned(
                              left: 12,
                              right: 12,
                              bottom: 12,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    names[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 6,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    locations[index],
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Tap target
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PostPlaceScreen(
                                        caption: captions[index],
                                        location: locations[index],
                                        url: places[index],
                                        name: names[index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
