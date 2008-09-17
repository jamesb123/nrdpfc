class AddressesController < ApplicationController
  layout "tabs"
  active_scaffold :addresses do |config|
    config.columns = [:user, :first_name, :last_name, :address1, :address2, :province, :postal, :phone, :mobile, :fax, ]
    config.columns[:first_name].label = "First Name"
    config.columns[:last_name].label = "Last Name"
    config.columns[:address1].label = "Address 1"
    config.columns[:address2].label = "Address 2"
    config.columns[:province].label = "PR/ST"
    config.columns[:postal].label = "Postal/Zip"
    config.columns[:phone].label = "Phone"
    config.columns[:mobile].label = "Mobile"
    config.columns[:fax].label = "Last Name"
    config.columns[:email].label = "Login"
    config.columns[:payment_method].label = "Payment"
    config.columns[:credit_card].label = "Credit Card"
    config.columns[:purchase_order].label = "Purchase Order"
    config.columns[:overdue].label = "Overdue"
  end 
end
