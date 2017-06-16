firebase.initializeApp(gon.config);

var starCountRef = firebase.database().ref(gon.key);
starCountRef.on('value', function(activities) {
  activities = activities.val();
  for (let id in activities) {
    // TODO: Get user state.
    syncActivity("DO SOMETHING.", activities[id])
  }
});

function setActivity(activities) {
  msg_area = document.getElementById("fb-activity");
  msg_area.innerHTML = "<h3>" + activities.behavior + "</h3>";
}

function syncActivity(behavior, activity) {
  $.ajax({
    url: gon.activity_api_url,
    type: 'POST',
    dataType: 'json',
    data: {
      user_id: gon.user_id,
      behavior: behavior,
      created_at: activity.time
    },
  }).done(function(res) {
    setActivity(res);
  }).fail(function(data) {
    console.log("Can not connect api.")
  });
}
