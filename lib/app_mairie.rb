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


def get_townhall_urls


	#On récupère le nom des mairies
	array_mairieS =[]

	$page.xpath("//td/p/a").each do |mairie|
		array_mairieS << mairie.text.downcase
	end

	#En fonction de leur nom, on récupère leur URL
	$array_mairieS_url=[]
	
	array_mairieS.each do |mairie_url|
		mairie_url = mairie_url.gsub(/[' ']/, '-')
        $array_mairieS_url << "http://annuaire-des-mairies.com/95/#{mairie_url}.html"
	end

end

	

def get_townhall_email(array_mairieS_url)

	
 	ville = []
  	email = []
  	ensemble = []
  
  	$array_mairieS_url.each do |townhall_url|

    	doc = Nokogiri::HTML(open(townhall_url))
    	doc.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node|
    		email << node.text
 	   	end

    	doc.xpath('//strong/a[@class = "lientxt4"]').each do |node|
    		ville << node.text.capitalize
    	end
  	end

  ville.size.times do |i|
    ensemble << { ville[i] => email[i] }
  end
  puts ensemble
ensemble

end

def perform
connexion_page_html
get_townhall_email(get_townhall_urls)
end


perform

