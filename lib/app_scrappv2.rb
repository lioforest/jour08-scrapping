require 'twitter'
require 'dotenv'
require 'pry'
require 'nokogiri'
require 'open-uri'




Dotenv.load('.env')


# quelques lignes qui appellent les clés d'API de ton fichier .env
def connexion_page_html (cible = "https://coinmarketcap.com/all/views/all/")
	page = Nokogiri::HTML(open(cible))
	return page

end

def scrap_id
	$array_symbol = []
	all_crypto_symbol = connexion_page_html.xpath("//td[3]")


	all_crypto_symbol.each do |id_currencie|

		$array_symbol << id_currencie.text

	end

end


def scrap_value_usd
	$array_value_usd = []
	all_crypto_symbol = connexion_page_html.xpath("//td[5]")


	all_crypto_symbol.each do |id_currencie|

		$array_value_usd << id_currencie.text.strip
	end
	return $array_value_usd
end

def hashtest

  results = Hash.new

  	i=0
  	while i<$array_symbol.length
	results[$array_symbol[i]] = $array_value_usd[i]
	i+=1
	end
	

	puts results
end




connexion_page_html
scrap_id
scrap_value_usd
hashtest
