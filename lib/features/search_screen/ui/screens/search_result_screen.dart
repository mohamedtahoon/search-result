import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_task/core/base/base_theme_cubit/theme_cubit.dart';
import 'package:search_task/core/base/base_widgets/base_stateful_widget.dart';
import 'package:search_task/core/base/lang/app_localization_keys.dart';
import 'package:search_task/core/base/widgets/change_language_widget/change_language_widget.dart';
import 'package:search_task/core/design/colors_catalog.dart';
import 'package:search_task/core/utils/toast.dart';
import 'package:search_task/features/search_screen/bloc/search_result_screen_bloc.dart';
import 'package:search_task/features/search_screen/models/screen_result_request/screen_result_request.dart';
import 'package:search_task/features/search_screen/models/screen_result_response/screen_result_response.dart';
import 'package:search_task/features/search_screen/ui/widgets/screen_result_grid_item_widget.dart';
import 'package:search_task/features/search_screen/ui/widgets/screen_result_item_widget.dart';

class SearchResultScreen extends BaseStatefulWidget {
  static const routeName = '/search-screen';
  const SearchResultScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _SearchScreenState();
}

class _SearchScreenState extends BaseState<SearchResultScreen> {
  final ScrollController _scrollController = ScrollController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _nationalityController = TextEditingController();
  bool _showSearchBar = true;
  bool _showButtonWidget = false;
  bool _isListIcon = true;
  List<ScreenResult>? _screenResult = [];

