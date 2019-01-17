puts "\e[H\e[2J"    #clear le terminal

# resultat attendu
# a = [
#   { "BTC" => 5245.12 },
#   { "ETH" => 217.34 }, 
#   etc
# ]

require 'pry'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

value_crypto = []
page.xpath("//td[5]/a").each do |node| value_crypto << node.text end

symbol_crypto = []
page.xpath("//td[3]").each do |node| symbol_crypto << node.text end



nbcrypto = value_crypto.length
crytpoarray = []
nbcrypto.times do | i|
crytpoarray << { "#{symbol_crypto[i]}" => "#{value_crypto[i]}" }
    
end

print crytpoarray[0]

#binding.pry







