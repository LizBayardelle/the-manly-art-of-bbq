Product.delete_all
Product.create! id: 1, name: "Rule #23 Tee Shirt (Small)", weight: 1, box_width: 8, box_length: 5, box_depth: 2, price: 20.00, short_description: "These tee shirts not only have the Manly Art crest, but they also have a man rule on the back to remind any passers-by that may have forgotten. (Rule #23: Men never quote Twilight)", has_size: true, size_options: "Small, Medium, Large, Extra Large", active: true
Product.create! id: 2, name: "Grill Glove", weight: 1, box_width: 8, box_length: 5, box_depth: 2, price: 32.00, short_description: "Protect your manly mitts from the fiery dangers of the grill.", active: true
Product.create! id: 3, name: "BBQ Apron", weight: 1, box_width: 8, box_length: 5, box_depth: 2, price: 32.00, short_description: "Standard grilling apron with three pockets for all your necessary tools.  You get to add the grease marks and stains from the marinade of your choosing.", active: true


OrderStatus.delete_all
OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"
