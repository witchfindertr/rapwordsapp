import 'package:foap/helper/imports/common_import.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_polls/flutter_polls.dart';

import '../../components/post_card.dart';
import '../../controllers/add_post_controller.dart';
import '../../controllers/live/agora_live_controller.dart';
import '../../controllers/home_controller.dart';
import '../../model/call_model.dart';
import '../../model/post_model.dart';
import '../../segmentAndMenu/horizontal_menu.dart';
import '../dashboard/explore.dart';
import '../post/select_media.dart';
import '../post/view_post_insight.dart';
import '../settings_menu/settings_controller.dart';
import '../story/choose_media_for_story.dart';
import '../story/story_updates_bar.dart';
import '../story/story_viewer.dart';
import 'map_screen.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({Key? key}) : super(key: key);

  @override
  HomeFeedState createState() => HomeFeedState();
}

class HomeFeedState extends State<HomeFeedScreen> {
  final HomeController _homeController = Get.find();
  final AddPostController _addPostController = Get.find();
  final AgoraLiveController _agoraLiveController = Get.find();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final SettingsController _settingsController = Get.find();

  final _controller = ScrollController();

  String? selectedValue;
  int pollFrequencyIndex = 10;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData(isRecent: true);

      _homeController.loadQuickLinksAccordingToSettings();
    });

    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
        } else {
          loadData(isRecent: false);
        }
      }
    });
  }

  loadMore({required bool? isRecent}) {
    loadPosts(isRecent);
  }

  refreshData() {
    _homeController.clear();
    loadData(isRecent: false);
  }

  @override
  void dispose() {
    super.dispose();
    _homeController.clear();
    _homeController.closeQuickLinks();
  }

  loadPosts(bool? isRecent) {
    _homeController.getPosts(
        isRecent: isRecent,
        callback: () {
          _refreshController.refreshCompleted();
        });
  }

  void loadData({required bool? isRecent}) {
    loadPosts(isRecent);
    _homeController.getPolls();
    _homeController.getStories();
  }

  @override
  void didUpdateWidget(covariant HomeFeedScreen oldWidget) {
    loadData(isRecent: false);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorConstants.backgroundColor,
        // floatingActionButton: Container(
        //   height: 50,
        //   width: 50,
        //   color: AppColorConstants.themeColor,
        //   child: const ThemeIconWidget(
        //     ThemeIcon.edit,
        //     size: 25,
        //     color: Colors.white,
        //   ),
        // ).circular.ripple(() {
        //   Future.delayed(
        //     Duration.zero,
        //     () => showGeneralDialog(
        //         context: context,
        //         pageBuilder: (context, animation, secondaryAnimation) =>
        //             const SelectMedia()),
        //   );
        // }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // menuView(),
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Heading3Text(
                      AppConfigConstants.appName,
                      weight: TextWeight.regular,
                      color: AppColorConstants.themeColor,
                    )
                  ],
                ),
                const Spacer(),
                // const ThemeIconWidget(
                //   ThemeIcon.map,
                //   // color: ColorConstants.themeColor,
                //   size: 25,
                // ).ripple(() {
                //   Get.to(() => MapsUsersScreen());
                // }),
                // const SizedBox(
                //   width: 20,
                // ),
                const ThemeIconWidget(
                  ThemeIcon.search,
                  size: 25,
                ).ripple(() {
                  Get.to(() => const Explore());
                }),
                const SizedBox(
                  width: 20,
                ),
                Obx(() => Container(
                      color: AppColorConstants.backgroundColor,
                      height: 25,
                      width: 25,
                      child: ThemeIconWidget(
                        _homeController.openQuickLinks.value == true
                            ? ThemeIcon.close
                            : ThemeIcon.menuIcon,
                        // color: ColorConstants.themeColor,
                        size: 25,
                      ),
                    ).ripple(() {
                      _homeController.quickLinkSwitchToggle();
                    })),
              ],
            ).hp(20),
            // const SizedBox(
            //   height: 10,
            // ),
            Expanded(
              child: postsView(),
            ),
          ],
        ));
  }

  // Widget menuView() {
  //   return Obx(() => AnimatedContainer(
  //         height: _homeController.openQuickLinks.value == true ? 450 : 0,
  //         width: Get.width,
  //         color: ColorConstants.themeColor,
  //         duration: const Duration(milliseconds: 500),
  //         child: QuickLinkWidget(callback: () {
  //           _homeController.closeQuickLinks();
  //         }),
  //       ));
  // }

  Widget postingView() {
    return Obx(() => _addPostController.isPosting.value
        ? Container(
            height: 55,
            color: AppColorConstants.cardColor,
            child: Row(
              children: [
                Image.memory(
                  _addPostController.postingMedia.first.thumbnail!,
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ).round(5),
                const SizedBox(
                  width: 10,
                ),
                Heading5Text(
                  _addPostController.isErrorInPosting.value
                      ? postFailedString.tr
                      : postingString.tr,
                ),
                const Spacer(),
                _addPostController.isErrorInPosting.value
                    ? Row(
                        children: [
                          Heading5Text(
                            discardString.tr,
                            weight: TextWeight.medium,
                          ).ripple(() {
                            _addPostController.discardFailedPost();
                          }),
                          const SizedBox(
                            width: 20,
                          ),
                          Heading5Text(
                            retryString.tr,
                            weight: TextWeight.medium,
                          ).ripple(() {
                            _addPostController.retryPublish(context);
                          }),
                        ],
                      )
                    : Container()
              ],
            ).hP8,
          ).backgroundCard(radius: 10).bp(20)
        : Container());
  }

  Widget storiesView() {
    return SizedBox(
      height: 110,
      child: GetBuilder<HomeController>(
          init: _homeController,
          builder: (ctx) {
            return StoryUpdatesBar(
              stories: _homeController.stories,
              liveUsers: _homeController.liveUsers,
              addStoryCallback: () {
                // Get.to(() => const TextStoryMaker());
                Get.to(() => const ChooseMediaForStory());
              },
              viewStoryCallback: (story) {
                Get.to(() => StoryViewer(
                      story: story,
                      storyDeleted: () {
                        _homeController.getStories();
                      },
                    ));
              },
              joinLiveUserCallback: (user) {
                Live live = Live(
                    channelName: user.liveCallDetail!.channelName,
                    isHosting: false,
                    host: user,
                    token: user.liveCallDetail!.token,
                    liveId: user.liveCallDetail!.id);
                _agoraLiveController.joinAsAudience(
                  live: live,
                );
              },
            ).vP16;
          }),
    );
  }

  postsView() {
    return Obx(() {
      return ListView.separated(
              controller: _controller,
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: _homeController.posts.length + 3,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Obx(() =>
                      _homeController.isRefreshingStories.value == true
                          ? const StoryAndHighlightsShimmer()
                          : storiesView());
                } else if (index == 1) {
                  return postingView().hP16;
                } else if (index == 2) {
                  return Obx(() => Column(
                        children: [
                          HorizontalMenuBar(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              onSegmentChange: (segment) {
                                _homeController.categoryIndexChanged(
                                    index: segment,
                                    callback: () {
                                      _refreshController.refreshCompleted();
                                    });
                              },
                              selectedIndex:
                                  _homeController.categoryIndex.value,
                              menus: [
                                allString.tr,
                                followingString.tr,
                                // trending,
                                // recentString.tr,
                                // yourString.tr,
                              ]),
                          _homeController.isRefreshingPosts.value == true
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  child: const HomeScreenShimmer())
                              : _homeController.posts.isEmpty
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      child: emptyPost(
                                          title: noPostFoundString.tr,
                                          subTitle:
                                              followFriendsToSeeUpdatesString
                                                  .tr),
                                    )
                                  : Container()
                        ],
                      ).bP25);
                } else {
                  PostModel model = _homeController.posts[index - 3];

                  return PostCard(
                    model: model,
                    textTapHandler: (text) {
                      _homeController.postTextTapHandler(
                          post: model, text: text);
                    },
                    viewInsightHandler: () {
                      Get.to(() => ViewPostInsights(post: model));
                    },
                    removePostHandler: () {
                      _homeController.removePostFromList(model);
                    },
                    blockUserHandler: () {
                      _homeController.removeUsersAllPostFromList(model);
                    },
                  );
                }
              },
              separatorBuilder: (context, index) {
                if (_settingsController.setting.value!.enablePolls) {
                  return polls(index);
                } else {
                  return const SizedBox(
                    height: 0,
                  );
                }
              })
          .addPullToRefresh(
              refreshController: _refreshController,
              enablePullUp: false,
              enablePullDown: true,
              onRefresh: refreshData,
              onLoading: () {});
    });
  }

  polls(int index) {
    int postIndex = index > 2 ? index - 3 : 0;
    if (postIndex % pollFrequencyIndex == 0 && postIndex != 0) {
      int pollIndex = (postIndex ~/ pollFrequencyIndex) - 1;
      if (_homeController.polls.length > pollIndex) {
        return Container(
          color: AppColorConstants.cardColor,
          child: FlutterPolls(
            pollId: _homeController.polls[pollIndex].pollId.toString(),
            hasVoted: _homeController.polls[pollIndex].isVote! > 0,
            userVotedOptionId: _homeController.polls[pollIndex].isVote! > 0
                ? _homeController.polls[pollIndex].isVote
                : null,
            onVoted: (PollOption pollOption, int newTotalVotes) async {
              await Future.delayed(const Duration(seconds: 1));
              _homeController.postPollAnswer(
                  _homeController.polls[pollIndex].pollId!,
                  _homeController.polls[pollIndex].id!,
                  pollOption.id!);

              /// If HTTP status is success, return true else false
              return true;
            },
            pollEnded: false,
            pollOptionsSplashColor: Colors.white,
            votedProgressColor: Colors.grey.withOpacity(0.3),
            votedBackgroundColor: Colors.grey.withOpacity(0.2),
            votesTextStyle: TextStyle(fontSize: FontSizes.b2),
            votedPercentageTextStyle:
                TextStyle(fontSize: FontSizes.b2).copyWith(
              color: Colors.black,
            ),
            votedCheckmark: const Icon(
              Icons.check_circle,
              color: Colors.black,
            ),
            pollTitle: Align(
              alignment: Alignment.centerLeft,
              child: BodyLargeText(
                _homeController.polls[pollIndex].title ?? "",
                weight: TextWeight.medium,
              ),
            ),
            pollOptions: List<PollOption>.from(
              (_homeController.polls[pollIndex].pollQuestionOption ?? []).map(
                (option) {
                  var a = PollOption(
                    id: option.id,
                    title: BodyLargeText(option.title ?? '',
                        weight: TextWeight.medium),
                    votes: option.totalOptionVoteCount ?? 0,
                  );
                  return a;
                },
              ),
            ),
          ).p16,
        ).round(15).p16;
      } else {
        return const SizedBox(
          height: 0,
        );
      }
    } else {
      return const SizedBox(
        height: 0,
      );
    }
  }
}
