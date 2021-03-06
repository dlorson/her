require "her/model/base"
require "her/model/http"
require "her/model/attributes"
require "her/model/orm"
require "her/model/parse"
require "her/model/associations"
require "her/model/introspection"
require "her/model/paths"
require "her/model/nested_attributes"
require "active_model"

module Her
  # This module is the main element of Her. After creating a Her::API object,
  # include this module in your models to get a few magic methods defined in them.
  #
  # @example
  #   class User
  #     include Her::Model
  #   end
  #
  #   @user = User.new(:name => "Rémi")
  #   @user.save
  module Model
    extend ActiveSupport::Concern

    # Her modules
    include Her::Model::Base
    include Her::Model::Attributes
    include Her::Model::ORM
    include Her::Model::HTTP
    include Her::Model::Parse
    include Her::Model::Introspection
    include Her::Model::Paths
    include Her::Model::Associations
    include Her::Model::NestedAttributes

    # Supported ActiveModel modules
    include ActiveModel::Validations
    include ActiveModel::Conversion
    include ActiveModel::Dirty
    include ActiveModel::Naming
    include ActiveModel::Translation

    # Class methods
    included do
      # Assign the default API
      uses_api Her::API.default_api

      # Define the default primary key
      primary_key :id

      # Configure ActiveModel callbacks
      extend ActiveModel::Callbacks
      define_model_callbacks :create, :update, :save, :find, :destroy
    end
  end
end
