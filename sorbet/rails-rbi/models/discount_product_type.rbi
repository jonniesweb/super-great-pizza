# This is an autogenerated file for dynamic methods in DiscountProductType
# Please rerun rake rails_rbi:models to regenerate.
# typed: strong

class DiscountProductType::ActiveRecord_Relation < ActiveRecord::Relation
  include DiscountProductType::ModelRelationShared
  extend T::Generic
  Elem = type_member(fixed: DiscountProductType)
end

class DiscountProductType::ActiveRecord_Associations_CollectionProxy < ActiveRecord::Associations::CollectionProxy
  include DiscountProductType::ModelRelationShared
  extend T::Generic
  Elem = type_member(fixed: DiscountProductType)
end

class DiscountProductType < ApplicationRecord
  extend T::Sig
  extend T::Generic
  extend DiscountProductType::ModelRelationShared
  include DiscountProductType::InstanceMethods
  Elem = type_template(fixed: DiscountProductType)
end

module DiscountProductType::InstanceMethods
  extend T::Sig

  sig { returns(T.nilable(Integer)) }
  def discount_product_type_group_id(); end

  sig { params(value: T.nilable(Integer)).void }
  def discount_product_type_group_id=(value); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def discount_product_type_group_id?(*args); end

  sig { returns(T.nilable(Integer)) }
  def product_type_id(); end

  sig { params(value: T.nilable(Integer)).void }
  def product_type_id=(value); end

  sig { params(args: T.untyped).returns(T::Boolean) }
  def product_type_id?(*args); end

end

class DiscountProductType
  extend T::Sig

  sig { returns(T.nilable(::DiscountProductTypeGroup)) }
  def discount_product_type_group(); end

  sig { params(value: T.nilable(::DiscountProductTypeGroup)).void }
  def discount_product_type_group=(value); end

  sig { returns(T.nilable(::ProductType)) }
  def product_type(); end

  sig { params(value: T.nilable(::ProductType)).void }
  def product_type=(value); end

end

module DiscountProductType::ModelRelationShared
  extend T::Sig

  sig { returns(DiscountProductType::ActiveRecord_Relation) }
  def all(); end

  sig { params(block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def unscoped(&block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def select(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def reselect(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def order(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def reorder(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def group(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def limit(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def offset(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def joins(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def left_joins(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def left_outer_joins(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def where(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def rewhere(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def preload(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def extract_associated(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def eager_load(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def includes(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def from(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def lock(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def readonly(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def extending(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def or(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def having(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def create_with(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def distinct(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def references(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def none(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def unscope(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def optimizer_hints(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def merge(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def except(*args, &block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(DiscountProductType::ActiveRecord_Relation) }
  def only(*args, &block); end

end
