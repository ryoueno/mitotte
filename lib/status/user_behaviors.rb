class UserBehaviors < Status
  STATUS = {
    UNKNOWN_STATE: 0,
    TASK_STATE_UPDATE: 1,
  }

  STATUS_JP = {
    UNKNOWN_STATE: "不明な状態",
    TASK_STATE_UPDATE: "タスク[%s]の状態を%sから%sに変更しました",
  }
end
