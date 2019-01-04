require 'trello'
require 'pry'

def puts_todos
  configure
  cards = get_cards

  puts '-------------------------'
  puts '【TODO】'
  cards.each do |card|
    puts card.name
  end
  puts '-------------------------'
end

def configure
  Trello.configure do |config|
    config.developer_public_key = '0541c8e906d8a48e5851424e79da4a9f' # The "key" from step 1
    config.member_token = '5e227a47614ebeb695fd56c20306856e38b17414df089e8a5a958a391af08a61' # The token from step 2.
  end
end

def get_cards
  member = Trello::Member.find('val47035922')
  boards = member.boards
  board = boards.find{ |board| board.name == 'TODO'}
  list = board.lists[0]
  cards = list.cards
  cards
end

puts_todos
