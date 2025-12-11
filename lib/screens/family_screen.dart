import 'package:flutter/material.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF5),
      // ⚠️ Profile 页不需要 SafeArea 的 top，因为我们要让背景图顶到头
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. 沉浸式头部 (Profile Header)
            _buildProfileHeader(),

            const SizedBox(height: 20),

            // 2. 孩子档案卡 (Kids Profile)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('我的宝贝', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildKidCard('Lucas', '3岁', '🦖 恐龙迷', Colors.blue[100]!),
                      const SizedBox(width: 12),
                      _buildKidCard('Mia', '1岁', '👶 爬行中', Colors.pink[100]!),
                      const SizedBox(width: 12),
                      // 添加按钮
                      Container(
                        width: 100, height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                        ),
                        child: const Center(child: Icon(Icons.add, color: Colors.grey)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3. 功能菜单列表 (Settings)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuItem(Icons.favorite_border, '我的收藏 (Favorites)', '12个地点'),
                  _buildMenuItem(Icons.calendar_today_outlined, '行程计划 (Planner)', '本周六去农场'),
                  _buildMenuItem(Icons.history, '浏览历史', ''),
                  _buildMenuItem(Icons.settings_outlined, '设置', ''),
                  _buildMenuItem(Icons.share_outlined, '邀请家人 (Invite Partner)', '共享账号'),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 头部组件
  Widget _buildProfileHeader() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // 背景大图
        Container(
          height: 240,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.orange,
            // 以后这里换成用户的家庭合照
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFF9F43), Color(0xFFFFCB80)],
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        // 用户信息卡
        Positioned(
          bottom: 30,
          left: 20,
          child: Row(
            children: [
              // 头像
              Container(
                width: 70, height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFFFFDF5),
                  child: Icon(Icons.person, size: 40, color: Colors.orange),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('爸爸的账号', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  Text('家庭 ID: #8821', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              )
            ],
          ),
        ),
        // 右上角编辑按钮
        Positioned(
          top: 50, right: 20,
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  // 孩子卡片
  Widget _buildKidCard(String name, String age, String tag, Color color) {
    return Container(
      width: 100, height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 16, backgroundColor: Colors.white54,
            child: Icon(Icons.child_care, size: 18, color: Colors.black54),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(age, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 4),
              Text(tag, style: const TextStyle(fontSize: 10, color: Colors.black45)),
            ],
          )
        ],
      ),
    );
  }

  // 菜单项
  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.orange[50], shape: BoxShape.circle),
          child: Icon(icon, color: Colors.orange),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: subtitle.isNotEmpty ? Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}