import 'package:flutter/material.dart';
import 'package:aplikasi_tempat_wisata/model/tourism_place.dart';

// Style untuk teks informasi
var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');

// DetailScreen untuk menampilkan detail tempat wisata
class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return DetailWebPage(place: place);
        } else {
          return DetailMobilePage(place: place);
        }
      },
    );
  }
}

// Halaman detail versi web
class DetailWebPage extends StatefulWidget {
  final TourismPlace place;

  const DetailWebPage({super.key, required this.place});

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSection(),
                    const SizedBox(width: 32),
                    _buildInfoCard(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header untuk judul halaman
  Widget _buildHeader() {
    return const Text(
      'Wisata Bandung',
      style: TextStyle(
        fontFamily: 'Staatliches',
        fontSize: 32,
      ),
    );
  }

  // Bagian gambar dan galeri gambar
  Widget _buildImageSection() {
    return Expanded(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(widget.place.imageAsset),
          ),
          const SizedBox(height: 16),
          _buildImageGallery(),
        ],
      ),
    );
  }

  // Galeri gambar horizontal
  Widget _buildImageGallery() {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(bottom: 16),
      child: Scrollbar(
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          children: widget.place.imageUrls.map((url) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(url),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Kartu informasi tempat wisata
  Widget _buildInfoCard() {
    return Expanded(
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildPlaceName(),
              const SizedBox(height: 8.0),
              _buildOpenDaysRow(),
              const SizedBox(height: 8.0),
              _buildOpenTimeRow(),
              const SizedBox(height: 8.0),
              _buildTicketPriceRow(),
              const SizedBox(height: 16.0),
              _buildDescription(),
            ],
          ),
        ),
      ),
    );
  }

  // Nama tempat wisata
  Widget _buildPlaceName() {
    return Text(
      widget.place.name,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 30.0,
        fontFamily: 'Staatliches',
      ),
    );
  }

  // Baris untuk hari buka dan tombol favorit
  Widget _buildOpenDaysRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 8.0),
            Text(
              widget.place.openDays,
              style: informationTextStyle,
            ),
          ],
        ),
        const FavoriteButton(),
      ],
    );
  }

  // Baris untuk waktu buka
  Widget _buildOpenTimeRow() {
    return Row(
      children: [
        const Icon(Icons.access_time),
        const SizedBox(width: 8.0),
        Text(
          widget.place.openTime,
          style: informationTextStyle,
        ),
      ],
    );
  }

  // Baris untuk harga tiket
  Widget _buildTicketPriceRow() {
    return Row(
      children: [
        const Icon(Icons.monetization_on),
        const SizedBox(width: 8.0),
        Text(
          widget.place.ticketPrice,
          style: informationTextStyle,
        ),
      ],
    );
  }

  // Deskripsi tempat wisata
  Widget _buildDescription() {
    return Text(
      widget.place.description,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 16.0,
        fontFamily: 'Oxygen',
      ),
    );
  }
}

// Halaman detail versi mobile
class DetailMobilePage extends StatelessWidget {
  final TourismPlace place;

  const DetailMobilePage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ImageSection(imageAsset: place.imageAsset),
            TitleSection(name: place.name),
            InformationSection(place: place),
            DescriptionSection(description: place.description),
            ImageGallery(imageUrls: place.imageUrls),
          ],
        ),
      ),
    );
  }
}

// Section untuk gambar utama dengan tombol back dan favorite
class ImageSection extends StatelessWidget {
  final String imageAsset;

  const ImageSection({Key? key, required this.imageAsset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(imageAsset),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const FavoriteButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Section untuk judul tempat wisata
class TitleSection extends StatelessWidget {
  final String name;

  const TitleSection({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30.0,
          fontFamily: 'Staatliches',
        ),
      ),
    );
  }
}

// Section untuk informasi dasar seperti hari buka, waktu, dan harga tiket
class InformationSection extends StatelessWidget {
  final TourismPlace place;

  const InformationSection({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InfoItem(icon: Icons.calendar_today, text: place.openDays),
          InfoItem(icon: Icons.access_time, text: place.openTime),
          InfoItem(icon: Icons.monetization_on, text: place.ticketPrice),
        ],
      ),
    );
  }
}

// Item informasi yang berisi ikon dan teks
class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoItem({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(icon),
        const SizedBox(height: 8.0),
        Text(
          text,
          style: informationTextStyle,
        ),
      ],
    );
  }
}

// Section untuk deskripsi tempat wisata
class DescriptionSection extends StatelessWidget {
  final String description;

  const DescriptionSection({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
          fontFamily: 'Oxygen',
        ),
      ),
    );
  }
}

// Galeri gambar horizontal
class ImageGallery extends StatelessWidget {
  final List<String> imageUrls;

  const ImageGallery({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: imageUrls.map((url) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(url),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Tombol Favorite
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
