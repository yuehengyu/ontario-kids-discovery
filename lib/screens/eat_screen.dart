import 'package:flutter/material.dart';

class EatScreen extends StatefulWidget {
  const EatScreen({super.key});

  @override
  State<EatScreen> createState() => _EatScreenState();
}

class _EatScreenState extends State<EatScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 模拟亲子餐厅数据
  final List<Map<String, dynamic>> _mockRestaurants = [
    {
      'name': 'Boston Pizza (Markham)',
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'tags': ['儿童餐', '画笔玩具', 'High Chair'],
      'rating': 4.5,
      'price': '\$\$',
      'distance': '2.3km',
      'features': ['play_area', 'kids_menu'], // 特殊图标标记
    },
    {
      'name': 'IKEA Restaurant',
      'image': 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'tags': ['免费游乐区', '便宜', '母婴室'],
      'rating': 4.3,
      'price': '\$',
      'distance': '8.5km',
      'features': ['play_area', 'stroller'],
    },
    {
      'name': 'O&B Canteen',
      'image': 'https://images.unsplash.com/photo-1559339352-11d035aa65de?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      'tags': ['宽敞', '婴儿车友好'],
      'rating': 4.7,
      'price': '\$\$\$',
      'distance': '15km',
      'features': ['stroller'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF5),
      body: SafeArea(
        child: Column(
          children: [
            // 1. 顶部搜索 (标准配置)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: '搜 "Pizza" 或 "有游乐区"',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                          prefixIcon: const Icon(Icons.search, color: Colors.orange),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 铃铛
                  Stack(
                    children: [
                      Container(
                        width: 46, height: 46,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))]
                        ),
                        child: const Icon(Icons.notifications_none, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. 筛选 Tab
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.orange[800],
              unselectedLabelColor: Colors.grey[500],
              indicatorColor: Colors.orange,
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: '全部'),
                Tab(text: '🎠 有游乐区'),
                Tab(text: '🍼 婴儿友好'),
                Tab(text: '🍟 儿童餐'),
              ],
            ),

            const SizedBox(height: 10),

            // 3. 餐厅列表
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _mockRestaurants.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantCard(_mockRestaurants[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.orange.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          // 上半部分：大图 + 特性角标
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  data['image'],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(height: 150, color: Colors.grey[200]),
                ),
              ),
              // 如果有游乐区，显示一个明显的 Badge
              if ((data['features'] as List).contains('play_area'))
                Positioned(
                  top: 12, right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.toys, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text('有游乐区', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
            ],
          ),

          // 下半部分：信息
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(data['price'], style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                // 标签胶囊
                Wrap(
                  spacing: 6,
                  children: (data['tags'] as List).map<Widget>((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(4)),
                      child: Text(tag, style: TextStyle(color: Colors.orange[900], fontSize: 10)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    Text(' ${data['rating']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.amber[900])),
                    const Spacer(),
                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                    Text(' ${data['distance']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}