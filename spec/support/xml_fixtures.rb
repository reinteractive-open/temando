module XmlFixtures
  def xml_fixture(name)
    File.read(File.join(File.dirname(__FILE__), '..', 'fixtures', 'xml', name.to_s + '.xml'))
  end
end

RSpec.configure do |c|
  c.include XmlFixtures
end
