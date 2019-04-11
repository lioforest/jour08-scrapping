require 'twitter'
require 'dotenv'
require 'pry'
require 'nokogiri'
require 'open-uri'



Dotenv.load('.env')


# quelques lignes qui appellent les clés d'API de ton fichier .env
def connexion_page_html (cible = "http://www.annuaire-des-mairies.com/val-d-oise.html")
	$page = Nokogiri::HTML(open(cible))
	return $page

end


def get_townhall_email(townhall_url)

	email_mairie = $page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
	puts email_mairie.text
end

def get_townhall_urls

	#On récupère le nom des mairies
	array_mairieS =[]

	$page.xpath("//td/p/a").each do |mairie|
		array_mairieS << mairie.text.downcase
	end


	#En fonction de leur nom, on récupère leur URL
	array_mairieS_url=[]
	
	array_mairieS.each do |mairie_url|
		mairie_url = mairie_url.gsub!(/\s/,'-')
        array_mairieS_url << "http://annuaire-des-mairies.com/95/#{mairie_url}.html"
	end

    #On crée un array rempli avec des hashs (composés de nos deux array)
    array_finale = []

    array_mairieS.count.times do |index|
        array_finale << {array_mairieS[index] => array_mairieS_url[index]}
    end
    puts array_finale.inspect

end


connexion_page_html
get_townhall_urls
