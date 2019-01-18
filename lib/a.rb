require 'pry'
require 'nokogiri'
require 'open-uri'

url = "https://www.annuaire-des-mairies.com/val-d-oise.html"
def get_townhall_urls(url)
	scrappagetotal = Nokogiri::HTML(open(url))
	news_links_dirty = scrappagetotal.css("tr").css("a").select{|link| link['class'] == "lientxt"}
	mails_each_city_dep_page_list = []
	news_links_dirty.each{|link| mails_each_city_dep_page_list << "https://www.annuaire-des-mairies.com/#{link['href'].to_s.slice!(1..-1)}"}
	puts mails_each_city_dep_page_list #ici c'est ok
	return mails_each_city_dep_page_list
end


def perform(valdoise_url)
mails_each_city_dep_page_list.each do |eachcitysite|
	city_doc_all = Nokogiri::HTML(open(eachcitysite))
  cty_twnhall = city_doc_all.xpath("//body/div/main/section[2]/div/table/tbody/tr[4]/td[2]") 		#ultra presci...
  city_mail = []
  city_mail = cty_twnhall.to_s.slice(4...-5)										#### ceci ne fonctionne pas -->  .select { |v| v =~ /[@]/ } 
  print city_mail
end
	return full_val_d_oise_mails_list
end


valdoise_url = "https://www.annuaire-des-mairies.com/val-d-oise.html"

full_list = perform(valdoise_url)
print full_list