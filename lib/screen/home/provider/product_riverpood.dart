import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product_model.dart';
import '../../../uttils/constant.dart';

// Dummy data
final productsProvider = Provider<List<Product>>((ref) {
  return [
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl: 'https://i.ibb.co/zHrpjWMF/Gemini-Generated-Image-pie423pie423pie4.png',
      price: 1299,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/TxD2dn44/IMG-20251203-094315337-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Q3fBwjFx/IMG-20251203-094547177-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/7tCTtHnD/IMG-20251203-094815166-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/KckC2C60/IMG-20251203-094901290-HDR-removebg-preview-1-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/tPXz6rZx/IMG-20251203-095415885-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/9H5G3BpX/IMG-20251203-100433822-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/hFDSkWRG/IMG-20251203-100447601-HDR-removebg-preview-removebg-preview-1.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/hxvYPy9K/IMG-20251203-100521774-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/G6jtzLJ/IMG-20251203-100747357-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/BVtgMXvx/IMG-20251203-101823873-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/tPXz6rZx/IMG-20251203-095415885-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/7tCTtHnD/IMG-20251203-094815166-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/GQFdGcqv/IMG-20251203-101221127-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categorySport,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/F4QT4xQv/IMG-20251203-100521774-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Ng6NtHbF/IMG-20251203-101512806-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categorySport,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/xK4tThCq/IMG-20251203-101848303-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryChappal,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/JWknpYxw/IMG-20251203-102438852-HDR-removebg-preview-removebg-preview-1.png',
      price: 999,
      category: Contants().categoryChappal,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/v498Q0XF/IMG-20251203-105215383-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/N691vz6h/IMG-20251203-112526158-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/7tcxkBhY/IMG-20251203-112902469-PORTRAIT-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/s96XDDq2/IMG-20251203-113036025-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/MyCw2DnY/IMG-20251203-113534978-PORTRAIT-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/4nzWtqLk/IMG-20251203-115304497-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Dg6ZW63c/IMG-20251203-124735096-PORTRAIT-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/bMT26kYQ/IMG-20251203-125029062-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/CKvXxTpn/IMG-20251203-163741319-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryChappal,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/kVg2nKx9/IMG-20251203-163912793-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryWomen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/kbNm2L1/IMG-20251203-164004201-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryWomen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/qLyYJKvk/IMG-20251203-165751331-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/cXCRs5gD/IMG-20251203-172431946-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryChappal,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/sJdPffk5/Whats-App-Image-2025-11-28-at-8-53-56-AM-1-removebg-preview-1-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/FkjkN1Yj/Whats-App-Image-2025-12-04-at-8-10-21-AM-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryWomen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Nd4G3V1v/Whats-App-Image-2025-12-04-at-8-10-29-AM-1-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryWomen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/2YRxbf0S/Whats-App-Image-2025-12-04-at-8-10-30-AM-1-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryWomen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/1GWx6wYq/Whats-App-Image-2025-12-04-at-8-10-30-AM-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryWomen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/hxpQjnVk/Whats-App-Image-2025-12-04-at-8-10-33-AM-1-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/QvnWjyYD/Whats-App-Image-2025-12-04-at-8-10-33-AM-2-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryChappal,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/k2Z4dCgM/Whats-App-Image-2025-12-04-at-8-10-37-AM-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryChappal,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/RkY2M29P/Whats-App-Image-2025-12-04-at-8-10-38-AM-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryChappal,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/RTty9Tgz/IMG-20251203-101022574-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/KxJ060rL/Whats-App-Image-2025-12-04-at-8-10-31-AM-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryChappal,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/xtyb9fbM/IMG-20251203-101144913-HDR-removebg-preview-removebg-preview-2.png',
      price: 999,
      category: Contants().categorySport,
    ),

    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/ymwjDy1g/IMG-20251203-100454137-HDR-removebg-preview-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/SwVPWDZL/IMG-20251203-093935852-HDR-edited.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/cpZhLvf/IMG-20251203-133058246-HDR-removebg-preview.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/vvKbCH7J/IMG-20251203-102247554-HDR-removebg-preview-1.png',
      price: 999,
      category: Contants().categoryKids,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/n8LhkL4c/IMG-20251203-102234740-HDR-removebg-preview.png',
      price: 999,
      category: Contants().categoryKids,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/svcZY3B6/IMG-20251203-163741319-HDR-removebg-preview-1.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/vvKbCH7J/IMG-20251203-102247554-HDR-removebg-preview-1.png',
      price: 999,
      category: Contants().categoryKids,
    ),
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/d4BYBjZd/Whats-App-Image-2025-12-04-at-8-10-39-AM-removebg-preview-1.png',
      price: 999,
      category: Contants().categoryWomen,
    ),
  ];
});
