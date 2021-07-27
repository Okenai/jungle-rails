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
      expect(@product.errors.messages[:name]).to eq ["can't be blank"]
     end

     it "fails to save when price is not a number" do
      @product.price_cents = nil
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:price]).to eq ["is not a number", "can't be blank"]
     end

     it "fails to save when quantity is not specified" do
      @product.quantity = nil
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:quantity]).to eq ["can't be blank"]
     end
    
     it "fails to save when category is not defined" do
      @product.category = nil
      @product.save
      expect(@product.save).to eq false
      expect(@product.errors.messages[:category]).to eq ["can't be blank"]
     end

  end
end
