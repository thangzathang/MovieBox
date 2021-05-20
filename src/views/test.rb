=begin
require "tty-prompt"

@prompt = TTY::Prompt.new

$ans = @prompt.slider("Volume", min: 0, max: 100, step: 5)

puts "Ans is: #{$ans}"
=end

# tty-box
require "tty-box"

# box = TTY::Box.frame "Drawing a box in", "terminal emulator", padding: 3, align: :center

# print box

# print TTY::Box.frame "Hello world!"

# box = TTY::Box.frame(
#     width: 30, 
#     height: 10, 
#     title: {top_left: " Tron ", bottom_right: " 99% "}
#     )

# print box

box = TTY::Box.frame(align: :center, 
padding: 2,
border: :thick, 
title: {top_left: " Tron ", bottom_right: " 99% "}) do
    ""
end

print box

box2 = TTY::Box.success("Successfully Saved").center(20)


print box2
