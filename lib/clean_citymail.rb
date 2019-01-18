puts "\e[H\e[2J"    #clear le terminal
require 'pry'
require 'nokogiri'
require 'open-uri'

def get_townhall_urls(url)
	liste_site_des_mairie = []
	scrappagetotal = Nokogiri::HTML(open(url))
	news_links_dirty = scrappagetotal.css("tr").css("a").select{|link| link['class'] == "lientxt"}
	news_links_dirty.each{|link| liste_site_des_mairie << "https://www.annuaire-des-mairies.com/#{link['href'].to_s.slice!(1..-1)}"}
	return liste_site_des_mairie
end


def get_townhall_email(townhall_url)
  townhall_url.each do |eachcitysite|
	city_doc_all = Nokogiri::HTML(open(eachcitysite))
  cty_twnhall = city_doc_all.xpath("//body/div/main/section[2]/div/table/tbody/tr[4]/td[2]") 		#ultra presci...
  city_mail = []
  city_mail = cty_twnhall.to_s.slice(4...-5)										#### ceci ne fonctionne pas -->  .select { |v| v =~ /[@]/ } 
  print city_mail
end
end


def perform(url)
	sites_des_villes = get_townhall_urls(url)
	full_val_d_oise_mails_list = get_townhall_email(sites_des_villes)
	return full_val_d_oise_mails_list
end

valdoise_url = "https://www.annuaire-des-mairies.com/val-d-oise.html"


full_val_d_oise_mails_list = perform(valdoise_url)

print full_val_d_oise_mails_list








