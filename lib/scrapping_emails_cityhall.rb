puts "\e[H\e[2J"    #clear le terminal

le résult doit etre
hash des emails des mairies du 95
a = [
  { "ville_1" => "email_1" },
  { "ville_2" => "email_2" }, 
  etc
]


require 'pry'
require 'nokogiri'
require 'open-uri'



get_townhall_email(townhall_url)


def cityhall

page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/"))


end




