require "tty-prompt"
prompt = TTY::Prompt.new(active_color: :magenta, symbols: {marker: "⬢"})
require 'colorize'
require_relative 'dice.rb'
require_relative 'player.rb'
require_relative 'enemy.rb'
require_relative 'combat.rb'

system('clear')

puts "Welcome to..."

prompt.warn(
    "
    ·▄▄▄▪   ▄▄ •  ▄ .▄▄▄▄▄▄    • ▌ ▄ ·.        ▐ ▄ .▄▄ · ▄▄▄▄▄▄▄▄ .▄▄▄  .▄▄ · 
    ▐▄▄·██ ▐█ ▀ ▪██▪▐█•██      ·██ ▐███▪▪     •█▌▐█▐█ ▀. •██  ▀▄.▀·▀▄ █·▐█ ▀. 
    ██▪ ▐█·▄█ ▀█▄██▀▐█ ▐█.▪    ▐█ ▌▐▌▐█· ▄█▀▄ ▐█▐▐▌▄▀▀▀█▄ ▐█.▪▐▀▀▪▄▐▀▀▄ ▄▀▀▀█▄
    ██▌.▐█▌▐█▄▪▐███▌▐▀ ▐█▌·    ██ ██▌▐█▌▐█▌.▐▌██▐█▌▐█▄▪▐█ ▐█▌·▐█▄▄▌▐█•█▌▐█▄▪▐█
    ▀▀▀ ▀▀▀·▀▀▀▀ ▀▀▀ · ▀▀▀     ▀▀  █▪▀▀▀ ▀█▄▀▪▀▀ █▪ ▀▀▀▀  ▀▀▀  ▀▀▀ .▀  ▀ ▀▀▀▀ 
          ▄▄▄      ▄▄▌ ▐ ▄▌ ▄ .▄ ▄▄▄· ▄▄▄▄▄▄▄▄ . ▌ ▐·▄▄▄ .▄▄▄                 
    ▪     ▀▄ █·    ██· █▌▐███▪▐█▐█ ▀█ •██  ▀▄.▀·▪█·█▌▀▄.▀·▀▄ █·               
     ▄█▀▄ ▐▀▀▄     ██▪▐█▐▐▌██▀▐█▄█▀▀█  ▐█.▪▐▀▀▪▄▐█▐█•▐▀▀▪▄▐▀▀▄                
    ▐█▌.▐▌▐█•█▌    ▐█▌██▐█▌██▌▐▀▐█ ▪▐▌ ▐█▌·▐█▄▄▌ ███ ▐█▄▄▌▐█•█▌               
     ▀█▄▀▪.▀  ▀     ▀▀▀▀ ▀▪▀▀▀ · ▀  ▀  ▀▀▀  ▀▀▀ . ▀   ▀▀▀ .▀  ▀               
    "
)

input = prompt.select(' ') do |menu|
    menu.choice "START"
    menu.choice "HOW TO PLAY"
    menu.choice "DICE"
    menu.choice "QUIT"
end

if input == "START"
    load('arena.rb')
elsif input == "HOW TO PLAY"
    exit
elsif input == "DICE"
    load('dice_roll.rb')
elsif input == "QUIT"
    system('clear')
    puts "See you later!"
    exit
end



    