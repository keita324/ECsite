class Admin::CustomersController < ApplicationController
    def index
        @customers = Customer.all
    end
end
