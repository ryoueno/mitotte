/**
 * アクティビティの状態を管理する
 */
var ActivityStatus = function(status) {

  DEFAULT_STATUS = 'DO_SOMETHING';

  this.name = status === undefined ? DEFAULT_STATUS : status;
  this.task_id;

  this.doSomething = function() {
    this.name = 'DO_SOMETHING';
    return this;
  }

}

/**
 * アクティビティを保存するAPIに送信する
 */
var ActivitySender = function(status) {
  this.status = status;

  /**
   * アクティビティを送信する
   * 引数があればその値を送信
   * なければ自身が継続して保持しているstatusを送信
   *
   * @param string behavior アクティビティの種類
   * @param datetime datetime タイムスタンプ
   */
  this.run = function(behavior, datetime) {
    readText(messages['normal']['random' + Math.floor( Math.random() * 9 + 1 )]);
    $.ajax({
      url: gon.activity_api_url,
      type: 'POST',
      dataType: 'json',
      data: {
        user_id: gon.user_id,
        behavior: behavior === undefined ? this.status.name : behavior,
        task_id: this.status.task_id,
        created_at: datetime
      },
    }).done(function(res) {
      console.log(res);
    }).fail(function(data) {
      console.log("Can not connect api.")
    });
  }
}

var activity_status = new ActivityStatus('RUNNING');
var activity_sender = new ActivitySender(activity_status);

// これを挟まないと動かなかった(´・ω・` )
var run = function() {
  activity_sender.run();
}

setInterval(run, 20000);

$(function () {
  $('input:radio[name=task]').change(function() {
    $('.badge').css('display', 'none');
    $('#task_badge' + $(this).val()).css('display', 'inline');
    if ($(this).val() === "0") {
      activity_sender.status.name = "RESTING";
      activity_sender.status.task_id = undefined;
      readText(messages['normal']['rest']);
    } else {
      activity_sender.status.name = "WORKING";
      activity_sender.status.task_id = $(this).val();
      readText(messages['normal']['activity']);
    }
  });
});

firebase.initializeApp(gon.config);

var starCountRef = firebase.database().ref(gon.key);
starCountRef.on('value', function(activities) {
  var activity = activities.val();
  activity_sender.run(activity.behavior, activity.time);
});

var messages = {
  normal: {
    activity: "頑張れよ〜〜、若干応援してるわ。",
    rest: "ごゆっくり〜〜",
    random1: "今度あんたの家に遊びに行くわ。",
    random2: "詰まっても諦めずに考えろ。あんたのそのしょうもない頭でな。",
    random3: "とりあえず何も考えずに手だけ動かしてみ。意外と何とかなるもんよ。",
    random4: "長時間パソコン使ってるとキーボードがヌルヌルになるよな。",
    random5: "俺もこうやって喋ってるけど、結局JavaScriptで動いてるだけなんだよね。",
    random6: "自分のペースでしっかりやっとけば。周りとか気にしてないで。",
    random7: "あんたの顔見てるだけで安心するわ。褒めてないけど。",
    random8: "俺はおにぎりは温めない派だけど、あんたはどうなんだよ。",
    random9: "暇なら俺の名前考えて。",
  }
};


var readText = function(txt) {
  $('#js-message-area').html("");
  var switched = false
  var txtArr = txt.split("");
  var count = 0;
  var txtCount = function() {
    var timer = setTimeout(txtCount, 50);
    $('#js-message-area').append(txtArr[count]);
    count++;
    if (count % 3 === 0) {
      if (switched) {
        $('.mitotte-area').css('background-image', 'url("/images/dogs/dog1a.png")');
        switched = false;
      } else {
        $('.mitotte-area').css('background-image', 'url("/images/dogs/dog1b.png")');
        switched = true;
      }
    }
    if (count == txtArr.length) {
      clearTimeout(timer);
      $('.mitotte-area').css('background-image', 'url("/images/dogs/dog1a.png")');
    }
  }
  txtCount();
}
