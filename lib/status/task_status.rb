class TaskStatus < Status
  STATUS = {
    INITIAL: 0,
    PENNDING: 1,
    PROGLESS: 2,
    DONE: 3,
    REJECTED: 4,
  }

  STATUS_JP = {
    INITIAL: "初期",
    PENNDING: "しぶい",
    PROGLESS: "進行中",
    DONE: "完了",
    REJECTED: "却下",
  }
end
