import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 顶部问候与定位 (Header)
              // 1. 顶部问候与定位 (Header)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 左侧：问候 + 天气
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hi, 爸爸 👋',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.wb_sunny_rounded, size: 16, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                              '今天天气不错 22°C',
                              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // 右侧：定位 + 铃铛
                    Row(
                      children: [
                        // 定位胶囊
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.orange.withOpacity(0.3)),
                              boxShadow: [
                                BoxShadow(color: Colors.orange.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))
                              ]
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.location_on, color: Colors.orange, size: 14), // 图标稍微调小一点
                              SizedBox(width: 4),
                              Text('Markham', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        // ✨ 新增：首页的铃铛
                        Stack(
                          children: [
                            Container(
                              width: 40, // 稍微小一点，精致
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade100),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))
                                  ]
                              ),
                              child: Icon(Icons.notifications_none, color: Colors.black87, size: 22),
                            ),
                            // 红点
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 2. 魔法搜索框 (Search)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 12),
                      Text(
                        '搜 "室内游乐场" 或 "摘草莓"...',
                        style: TextStyle(color: Colors.grey[400], fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 3. 金刚区 (核心入口 Grid)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12), // 稍微宽一点
                child: LayoutBuilder(
                    builder: (context, constraints) {
                      // 动态计算宽度，保证在不同手机上都好看
                      return Wrap(
                        alignment: WrapAlignment.spaceAround,
                        spacing: 12,
                        runSpacing: 20,
                        children: [
                          _buildCategoryItem('室内放电', '🏰', Colors.purple[50]!),
                          _buildCategoryItem('户外探险', '🌳', Colors.green[50]!),
                          _buildCategoryItem('周末活动', '📅', Colors.blue[50]!),
                          _buildCategoryItem('特价票', '🎟️', Colors.orange[50]!),
                          _buildCategoryItem('找Daycare', '🏫', Colors.red[50]!),
                          _buildCategoryItem('亲子餐', '🍔', Colors.amber[50]!),
                          _buildCategoryItem('避雷指南', '📝', Colors.teal[50]!),
                          _buildCategoryItem('我的收藏', '⭐️', Colors.indigo[50]!),
                        ],
                      );
                    }
                ),
              ),

              const SizedBox(height: 32),

              // 4. 本周热门 (Trending Section)
              _buildSectionHeader('🔥 本周热门', '大家都去哪玩'),
              const SizedBox(height: 16),
              SizedBox(
                height: 260, // 卡片高度
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20, right: 8),
                  children: [
                    _buildTrendingCard(
                        'Downey\'s Farm',
                        '南瓜节开始啦！',
                        'https://downeysfarm.com/images/home-slide-1.jpg',
                        '农场 · 45km',
                        4.8
                    ),
                    _buildTrendingCard(
                        'Fantasy Fair',
                        '安省最大室内乐园',
                        'https://images.unsplash.com/photo-1596464716127-f9a081942444?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                        '室内 · 12km',
                        4.5
                    ),
                    _buildTrendingCard(
                        'Ripley 水族馆',
                        '和鲨鱼过夜',
                        'https://images.unsplash.com/photo-1544551763-46a873d57e2a?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                        '科普 · 25km',
                        4.9
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 5. 新店首发 (New Opening)
              _buildSectionHeader('🆕 新店首发', '刚开业去尝鲜'),
              const SizedBox(height: 16),
              // ... 这里可以复用上面的 Card 逻辑，或者做成小的竖向列表
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: const Center(child: Text('暂无新店数据，AI 正在搜索中...', style: TextStyle(color: Colors.grey))),
              ),

              const SizedBox(height: 40), // 底部留白
            ],
          ),
        ),
      ),
    );
  }

  // 组件：金刚区图标
  Widget _buildCategoryItem(String title, String emoji, Color bgColor) {
    return SizedBox(
      width: 75, // 固定宽度
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bgColor, // 也是淡色背景
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 26)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 组件：Section 标题
  Widget _buildSectionHeader(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
        ],
      ),
    );
  }

  // 组件：横向大卡片
  Widget _buildTrendingCard(String title, String subtitle, String imageUrl, String tag, double rating) {
    return Container(
      width: 280, // 👇 修改：稍微宽一点 (原来是 260)
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.orange.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图片部分
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              height: 150, // 👇 修改：图片稍微给高一点点也行，或者保持 140
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(height: 150, color: Colors.grey[200]),
            ),
          ),
          // 文字部分 - 这里会自动填充剩余空间
          Expanded( // 👇 新增：用 Expanded 占满剩下的高度，防止溢出
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 标题加 Flexible 防止标题太长溢出
                      Flexible(
                        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      Row(children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        Text(' $rating', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.amber[900])), // 记得去掉这里的 const
                      ]),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(4)),
                    child: Text(tag, style: TextStyle(color: Colors.orange[800], fontSize: 10, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}