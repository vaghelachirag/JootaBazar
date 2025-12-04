import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/product_model.dart';
import '../../../uttils/constant.dart';

// Dummy data
final productsProvider = Provider<List<Product>>((ref) {
  return [
    Product(
      id: '1',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/84TKpmP2/IMG-20251203-093843937-HDR-removebg-preview-1.png',
      price: 999,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/LdCPfnmB/IMG-20251203-094315337-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/23QSCrbS/IMG-20251203-094547177-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/pvfhP2Hb/IMG-20251203-094815166-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/sJDZ7NnS/IMG-20251203-094901290-HDR-removebg-preview-1.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/xtY5BfmN/IMG-20251203-095415885-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/p6kPKn0z/IMG-20251203-095526897-HDR-removebg-preview-2.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/FLdqKZQh/IMG-20251203-100453130-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/KcFNTg7y/IMG-20251203-100447601-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/ZpVmX9vz/IMG-20251203-100433822-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Hf8drXVW/IMG-20251203-100243600-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/wF9dh1fg/IMG-20251203-100236760-HDR-removebg-preview-1.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Vph5V1qB/IMG-20251203-100509906-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/W4nYbVm8/IMG-20251203-100521774-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/xS5GKWWd/IMG-20251203-101823873-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/wZHrH7wW/IMG-20251203-101022574-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/bgNynndC/IMG-20251203-100747357-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/fGFnz947/IMG-20251203-101848303-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/RTKrhDb9/IMG-20251203-101957992-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/B5Jds688/IMG-20251203-102438852-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/RpJQcgQK/IMG-20251203-102549671-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/d4NyjWvZ/IMG-20251203-105215383-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/QvxQQDsN/IMG-20251203-105228892-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/ztXBzvj/IMG-20251203-111040010-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/TxcDN37k/IMG-20251203-101512806-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categorySport,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/nqdyd7VN/IMG-20251203-101221127-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categorySport,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Lhb10C84/IMG-20251203-101144913-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categorySport,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/hJzH97rg/IMG-20251203-111840216-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryChappal,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/0jCtr3wv/IMG-20251203-112526158-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/hRbWJ6F5/IMG-20251203-112902469-PORTRAIT-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/VcDfhrVS/IMG-20251203-113036025-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/kVc8JXWV/IMG-20251203-113411891-PORTRAIT-removebg-preview.png',
      price: 699,
      category: Contants().categoryChappal,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/1Jb0mBhV/IMG-20251203-113534978-PORTRAIT-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Hp9T8zcn/IMG-20251203-115304497-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Q7VsjD1f/IMG-20251203-124735096-PORTRAIT-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Q7VsjD1f/IMG-20251203-124735096-PORTRAIT-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/Q7VsjD1f/IMG-20251203-124735096-PORTRAIT-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/8Lx6zmfr/IMG-20251203-163912793-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryWomen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/XrwC0QkC/IMG-20251203-163741319-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryChappal,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/nMvkXLNn/IMG-20251203-125556555-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),
    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/1JhMPFCq/IMG-20251203-125029062-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/dsqtKqMJ/IMG-20251203-172431946-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryChappal,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/YFZcqn04/IMG-20251203-165751331-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryMen,
    ),

    Product(
      id: '2',
      name: 'Men Sneakers',
      imageUrl:
          'https://i.ibb.co/8nnhHYgK/IMG-20251203-164004201-HDR-removebg-preview.png',
      price: 699,
      category: Contants().categoryWomen,
    ),
  ];
});