  SearchResultScreenBloc get _currentBloc =>
      BlocProvider.of<SearchResultScreenBloc>(context);
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<SearchResultScreenBloc, SearchResultScreenState>(
        listener: (context, state) {
      if (state is SearchResultScreenLoadingState) {
        showLoading();
      } else {
        hideLoading();
      }
      if (state is SearchResultScreenErrorState) {
        showToast(state.message);
      }
      if (state is SearchResultChangeListViewOrGridViewState) {
        _isListIcon = !_isListIcon;
      }
      if (state is SearchResultScreenGetDataSuccessState) {
        _screenResult = state.screenResultResponse?.screenResult;
      }
      if (state is SearchResultShowButtonWidgetState) {
        _showButtonWidget = true;
      }
      if (state is SearchResultShowSearchBarState) {
        _showSearchBar = false;
        _showButtonWidget = false;
      }
      if (state is SearchResultHideSearchBarState) {
        _showSearchBar = true;
      }
      if (state is SearchResultChangeThemeState) {
        context.read<ThemeCubit>().toggleTheme(state.themeState);
      }
      if (state is SearchResultScreenNetworkErrorState) {
        showToast(state.message);
      }
    }, builder: (context, state) {
      return buildSearchResultScreen(context);
    });
  }

  buildSearchResultScreen(BuildContext context) {
    return Scaffold(
      appBar: _showSearchBar ? _buildAppBarWidget(context) : null,
      body: Column(
        children: [
          Visibility(
            visible: _showButtonWidget,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: translate(LangKeys.firstName),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0.h),
                  TextFormField(
                    controller: _middleNameController,
                    decoration: InputDecoration(
                      labelText: translate(LangKeys.middleName),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0.h),
                  TextFormField(
                    controller: _nationalityController,
                    decoration: InputDecoration(
                      labelText: translate(LangKeys.nationality),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0.h),
                  ElevatedButton(
                    onPressed: () {
                      _currentBloc.add(SearchResultButtonEvent(
                          ScreenResultRequest(
                              firstName: _firstNameController.text,
                              middleName: _middleNameController.text,
                              nationality: _nationalityController.text)));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      minimumSize: Size(double.infinity, 50.w),
                    ),
                    child: Text(translate(LangKeys.search)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: _isListIcon
                  ? ListView.builder(
                      controller: _scrollController,
                      itemCount: _screenResult?.length,
                      itemBuilder: (context, index) {
                        return ScreenResultItem(
                            screenResult: _screenResult?[index]);
                      },
                    )
                  : GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.h,
                        mainAxisSpacing: 10.w,
                      ),
                      itemCount: _screenResult?.length,
                      itemBuilder: (context, index) {
                        return ScreenResultGridItem(
                            screenResult: _screenResult?[index]);
                      },
                    )),
        ],
      ),
    );
  }

  _buildAppBarWidget(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: ColorsCatalog().APP_DARK_GREEN,
          ),
          onPressed: () {
            _bottomSheetWidget(context);
          },
        ),
      ],
      leading: IconButton(
        icon: Icon(
          _isListIcon ? Icons.list : Icons.grid_view,
          color: ColorsCatalog().APP_DARK_GREEN,
        ),
        onPressed: () {
          _currentBloc.add(SearchResultChangeListViewOrGridViewEvent());
        },
      ),
      title: InkWell(
        onTap: () {
          _currentBloc.add(SearchResultShowButtonWidgetEvent());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorsCatalog().APP_GREY),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.search, color: ColorsCatalog().APP_DARK_GREEN),
              const SizedBox(width: 10),
              Text(
                translate(LangKeys.clickHereToSearch),
                style: TextStyle(color: ColorsCatalog().APP_GREY),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: ColorsCatalog().APP_LIGHT_GREY,
      elevation: 1,
    );
  }

  _bottomSheetWidget(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.h,
          color: ColorsCatalog().APP_WHITE_50,
          child: Column(
            children: [
              ChangeLanguageWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAppThemeContainer(
                      colorAfterSelected: ColorsCatalog.isLightMode,
                      isGradientColorBox: true,
                      onSelectedColor: () {
                        _currentBloc.add(SearchResultChangeThemeEvent(
                            ThemesStates.mainLayout));
                        Navigator.pop(context);
                      }),
                  _buildAppThemeContainer(
                      insideBoxColor: ColorsCatalog().APP_BLUE,
                      colorAfterSelected: ColorsCatalog.isBlueLayout,
                      isGradientColorBox: false,
                      onSelectedColor: () {
                        _currentBloc.add(SearchResultChangeThemeEvent(
                            ThemesStates.blueLayout));
                        Navigator.pop(context);
                      }),
                  _buildAppThemeContainer(
                      insideBoxColor: ColorsCatalog().APP_GREEN,
                      colorAfterSelected: ColorsCatalog.isGreenLayout,
                      isGradientColorBox: false,
                      onSelectedColor: () {
                        _currentBloc.add(SearchResultChangeThemeEvent(
                            ThemesStates.greenLayout));
                        Navigator.pop(context);
                      }),
                  _buildAppThemeContainer(
                      insideBoxColor: ColorsCatalog().APP_BLACK,
                      colorAfterSelected: ColorsCatalog.isDarkLayout,
                      isGradientColorBox: false,
                      onSelectedColor: () {
                        _currentBloc.add(SearchResultChangeThemeEvent(
                            ThemesStates.darkModeLayout));
                        Navigator.pop(context);
                      }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_showSearchBar) {
        _currentBloc.add(SearchResultShowSearchBarEvent());
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_showSearchBar) {
        _currentBloc.add(SearchResultHideSearchBarEvent());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _buildAppThemeContainer(
      {required bool colorAfterSelected,
      required bool isGradientColorBox,
      Color? insideBoxColor,
      required VoidCallback onSelectedColor}) {
    return GestureDetector(
      onTap: onSelectedColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 72.w,
            height: 94.h,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 72.w,
                    height: 94.h,
                    decoration: ShapeDecoration(
                      color: colorAfterSelected
                          ? ColorsCatalog().APP_GOLD
                          : ColorsCatalog().APP_WHITE,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12.w,
                  top: 23.h,
                  child: Container(
                    width: 49.w,
                    height: 49.h,
                    decoration: ShapeDecoration(
                      color: ColorsCatalog().APP_GREY_LABEL,
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 28,
                  top: 30,
                  child: Container(
                    width: 16.w,
                    height: 35.h,
                    decoration: isGradientColorBox
                        ? ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(-0.16, -0.99),
                              end: Alignment(0.16, 0.99),
                              colors: [Color(0xFF009048), Color(0xFF2669AE)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          )
                        : ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            color: insideBoxColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
