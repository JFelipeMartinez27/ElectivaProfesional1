import 'package:flutter/material.dart';

class ComidaScreen extends StatelessWidget {
  const ComidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comida'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.apple), text: 'Frutas'),
              Tab(icon: Icon(Icons.cookie), text: 'Quesos'),
              Tab(icon: Icon(Icons.local_drink), text: 'Bebidas'),
            ],
            labelColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            // comidas
            ComidaGrid(
              items: [
                ComidaItem(
                  nombre: 'Manzana',
                  imageUrl:
                      'https://andreuprados.com/wp-content/uploads/2017/01/apple_0.jpg.webp',
                ),
                ComidaItem(
                  nombre: 'Mango',
                  imageUrl:
                      'https://solofruver.com/wp-content/uploads/2020/06/mango.jpg.webp',
                ),
                ComidaItem(
                  nombre: 'Sandia',
                  imageUrl:
                      'https://www.gob.mx/cms/uploads/article/main_image/39394/IMG_4111.JPG',
                ),
                
              ],
            ),
            // Quesos
            ComidaGrid(
              items: [
                ComidaItem(
                  nombre: 'Mozarella',
                  imageUrl:
                      'https://simmerandsage.com/wp-content/uploads/2024/08/Homemade-Mozzarella1-1024x1024.jpg',
                ),
                ComidaItem(
                  nombre: 'Parmesano',
                  imageUrl:
                      'https://cheesemaking.com/cdn/shop/products/parmesan-style-cheese-making-recipe-565200.jpg?v=1759251845&width=600',
                ),
                ComidaItem(
                  nombre: 'Gouda',
                  imageUrl:
                      'https://i0.wp.com/www.gastronoming.com/wp-content/uploads/2023/01/Queso-Gouda.jpg?w=900&ssl=1',
                ),
                
              ],
            ),
            // Bebidas
            ComidaGrid(
              items: [
                ComidaItem(
                  nombre: 'Frozen Margarita',
                  imageUrl:
                      'https://www.liquor.com/thmb/V5L3hv-w8ph2_RQi_-simg-4Ris=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/Frozen-Margarita-1500x1500-hero-191e49b3ab4f4781b93f3cfacac25136.jpg',
                ),
                ComidaItem(
                  nombre: 'Piña Colada',
                  imageUrl:
                      'https://cdn.shopify.com/s/files/1/0245/4464/1058/files/Untitled_480_x_480_px_9_480x480.jpg?v=1688264844',
                ),
                ComidaItem(
                  nombre: 'Paloma cocktail',
                  imageUrl:
                      'https://www.oliveandmango.com/images/uploads/2021_07_24_paloma_cocktail_2.jpg',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ComidaGrid extends StatelessWidget {
  final List<ComidaItem> items;
  const ComidaGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 120,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 60),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


class ComidaItem {
  final String nombre;
  final String imageUrl;
  const ComidaItem({required this.nombre, required this.imageUrl});
}
