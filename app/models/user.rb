class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :projects
  has_many :activities
  before_save :set_keyword
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def set_keyword
    self.keyword = @@keywords.sample if not self.keyword
    self
  end

  def activity_image
    root_url(only_path: false)
  end

  def self.keywords
    @@keywords
  end

  def todo_at?(date: nil, time: nil, ignore_status: false, ignore_schedule: false)
    date ||= Date.today
    time ||= Tod::TimeOfDay(Time.now)
    self.projects.each do |p|
      return true if p.todo_at?(date: date, time: time, ignore_status: ignore_status, ignore_schedule: ignore_schedule)
    end
    return false
  end

  def todo_tasks(date: nil, time: nil, ignore_status: false, ignore_schedule: false)
    self.projects.map {|p| p.todo_tasks(date: date, time: time, ignore_status: ignore_status, ignore_schedule: ignore_schedule)}.flatten
  end

  @@keywords = [
    "あーもんど",
    "あぶら",
    "おちゃ",
    "おにぎり",
    "かれーらいす",
    "ぎゅうにゅう",
    "くるみ",
    "けちゃっぷ",
    "ここあ",
    "ごはん",
    "さとう",
    "さんどいっち",
    "しお",
    "じゃむ",
    "じゅーす",
    "しょうゆ",
    "すーぷ",
    "すし",
    "すぱげってぃ",
    "そーす",
    "そーせーじ",
    "たまご",
    "ちーず",
    "とりにく",
    "にく",
    "のみもの",
    "ばたー",
    "はむ",
    "ぱん",
    "はんばーがー",
    "ぴーなっつ",
    "ぴざ",
    "ほっととっぐ",
    "まよねーず",
    "みず",
    "いちご",
    "いちじく",
    "うめ",
    "かき",
    "きのみ",
    "くだもの",
    "くり",
    "さくらんぼ",
    "すいか",
    "ぱいなっぷる",
    "ばなな",
    "ぶどう",
    "みかん",
    "めろん",
    "もも",
    "りんご",
    "れもん",
    "かぼちゃ",
    "きゃべつ",
    "きゅうり",
    "ごぼう",
    "ごま",
    "さつまいも",
    "じゃがいも",
    "しょうが",
    "だいこん",
    "たけのこ",
    "たまねぎ",
    "とうがらし",
    "とうもろこし",
    "とまと",
    "なす",
    "にんじん",
    "にんにく",
    "ねぎ",
    "ぴーまん",
    "ほうれんそう",
    "きのこ",
    "やさい",
    "れたす",
  ]
end
