require_relative '../lib/app_depute'

describe "scrap_id method" do

 	it "should return an array" do
		expect(perform).is_a?(Array)
	end

	it "should return an array, and the array is not nil" do
		expect(perform).not_to be_nil
	end

	it "should return a hash in the array" do
		expect(perform[1]).is_a?(Hash)
	end

	it "the hashes in the array should have a name, surname and a mail" do
		expect(perform[0]["first_name"]).to eq("Damien")
		expect(perform[0]["last_name"]).to eq("Abad")
		expect(perform[0]["email"]).to eq("damien.abad@assemblee-nationale.fr")
end

end

