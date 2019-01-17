puts "\e[H\e[2J"    #clear le terminal

# a = [
#   { "BTC" => 5245.12 },
#   { "ETH" => 217.34 }, 
#   etc
# ]

require 'pry'
require 'nokogiri'
require 'open-uri'





#def crypto_scrapper

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
#puts page.class   # => Nokogiri::HTML::Document
#return 
#end



#all_crypto_array = 

value_crypto = []
page.xpath("//td[5]/a").each do |node|  value_crypto << node.text end

symbol_crypto = []
page.xpath("//td[3]").each do |node|  symbol_crypto << node.text end
# print "#{value_crypto}"
# puts " "
# puts " "
# puts " "
# puts " "
# print "#{symbol_crypto}"
# puts " "
# puts " "




nbcrypto = value_crypto.length
crytpoarray = []
nbcrypto.times do | i|
    crytpoarray << { "#{symbol_crypto[i]}" => "#{value_crypto[i]}" }
    
end

print crytpoarray[0]



binding.pry







