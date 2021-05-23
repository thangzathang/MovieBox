# Gems
require "tty-box"
require "tty-table"
require 'terminal-table'

=begin
require "tty-prompt"

@prompt = TTY::Prompt.new

$ans = @prompt.slider("Volume", min: 0, max: 100, step: 5)

puts "Ans is: #{$ans}"
=end

# box = TTY::Box.frame "Drawing a box in", "terminal emulator", padding: 3, align: :center

# print box

# print TTY::Box.frame "Hello world!"

# box = TTY::Box.frame(
#     width: 30, 
#     height: 10, 
#     title: {top_left: " Tron ", bottom_right: " 99% "}
#     )

# print box

# box = TTY::Box.frame(align: :center, 
# padding: 2,
# border: :thick, 
# title: {top_left: "  ", bottom_right: " "}) do
#     ""
# end

# print box

# box2 = TTY::Box.success("Successfully Saved").center(20)

# print box2

# table = TTY::Table.new(["o","o"],
#     [
#         ["Title", "Collateral"], 
#         ["Year:", "2004"],
#         ["Director", "Michael Mann"]
#     ]
#     )
# table.render do |renderer|
#     renderer.border.separator = :each_row
# end

# puts table.render(:ascii)
rows = []
# rows << ['One', 1]
# rows << ['Two', 2]
# rows << ['Three', 3]

@table = Terminal::table.new
@table :title => "Cheatsheet", 
:headings => ['Word', 'Number'],
:rows => rows

table.style = {:width => 40, :padding_left => 3, :border_x => "=", :border_i => "x"}

puts table
#
# x======================================x
# |               Cheatsheet             |
# x====================x=================x
# |   Word             |   Number        |
# x====================x=================x
# |   One              |   1             |
# |   Two              |   2             |
# |   Three            |   3             |
# x====================x=================x




