Deface::Override.new(
    :virtual_path => 'spree/home/index',
    :name => 'add_search_box_to_home_page',
    :insert_before => "[data-hook='homepage_products']",
    :partial => "spree/hotels/search_box_home",
    :disabled => false
)
