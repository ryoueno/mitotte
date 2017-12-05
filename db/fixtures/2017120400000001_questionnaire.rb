questions = [
  {
    display: 'mitotteを使うことによって、作業をやらないといけない気になりましたか？',
    category: 'application',
    options: {
      1 => 'なった',
      2 => '少しなった',
      3 => 'あまりならなかった',
      4 => 'なってない',
    },
  },
  {
    display: 'mitotteを使うことによって生産性が向上すると思いますか?',
    category: 'application',
    options: {
      1 => 'とても思う',
      2 => '思う',
      3 => 'あまり思わない',
      4 => '全く思わない',
    },
  },
  {
    display: '自身の作業が報告されることに抵抗がありましたか？',
    category: 'application',
    options: {
      1 => 'とても抵抗がある',
      2 => '抵抗がある',
      3 => 'あまり抵抗がない',
      4 => '全く抵抗がない',
    },
  },
  {
    display: '作業の際、mitotteに監視されていることを意識しましたか？',
    category: 'application',
    options: {
      1 => 'とても意識した',
      2 => '意識した',
      3 => 'あまり意識していない',
      4 => '全く意識していない',
    },
  },
  {
    display: '予定の設定はわかりやすかったですか？',
    category: 'application',
    options: {
      1 => 'とてもわかりやすい',
      2 => 'わかりやすい',
      3 => 'わかりにくい',
      4 => 'ひどい',
    },
  },
  {
    display: '予定を管理するにあたって、mitotteは使いやすいと思いましたか？',
    category: 'application',
    options: {
      1 => 'とても使いやすい',
      2 => '使いやすい',
      3 => 'やや使いにくい',
      4 => '使いにくい',
      5 => '無理',
    },
  },
  {
    display: 'mitotteから作業開始時間の通知は、役に立ちましたか?',
    category: 'notification',
    options: {
      1 => 'とても役になった',
      2 => '役に立った',
      3 => 'あまり役に立たなかった',
      4 => '全く役に立たなかった',
    },
  },
  {
    display: 'mitotteからの通知の頻度はどうでしたか？',
    category: 'notification',
    options: {
      1 => '少ない',
      2 => 'ちょうどいい',
      3 => '多い',
      4 => 'うざい',
    },
  },
  {
    display: 'mitotteを利用して、役に立った部分を教えてください',
    category: 'free',
  },
  {
    display: 'mitotteを利用して、不足している部分をお聞かせください',
    category: 'free',
  },
  {
    display: 'このようなシステムによって進捗管理を自動化することは現実的だと思いますか？ またその理由をお聞かせください',
    category: 'free',
  },
  {
    display: 'その他、mitotteによる自動進捗管理システムについて何かあればお聞かせください',
    category: 'free',
  },
]

questions.each do |question|
  Questionnaire.seed do |s|
    s.display = question[:display]
    s.category = question[:category]
    s.options = question[:options]
  end
end
