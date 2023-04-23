library country_code_picker;

import 'package:flutter/material.dart';
import 'src/country_code.dart';
import 'src/country_codes.dart';
import 'src/selection_dialog.dart';

export 'src/country_code.dart';

class CountryCodePicker extends StatefulWidget {
  final ValueChanged<CountryCode>? onChanged;
  final ValueChanged<CountryCode?>? onInit;
  final String? initialSelection;
  final List<String> favorite;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final bool showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? dialogTextStyle;
  final WidgetBuilder? emptySearchBuilder;
  final Function(CountryCode?)? builder;
  final bool enabled;
  final TextOverflow textOverflow;
  final Icon closeIcon;

  /// Barrier color of ModalBottomSheet
  final Color? barrierColor;

  /// Background color of ModalBottomSheet
  final Color? backgroundColor;

  /// BoxDecoration for dialog
  final BoxDecoration? boxDecoration;

  /// the size of the selection dialog
  final Size? dialogSize;

  /// Background color of selection dialog
  final Color? dialogBackgroundColor;

  /// used to customize the country list
  final List<String>? countryFilter;

  /// shows the name of the country instead of the dialcode
  final bool showOnlyCountryWhenClosed;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  /// this is especially useful in combination with [showOnlyCountryWhenClosed],
  /// because longer country names are displayed in one line
  final bool alignLeft;

  /// shows the flag
  final bool showFlag;

  final bool hideMainText;

  final bool? showFlagMain;

  final bool? showFlagDialog;

  /// Width of the flag images
  final double flagWidth;

  /// Use this property to change the order of the options
  final Comparator<CountryCode>? comparator;

  /// Set to true if you want to hide the search part
  final bool hideSearch;

  /// Set to true if you want to show drop down button
  final bool showDropDownButton;

  /// [BoxDecoration] for the flag image
  final Decoration? flagDecoration;

  /// An optional argument for injecting a list of countries
  /// with customized codes.
  final List<Map<String, String>> countryList;

  const CountryCodePicker({
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(8.0),
    this.showCountryOnly = false,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.dialogTextStyle,
    this.emptySearchBuilder,
    this.showOnlyCountryWhenClosed = false,
    this.alignLeft = false,
    this.showFlag = true,
    this.showFlagDialog,
    this.hideMainText = false,
    this.showFlagMain,
    this.flagDecoration,
    this.builder,
    this.flagWidth = 32.0,
    this.enabled = true,
    this.textOverflow = TextOverflow.ellipsis,
    this.barrierColor,
    this.backgroundColor,
    this.boxDecoration,
    this.comparator,
    this.countryFilter,
    this.hideSearch = false,
    this.showDropDownButton = false,
    this.dialogSize,
    this.dialogBackgroundColor,
    this.closeIcon = const Icon(Icons.close),
    this.countryList = countryCodes,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    List<Map<String, String>> jsonList = countryList;

    List<CountryCode> usableCountryCodes =
        jsonList.map((json) => CountryCode.fromJson(json)).toList();

    if (comparator != null) {
      usableCountryCodes.sort(comparator);
    }

    if (countryFilter != null && countryFilter!.isNotEmpty) {
      final uppercaseCustomList =
          countryFilter!.map((criteria) => criteria.toUpperCase()).toList();
      usableCountryCodes = usableCountryCodes
          .where((criteria) =>
              uppercaseCustomList.contains(criteria.iso2CountryCode) ||
              uppercaseCustomList.contains(criteria.name) ||
              uppercaseCustomList.contains(criteria.dialCode))
          .toList();
    }

    return CountryCodePickerState(usableCountryCodes);
  }
}

class CountryCodePickerState extends State<CountryCodePicker> {
  CountryCode? selectedItem;
  List<CountryCode> usableCountryCodes = [];
  List<CountryCode> favoriteElements = [];

  CountryCodePickerState(this.usableCountryCodes);

