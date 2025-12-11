import 'package:flutter/material.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 模拟 Daycare 数据 (模拟政府 Open Data)
  final List<Map<String, dynamic>> _mockDaycares = [
    {
      'name': 'Little Angels Childcare',
      'address': '123 Kids Ave, Markham',
      'rating': 4.8,
      'isSubsidy': true, // 有政府补贴
      'safetyStatus': 'clean', // 过去3年无违规
      'waitlist': 'short', // 排队短
      'ages': ['Infant', 'Toddler'],
    },
    {
      'name': 'Sunny Days Montessori',
      'address': '456 Learning Rd, Richmond Hill',
      'rating': 4.2,
      'isSubsidy': false,
      'safetyStatus': 'warning', // ⚠️ 有违规记录
      'waitlist': 'long', // 排队久
      'ages': ['Preschool', 'Kindergarten'],
    },
    {
      'name': 'Bright Future Academy',
      'address': '789 Future Blvd, Vaughan',
      'rating': 4.9,
      'isSubsidy': true,
      'safetyStatus': 'clean',
      'waitlist': 'full', // 已满
      'ages': ['Toddler', 'Preschool'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF5),
      body: SafeArea(
        child: Column(
          children: [
            // 1. 顶部：搜索 + 铃铛 (保持统一风格)
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
                        decoration: InputDecoration(
                          hintText: '搜 "Montessori" 或 "邮编"',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                          prefixIcon: const Icon(Icons.search, color: Colors.orange),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 11),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 铃铛 (复制之前的逻辑，保持统一)
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
                      Positioned(
                        right: 12, top: 12,
                        child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                      )
                    ],
                  ),
                ],
              ),
            ),

            // 2. 筛选：按年龄 (Daycare 最看重这个)
            TabBar(
              controller: _tabController,
              labelColor: Colors.orange[800],
              unselectedLabelColor: Colors.grey[500],
              indicatorColor: Colors.orange,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: '👶 Infant (0-1.5)'),
                Tab(text: '🧸 Toddler (1.5-2.5)'),
                Tab(text: '🎨 Preschool (2.5+)'),
              ],
            ),

            const SizedBox(height: 10),

            // 3. 严肃列表区域
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _mockDaycares.length,
                itemBuilder: (context, index) {
                  return _buildDaycareCard(_mockDaycares[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 专业版 Daycare 卡片
  Widget _buildDaycareCard(Map<String, dynamic> data) {
    bool isClean = data['safetyStatus'] == 'clean';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100), // 细边框，显得专业
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 第一行：名字 + 评分
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.amber[50], borderRadius: BorderRadius.circular(4)),
                child: Row(children: [
                  const Icon(Icons.star, size: 14, color: Colors.amber),
                  Text(' ${data['rating']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.amber[900])),
                ]),
              )
            ],
          ),

          const SizedBox(height: 4),
          Text(data['address'], style: TextStyle(color: Colors.grey[500], fontSize: 12)),

          const SizedBox(height: 12),

          // 第二行：硬指标 (补贴 + 安全 + 排队)
          Row(
            children: [
              // 1. 安全盾牌 (最核心)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isClean ? Colors.green[50] : Colors.red[50],
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: isClean ? Colors.green.shade100 : Colors.red.shade100),
                ),
                child: Row(
                  children: [
                    Icon(
                        isClean ? Icons.verified_user : Icons.warning_amber_rounded,
                        size: 14,
                        color: isClean ? Colors.green : Colors.red
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isClean ? 'Safety Clean' : 'Safety Alert',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isClean ? Colors.green[800] : Colors.red[800]
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // 2. 排队状态
              _buildWaitlistTag(data['waitlist']),
            ],
          ),

          const SizedBox(height: 12),

          // 第三行：标签 (Subsidy, Ages)
          Row(
            children: [
              if (data['isSubsidy'])
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(4)),
                  child: Text('补贴可用', style: TextStyle(color: Colors.blue[800], fontSize: 10)),
                ),
              ... (data['ages'] as List).map((age) => Container(
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
                child: Text(age, style: TextStyle(color: Colors.grey[700], fontSize: 10)),
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWaitlistTag(String status) {
    Color color;
    String text;
    switch (status) {
      case 'short': color = Colors.green; text = '有空位'; break;
      case 'long': color = Colors.orange; text = '排队 > 6月'; break;
      default: color = Colors.grey; text = '已满员'; break;
    }
    return Row(
      children: [
        Icon(Icons.access_time, size: 14, color: color),
        const SizedBox(width: 2),
        Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }
}