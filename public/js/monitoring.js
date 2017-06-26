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
  this.run = function(datetime) {
    $.ajax({
      url: gon.activity_api_url,
      type: 'POST',
      dataType: 'json',
      data: {
        user_id: gon.user_id,
        behavior: this.status.name,
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

setInterval(run, 10000);

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

