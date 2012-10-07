module ItemFactory
  def valid_temando_item(options={})
    Temando::Item::GeneralGoods.new({:length => 0.1, :width => 0.1, :height => 0.1, :weight => 1.0, :quantity => 1, :description => 'Hats'}.merge(options))
  end
end

RSpec.configure do |c|
  c.include ItemFactory
end
