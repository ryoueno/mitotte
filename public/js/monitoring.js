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
    } else {
      activity_sender.status.name = "WORKING";
      activity_sender.status.task_id = $(this).val();
    }
  });
});

firebase.initializeApp(gon.config);

var starCountRef = firebase.database().ref(gon.key);
starCountRef.on('value', function(activities) {
  var activity = activities.val();
  activity_sender.run(activity.behavior, activity.time);
});
