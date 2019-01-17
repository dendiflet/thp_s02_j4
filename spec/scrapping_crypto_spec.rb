require_relative '../lib/scrappin_crypto'  #sans extension

describe "blablabla" do
	it "blablabla" do
		expect(fonction?(arguments)).to eq(resultat)
	end
end


On est rassurés si, dans notre array, il existe un hash qui a BTC en key et un float non nul et non Nil en value. 
En cas d'absence, c'est que notre scrappeur n'a pas récupéré le Bitcoin (oups), 
ou s'il n'a pas de float associé, c'est qu'il n'a pas bien récupéré le cours du Bitcoin (oups bis).

a = [
  { "BTC" => 5245.12 },
  { "ETH" => 217.34 }, 
  etc
]


