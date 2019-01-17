puts "\e[H\e[2J"    #clear le terminal
#binding.pry

# le résult doit etre
# hash des emails des mairies du 95
# a = [
#   { "ville_1" => "email_1" },
#   { "ville_2" => "email_2" }, 
#   etc
# ]

#get_townhall_email(townhall_url)

require 'pry'
require 'nokogiri'
require 'open-uri'

#/html/body/div/main/section[2]/div/table/tbody/tr[1]/td[1]/a


def all_dep
	scrappagetotal = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/"))
	
	#selectionne les liens du corp de page avec la class "lientxt"
	dep_links_dirty = scrappagetotal.css("tbody").css("a").select{|link| link['class'] == "lientxt"}

	mails_each_dep = []
	
	#création de l'array de mails + mise en forme des mails
	dep_links_dirty.each{|link| mails_each_dep << "https://www.annuaire-des-mairies.com/#{link['href'].to_s}"}
	#puts mails_each_dep

	return mails_each_dep
end


#lien = "https://www.annuaire-des-mairies.com/isere.html"


def true_city_mail_list

	mails_each_dep.each do |mail|

		if check_page(mail) == true
			true_dep_mail_list << mail
		end

		i = 2
		temp_dep_mail = ""

		until page_exist == false do
			
			temp_dep_mail = mail.insert(-6;"-#{i}")		#modificaton du mail d'origine
			
			check_page(temp_dep_mail)									#fait tourner pour voir si la page existe
			
			if page_exist == true
				true_dep_mail_list << temp_dep_mail
			i += 1
			end
		end
	end

	return true_dep_mail_list
end


def check_page(url)
	begin
    open(url)
  rescue OpenURI::HTTPError
    page_exist = false
    return
  end
  	page_exist = true
  return
end







puts check_page("https://www.annuaire-des-mairies.com/cantal-2.html")











# #def all_commune

# page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/vosges.html"))
# #departement_doc.each{|link| puts link['href'] }

# news_links = page.css("tr").css("a").select{|link| link['class'] == "lientxt"}
# #### ca reste un node avec trop de chose mais selectionne que les bons #######
# ###########news_links.each{|link| puts " babrare  #{link['href']}" }				# ajout fonctionne
# #news_links.each {|link| puts link['href.slice(1..-1)']  }										#non, disparait

# #news_links.each{|link| puts "https://www.annuaire-des-mairies.com/#{link['href'].to_s.slice!(1..-1)}"}					######GGGGGOOOOOODDDDD


# mails_each_city = []
# news_links.each{|link| mails_each_city << "https://www.annuaire-des-mairies.com/#{link['href'].to_s.slice!(1..-1)}"}
# print mails_each_city



# # news_links.each{|link| puts " babrare  #{link['href']}" }

# # news_links.each{|link| puts " babrare  #{link['href']}" }

# # news_links.each{|link| puts " babrare  #{link['href']}" }

# # news_links.each{|link| puts " babrare  #{link['href']}" }







# #liens =  departement_doc.css("a.lientxt")['href']
# #puts liens																	#j'ai toute <a.....>
# #puts "#{liens.map do |i| i=i["href"] end}"
# #	puts liens


# #.css("a[@class=lientxt]/@href").attribute("href")

# # commune_list0 = 
# #puts commune_list0





# def mail_citytwnhll

# city_doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/88/epinal.html"))
#     cty_twnhall = city_doc.xpath("//tbody/tr[4]/td[2]")
#     print cty_twnhall
#     city_mail = cty_twnhall.select { |v| v =~ /[@]/ } 

# end