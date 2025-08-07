import 'dart:async';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tech_blog/constant/api_url_constant.dart';
import 'package:tech_blog/models/podcast/podcasts_file_model.dart';
import 'package:tech_blog/services/dio_service.dart';

class SinglePodcastController extends GetxController {
  var id;
  SinglePodcastController({this.id});

  RxBool loading = false.obs;
  RxBool playState = false.obs;
  RxBool isLoopAll = false.obs;
  RxInt currentFileIndex = 0.obs;
  RxList<PodcastsFileModel> podcastsFileModel = RxList();
  final player = AudioPlayer();

  @override
  onInit() async {
    super.onInit();
    await getPodcastFiles();
  }

  Future<void> getPodcastFiles() async {
    podcastsFileModel.clear();
    loading.value = true;

    var response = await DioService().getMethod(
      ApiUrlConstant.podcastFiles + id,
    );
    if (response.statusCode == 200) {
      List<AudioSource> sources = [];

      for (var element in response.data['files']) {
        var podcastFileModel = PodcastsFileModel.fromJson(element);
        podcastsFileModel.add(podcastFileModel);

        if (podcastFileModel.file != null) {
          sources.add(AudioSource.uri(Uri.parse(podcastFileModel.file!)));
        }
      }

      if (sources.isNotEmpty) {
        await player.setAudioSources(
          sources,
          initialIndex: 0,
          initialPosition: Duration.zero,
          preload: true,
          shuffleOrder: DefaultShuffleOrder(),
        );
      }

      loading.value = false;
    }
  }

  Rx<Duration> progressValue = Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = Duration(seconds: 0).obs;

  Timer? timer;

  startProgress() {
    const tick = Duration(seconds: 1);
    int duration = player.duration!.inSeconds - player.position.inSeconds;

    if (timer != null && timer!.isActive) {
      timer!.cancel();
      timer = null;
    }

    timer = Timer.periodic(tick, (timer) {
      duration--;
      progressValue.value = player.position;
      bufferedValue.value = player.bufferedPosition;

      if (duration <= 0) {
        timer.cancel();
        progressValue.value = Duration(seconds: 0);
        bufferedValue.value = Duration(seconds: 0);
      }
    });
  }

  timerCheck() {
    if (player.playing) {
      startProgress();
    } else {
      timer!.cancel();
      progressValue.value = Duration(seconds: 0);
      bufferedValue.value = Duration(seconds: 0);
    }
  }

  setLoopMode() {
    if (isLoopAll.value) {
      isLoopAll.value = false;
      player.setLoopMode(LoopMode.off);
    } else {
      isLoopAll.value = true;
      player.setLoopMode(LoopMode.all);
    }
  }
}
