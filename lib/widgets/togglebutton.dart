import 'package:flutter/material.dart';

class ViewToggleButton extends StatefulWidget {
  final Function(bool isGridView) onToggle;
  final bool initialIsGrid;

  ViewToggleButton({
    Key? key,
    required this.onToggle,
    this.initialIsGrid = true,
  }) : super(key: key);

  @override
  State<ViewToggleButton> createState() => _ViewToggleButtonState();
}

class _ViewToggleButtonState extends State<ViewToggleButton> {
  late bool _isGridView;

  @override
  void initState() {
    super.initState();
    _isGridView = widget.initialIsGrid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleItem(
            icon: Icons.grid_view_rounded,
            isSelected: _isGridView,
            onTap: () {
              if (!_isGridView) {
                setState(() => _isGridView = true);
                widget.onToggle(true);
              }
            },
          ),
          SizedBox(width: 4),
          _buildToggleItem(
            icon: Icons.view_in_ar_rounded, // 3D box icon
            isSelected: !_isGridView,
            onTap: () {
              if (_isGridView) {
                setState(() => _isGridView = false);
                widget.onToggle(false);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 34,
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF2EBD9B) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isSelected ? Colors.white : Colors.grey.shade500,
        ),
      ),
    );
  }
}
