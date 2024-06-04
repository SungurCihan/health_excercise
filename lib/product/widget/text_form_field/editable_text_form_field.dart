import 'package:flutter/material.dart';
import 'package:health_excercise/product/init/theme/greys.dart';
import 'package:health_excercise/product/widget/padding/project_padding.dart';

/// Read only but editable text form field
class EditableTextFormField extends StatelessWidget {
  /// EditableTextFormField initialization
  const EditableTextFormField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
  });

  /// Prefix icon (left side of the text form field)
  final Widget? prefixIcon;

  /// Suffix icon (right side of the text form field)
  final Widget? suffixIcon;

  /// Label of the text form field
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.065,
      decoration: BoxDecoration(
        color: Greys.neutral10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const ProjectPadding.symetricHorizontalSmall(),
        child: TextFormField(
          canRequestFocus: false,
          readOnly: true,
          decoration: InputDecoration(
            icon: prefixIcon ?? const Icon(Icons.person),
            label: Text(label ?? 'Name'),
            suffixIcon: suffixIcon ?? const Icon(Icons.edit),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
