import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // 引入 Supabase

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ✨ 1. 变回真实数据列表
  List<Map<String, dynamic>> _places = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _fetchRealPlaces(); // ✨ 2. 初始化时抓取数据
  }

  // ✨ 3. 抓取 Supabase 数据的函数
  Future<void> _fetchRealPlaces() async {
    try {
      // 查询我们之前建好的视图 'places_with_coords'
      final response = await Supabase.instance.client
          .from('places_with_coords')
          .select()
          .order('id', ascending: false); // 最新插入的在前面

      if (mounted) {
        setState(() {
          _places = List<Map<String, dynamic>>.from(response);
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching places: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF5),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部区域：搜索框 + 铃铛 (保持 UI 不变)
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
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))
                        ],
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: '搜 "游泳" 或 "滑滑梯"',
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
                      Positioned(right: 12, top: 12, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)))
                    ],
                  ),
                ],
              ),
            ),

            // TabBar (保持 UI 不变)
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.orange[800],
              unselectedLabelColor: Colors.grey[500],
              indicatorColor: Colors.orange,
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              tabs: const [
                Tab(text: '全部'),
                Tab(text: '🏰 室内'),
                Tab(text: '🌳 户外'),
                Tab(text: '📅 活动'),
              ],
            ),

            const SizedBox(height: 10),

            // ✨ 4. 列表区域：根据 Loading 状态显示
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.orange))
                  : _places.isEmpty
                  ? Center(child: Text("暂无数据，请运行 Python 脚本填充", style: TextStyle(color: Colors.grey[400])))
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  return _buildPlaceCard(_places[index]);
                },
              ),
            ),
          ],
        ),
      ),
      // ... FloatingActionButton 保持不变
    );
  }

  // 单个卡片 (保持 UI 不变，只做数据字段适配)
  Widget _buildPlaceCard(Map<String, dynamic> place) {
    // 适配数据字段 (数据库里的 image_urls 是个列表)
    String imageUrl = "";
    if (place['image_urls'] != null && (place['image_urls'] as List).isNotEmpty) {
      imageUrl = place['image_urls'][0];
    }

    // 适配标签 (数据库里的 tags 是列表)
    List<String> tags = [];
    if (place['tags'] != null) {
      tags = List<String>.from(place['tags']);
    }

    // 适配营业状态 (数据库没存 is_open，暂时随机或默认 true)
    bool isOpen = true;

    // 适配距离 (这里暂时没算实时距离，先显示城市)
    String distanceInfo = place['city'] ?? '未知距离';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.orange.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图片
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 100, height: 100, fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => Container(width: 100, height: 100, color: Colors.grey[200], child: const Icon(Icons.image, color: Colors.grey)),
            ),
          ),
          const SizedBox(width: 12),
          // 信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2, overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  children: tags.take(3).map((tag) { // 只显示前3个标签
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(4)),
                      child: Text(tag, style: TextStyle(fontSize: 10, color: Colors.orange[900])),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    Text(' ${place['google_rating'] ?? 4.5}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(width: 8),
                    Expanded(child: Text('• $distanceInfo', style: TextStyle(color: Colors.grey[500], fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isOpen ? Colors.green[50] : Colors.red[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isOpen ? '营业中' : '已关门',
                        style: TextStyle(color: isOpen ? Colors.green : Colors.red, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}