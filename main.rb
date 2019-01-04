require 'trello'
require 'pry'

def puts_todos
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
  list = get_todo_list
  cards = list.cards
  cards
end

def get_todo_list
  member = Trello::Member.find('val47035922')
  boards = member.boards
  board = boards.find{ |board| board.name == 'TODO'}
  list = board.lists[0]
  list
end

def puts_menu
  puts '-------------------------'
  puts 'select number of control'
  puts 'TODO show  : 1'
  puts 'Create card: 2'
  puts 'Quit       : 0'
end

def create_card
  print 'Input card name: '
  card_name = gets
  list = get_todo_list
  Trello::Card.create(:name => card_name, :list_id => list.id)
  puts "Created new card!"
  puts '-------------------------'
end

configure
loop do
  puts_menu
  print 'Select   : '
  input = gets.to_i

  case input
  when 1 then
    puts_todos
  when 2 then
    create_card
  when 0 then
    break
  end
end
