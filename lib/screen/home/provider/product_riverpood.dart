import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product_model.dart';

// Dummy data
final productsProvider = Provider<List<Product>>((ref) {
  return [
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/LmPcxt8/Whats-App-Image-2025-11-27-at-9-37-53-PM-2-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '2',
      name: 'Women Sandals',
      imageUrl:
          'https://i.ibb.co/Y778SHqD/Whats-App-Image-2025-11-28-at-8-53-55-AM-removebg-preview.png',
      price: 699,
      category: 'Women',
    ),
    Product(
      id: '3',
      name: 'Kids Shoes',
      imageUrl:
          'https://i.ibb.co/LmPcxt8/Whats-App-Image-2025-11-27-at-9-37-53-PM-2-removebg-preview.png',
      price: 499,
      category: 'Kids',
    ),
    Product(
      id: '4',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/tpQcyJWK/Whats-App-Image-2025-11-28-at-8-53-52-AM-removebg-preview-1.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '5',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/G3xXjJZw/Whats-App-Image-2025-11-28-at-8-53-54-AM-1-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '6',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/yFKqF2X5/Whats-App-Image-2025-11-28-at-8-53-58-AM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '7',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/7PW9gDg/Whats-App-Image-2025-11-28-at-8-54-02-AM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '8',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/CKPmtwX9/Whats-App-Image-2025-11-28-at-8-53-57-AM-1-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '9',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/JwkhK5jn/Whats-App-Image-2025-11-28-at-8-53-55-AM-1-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '10',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Cs7L3fFW/Whats-App-Image-2025-11-27-at-9-38-10-PM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '11',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/V0BSzZkR/Whats-App-Image-2025-11-27-at-9-38-09-PM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '12',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/tpQcyJWK/Whats-App-Image-2025-11-28-at-8-53-52-AM-removebg-preview-1.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/DdYdcjs/Whats-App-Image-2025-11-28-at-8-54-00-AM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Mxv5sRg0/Whats-App-Image-2025-11-28-at-8-53-51-AM-1-removebg-preview-1.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/HpYbvKqy/Whats-App-Image-2025-11-27-at-9-38-12-PM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/39TFnhnN/Whats-App-Image-2025-11-27-at-9-38-11-PM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/jPTz8L7p/Whats-App-Image-2025-11-27-at-9-38-09-PM-removebg-preview-1.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/j92ph3Zd/Whats-App-Image-2025-11-27-at-9-38-14-PM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/TBXzcj56/Whats-App-Image-2025-11-27-at-9-38-17-PM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/FbNGrd6r/Whats-App-Image-2025-11-27-at-9-38-14-PM-1-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/gL7q3TS1/Whats-App-Image-2025-11-27-at-9-38-16-PM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/TBX2wc5H/Whats-App-Image-2025-11-27-at-9-38-12-PM-1-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/VWdDDLDS/Whats-App-Image-2025-11-27-at-9-38-14-PM-1-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Lm0ffmT/Whats-App-Image-2025-11-28-at-8-53-55-AM-1-removebg-preview-1.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/jk6N1KZz/Whats-App-Image-2025-11-27-at-9-38-08-PM-1-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/VWJQ10yM/Whats-App-Image-2025-11-28-at-9-02-47-AM-removebg-preview-1.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/8LwCmynn/Whats-App-Image-2025-11-28-at-8-53-50-AM-removebg-preview-1.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/gLZL0bxr/Whats-App-Image-2025-11-27-at-9-38-18-PM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/67DRmMHT/Whats-App-Image-2025-11-27-at-9-37-54-PM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/YF1mT97L/Whats-App-Image-2025-11-28-at-8-53-56-AM-removebg-preview.png',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl: 'https://i.ibb.co/dsMxqhqr/SM802001-3.jpg',
      price: 999,
      category: 'Men',
    ),
    Product(
      id: '123',
      name: 'Men Sneakers',
      imageUrl: 'https://i.ibb.co/200Xsts0/IMG-6867.jpg',
      price: 999,
      category: 'Men',
    ),
  ];
});