  @override
  Widget build(BuildContext context) {
    Widget internalWidget;
    if (widget.builder != null) {
      internalWidget = InkWell(
        onTap: showCountryCodePickerDialog,
        child: widget.builder!(selectedItem),
      );
    } else {
      internalWidget = TextButton(
        onPressed: widget.enabled ? showCountryCodePickerDialog : null,
        child: Padding(
          padding: widget.padding,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.showFlagMain != null
                  ? widget.showFlagMain!
                  : widget.showFlag)
                Flexible(
                  flex: widget.alignLeft ? 0 : 1,
                  fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                  child: Container(
                    clipBehavior: widget.flagDecoration == null
                        ? Clip.none
                        : Clip.hardEdge,
                    decoration: widget.flagDecoration,
                    margin: widget.alignLeft
                        ? const EdgeInsets.only(right: 16.0, left: 8.0)
                        : const EdgeInsets.only(right: 16.0),
                    child: Image.asset(
                      'flags/${selectedItem!.iso2CountryCode}.png'
                          .toLowerCase(),
                      width: widget.flagWidth,
                    ),
                  ),
                ),
              if (!widget.hideMainText)
                Flexible(
                  fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                  child: Text(
                    widget.showOnlyCountryWhenClosed
                        ? selectedItem!.toCountryStringOnly()
                        : selectedItem!.dialCode,
                    style: widget.textStyle ??
                        Theme.of(context).textTheme.labelLarge,
                    overflow: widget.textOverflow,
                  ),
                ),
              if (widget.showDropDownButton)
                Flexible(
                  flex: widget.alignLeft ? 0 : 1,
                  fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                  child: Padding(
                      padding: widget.alignLeft
                          ? const EdgeInsets.only(right: 16.0, left: 8.0)
                          : const EdgeInsets.only(right: 16.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                        size: widget.flagWidth,
                      )),
                ),
            ],
          ),
        ),
      );
    }
    return internalWidget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    usableCountryCodes =
        usableCountryCodes.map((e) => e.localize(context)).toList();
    _onInit(selectedItem);
  }

  @override
  void didUpdateWidget(CountryCodePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection != null) {
        selectedItem = usableCountryCodes.firstWhere(
            (e) =>
                (e.iso2CountryCode.toUpperCase() ==
                    widget.initialSelection!.toUpperCase()) ||
                (e.dialCode == widget.initialSelection) ||
                (e.name.toUpperCase() ==
                    widget.initialSelection!.toUpperCase()),
            orElse: () => usableCountryCodes[0]);
      } else {
        selectedItem = usableCountryCodes[0];
      }
      _onInit(selectedItem);
    }
  }

  @override
  void initState() {
    usableCountryCodes =
        widget.countryList.map((json) => CountryCode.fromJson(json)).toList();
    if (usableCountryCodes.isEmpty) {
      throw ArgumentError('Input list cannot be empty');
    }
    if (widget.comparator != null) {
      usableCountryCodes.sort(widget.comparator);
    }

    if (widget.countryFilter?.isNotEmpty == true) {
      final uppercaseCustomList =
          widget.countryFilter!.map((c) => c.toUpperCase()).toList();
      usableCountryCodes = usableCountryCodes
          .where((c) =>
              uppercaseCustomList.contains(c.iso2CountryCode) ||
              uppercaseCustomList.contains(c.name) ||
              uppercaseCustomList.contains(c.dialCode))
          .toList();
    }
    if (usableCountryCodes.isEmpty) {
      throw ArgumentError(
          'Provided filter removed all country codes leaving the list empty');
    }

    super.initState();

    if (widget.initialSelection != null) {
      selectedItem = usableCountryCodes.firstWhere(
          (e) =>
              (e.iso2CountryCode.toUpperCase() ==
                  widget.initialSelection!.toUpperCase()) ||
              (e.dialCode == widget.initialSelection) ||
              (e.name.toUpperCase() == widget.initialSelection!.toUpperCase()),
          orElse: () => usableCountryCodes[0]);
    } else {
      selectedItem = usableCountryCodes[0];
    }
    if (widget.favorite.isNotEmpty) {
      favoriteElements = usableCountryCodes.where((usableCountryCode) {
        for (var f in widget.favorite) {
          if (usableCountryCode.iso2CountryCode.toUpperCase() ==
                  f.toUpperCase() ||
              usableCountryCode.dialCode == f ||
              usableCountryCode.name.toUpperCase() == f.toUpperCase()) {
            return true;
          }
        }
        return false;
      }).toList();
    }
  }

  void showCountryCodePickerDialog() async {
    final item = await showDialog(
      barrierColor: widget.barrierColor ?? Colors.grey.withOpacity(0.5),
      context: context,
      builder: (context) => Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 400),
          child: Dialog(
            child: SelectionDialog(
              usableCountryCodes,
              favoriteElements,
              showCountryOnly: widget.showCountryOnly,
              emptySearchBuilder: widget.emptySearchBuilder,
              searchDecoration: widget.searchDecoration,
              searchStyle: widget.searchStyle,
              textStyle: widget.dialogTextStyle,
              boxDecoration: widget.boxDecoration,
              showFlag: widget.showFlagDialog ?? widget.showFlag,
              flagWidth: widget.flagWidth,
              size: widget.dialogSize,
              backgroundColor: widget.dialogBackgroundColor,
              barrierColor: widget.barrierColor,
              hideSearch: widget.hideSearch,
              closeIcon: widget.closeIcon,
              flagDecoration: widget.flagDecoration,
            ),
          ),
        ),
      ),
    );

    if (item != null) {
      setState(() {
        selectedItem = item;
      });

      _publishSelection(item);
    }
  }

  void _publishSelection(CountryCode countryCode) {
    if (widget.onChanged != null) {
      widget.onChanged!(countryCode);
    }
  }

  void _onInit(CountryCode? countryCode) {
    if (widget.onInit != null) {
      widget.onInit!(countryCode);
    }
  }
}
