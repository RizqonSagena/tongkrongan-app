import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const SearchBarWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTextChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48, // h-12
      decoration: BoxDecoration(
        color: _isFocused 
            ? AppTheme.surfaceContainer 
            : AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: [AppTheme.shadowSm],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: 'Cari kafe, kedai, makanan, suasana...',
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.outline,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: Icon(
              Icons.search,
              color: AppTheme.secondary,
              size: 22,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: widget.controller.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: GestureDetector(
                    onTap: () {
                      widget.controller.clear();
                      widget.onClear?.call();
                      setState(() {});
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}