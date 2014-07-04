require 'test/unit'
require 'rubygems'
require 'active_record'
require 'active_support/all'
#require 'ruby-debug'

ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

ActiveRecord::Schema.verbose = false

ActiveRecord::Schema.define(:version => 1) do
  create_table :companies do |t|
    t.string :name
  end
  create_table :projects do |t|
    t.integer :company_id
    t.string :name
  end
  create_table :tasks do |t|
    t.integer :project_id
    t.string :name
  end
  create_table :items do |t|
    t.integer :task_id
    t.string :name
  end
  create_table :tags do |t|
    t.string :name
  end
  create_table :taggings do |t|
    t.integer :tag_id, :taggable_id
    t.string :taggable_type
  end
end

def empty_tables
  [ Company, Project, Task, Item ].each(&:destroy_all)
end

require File.dirname(__FILE__) + '/../init'

class Task < ActiveRecord::Base
  belongs_to :project
  has_many :items
end

class Item < ActiveRecord::Base
  belongs_to :task
end

class Project < ActiveRecord::Base
  has_many :tasks
  has_many :items, :through => :tasks
  belongs_to :company
  
  scope :five_letters, lambda{ where("LENGTH(name) = 5") }
end

class Tag < ActiveRecord::Base
  has_many :taggings
end

class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true
end

class Company < ActiveRecord::Base
  has_many :projects
  has_many :tasks, :through => :projects
  
  scope :five_letters, lambda { where("LENGTH(name) = 5") }
  
  has_many :taggings, :as => :taggable, :dependent => :destroy, :include => :tag
  has_many :tags, :through => :taggings
end

