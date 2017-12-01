words = [
  'text',
  'web page',
  'website',
  'font',
  'software',
  'technology',
  'product',
  'screenshot',
  'black',
]

words.each do |word|
  PositiveWord.seed do |s|
    s.display = word
  end
end
