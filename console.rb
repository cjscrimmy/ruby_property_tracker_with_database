require('pry')
require_relative('models/properties')

property1 = Properties.new({
    'address' => '31 Rosebank Gardens',
    'value' => '120000',
    'number_of_bedrooms' => '2',
    'year_built' => '2000'
})

property2 = Properties.new({
    'address' => '1 The Street',
    'value' => '2000000',
    'number_of_bedrooms' => '5',
    'year_built' => '1985'
})

property1.save()
property2.save()
properties = Properties.all()

# Properties.delete_all()
# property1.delete()

property1.value = "500000"
property1.update()
 
property_by_id = Properties.find_by_id(8)


binding.pry 
nil