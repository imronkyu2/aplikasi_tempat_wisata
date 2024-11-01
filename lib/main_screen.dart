import 'package:flutter/material.dart';
import 'package:aplikasi_tempat_wisata/detail_screen.dart';
import 'package:aplikasi_tempat_wisata/model/tourism_place.dart';

// Halaman utama aplikasi
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Bandung'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            // Tampilkan dalam bentuk list untuk layar kecil
            return const TourismPlaceList();
          } else if (constraints.maxWidth <= 1200) {
            // Tampilkan dalam bentuk grid dengan 4 kolom untuk layar sedang
            return const TourismPlaceGrid(gridCount: 4);
          } else {
            // Tampilkan dalam bentuk grid dengan 6 kolom untuk layar besar
            return const TourismPlaceGrid(gridCount: 6);
          }
        },
      ),
    );
  }
}

// Widget untuk menampilkan daftar tempat wisata dalam bentuk list
class TourismPlaceList extends StatelessWidget {
  const TourismPlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tourismPlaceList.length,
      itemBuilder: (context, index) {
        final TourismPlace place = tourismPlaceList[index];
        return TourismPlaceListItem(place: place);
      },
    );
  }
}

// Item dalam daftar tempat wisata
class TourismPlaceListItem extends StatelessWidget {
  final TourismPlace place;

  const TourismPlaceListItem({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(place: place);
        }));
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.asset(place.imageAsset),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      place.name,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10),
                    Text(place.location),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk menampilkan daftar tempat wisata dalam bentuk grid
class TourismPlaceGrid extends StatelessWidget {
  final int gridCount;

  const TourismPlaceGrid({Key? key, required this.gridCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.count(
        crossAxisCount: gridCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: tourismPlaceList.map((place) {
          return TourismPlaceGridItem(place: place);
        }).toList(),
      ),
    );
  }
}

// Item dalam grid tempat wisata
class TourismPlaceGridItem extends StatelessWidget {
  final TourismPlace place;

  const TourismPlaceGridItem({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(place: place);
        }));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                place.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                place.name,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(place.location),
            ),
          ],
        ),
      ),
    );
  }
}
