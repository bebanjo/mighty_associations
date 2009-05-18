Mighty Associations
===================

Extends many of your associations for free. Given the following models:

    class Task < ActiveRecord::Base
      belongs_to :project
    end

    class Project < ActiveRecord::Base
      has_many :tasks
      belongs_to :company
      
      named_scope :five_letters, :conditions => "LENGTH(name) = 5"
    end

    class Company < ActiveRecord::Base
      has_many :projects
      has_many :tasks, :through => :project

      named_scope :five_letters, :conditions => "LENGTH(name) = 5"
    end
    
You can:

Get all projects belonging to a company:

    Company.projects
    
Get all projects belonging to a company with a 5-letter name:

    Company.five_letters.projects
    
It also works with has_many :through associations:

    Company.tasks
    Company.five_letters.tasks

Return value is a scope, so you can still chain it:

    Company.five_letters.projects.find_by_name("Wadus")
    
The same applies for belongs_to associations, for example you can get the companies with a five-letter project:

    Project.five_letter.companies

    

Copyright (c) 2009 BeBanjo, released under the MIT license
