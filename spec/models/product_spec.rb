require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before(:each) do
      @category = Category.new
      @product = @category.products.new(
        name: "orange",
        price_cents: 3000,
        quantity: 3 
      )
    end
    
      it "saves a product when all values are present" do
        expect(@product.save).to eq true
      end

     it "fails to save when name is blank" do
      @product.name = nil
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.full_messages).to eq ["Name can't be blank"]
     end

     it "fails to save when price is not a number" do
      @product.price_cents = nil
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.full_messages).to include("Price cents is not a number")
      expect(@product.errors.full_messages).to eq ["Price cents is not a number", "Price is not a number", "Price can't be blank"]
      end

     it "fails to save when quantity is not specified" do
      @product.quantity = nil
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.full_messages).to eq ["Quantity can't be blank"]
      end
    
     it "fails to save when category is not defined" do
      @product.category = nil
      expect(@product.save).to eq false
      expect(@product.errors.full_messages).to eq ["Category can't be blank"]
      puts @product.errors.full_messages
     end

  end
end
