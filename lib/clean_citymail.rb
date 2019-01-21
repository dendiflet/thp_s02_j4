puts "\e[H\e[2J"    #clear le terminal
require 'pry'
require 'nokogiri'
require 'open-uri'

def get_townhall_urls(url)
	name_and_url = []
	scrappagetotal = Nokogiri::HTML(open(url))
	news_links_dirty = scrappagetotal.css("tr").css("a").select{|link| link['class'] == "lientxt"}
	news_links_dirty.each{|link| name_and_url << { "name" => link.text, "url" => "https://www.annuaire-des-mairies.com/#{link['href'].to_s.slice!(1..-1)}"}}
	puts name_and_url
	return name_and_url
end

def get_all_email(name_and_url)
  name_and_email = []
  name_and_url.map.with_index do |value, i|
  name_and_email << { value["name"] => get_townhall_email(value["url"])}
  break if i == 10

end
  puts name_and_email
end



def get_townhall_email(townhall_url)
  #townhall_url.each do |eachcitysite|
	  city_doc_all = Nokogiri::HTML(open(townhall_url))
	  cty_twnhall = city_doc_all.xpath("//body/div/main/section[2]/div/table/tbody/tr[4]/td[2]") 		#ultra presci...
    city_mail = ""
    city_mail << cty_twnhall.to_s.slice(4...-5)										#### ceci ne fonctionne pas -->  .select { |v| v =~ /[@]/ } 
    #print city_mail
  #end
end


def perform(url)
	name_and_url = get_townhall_urls(url)

	all_emails = get_all_email(name_and_url)
	#full_val_d_oise_mails_list = get_townhall_email(name_and_url)
	return all_emails
end

valdoise_url = "https://www.annuaire-des-mairies.com/val-d-oise.html"


full_val_d_oise_mails_list = perform(valdoise_url)

puts full_val_d_oise_mails_list








