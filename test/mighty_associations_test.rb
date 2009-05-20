require File.dirname(__FILE__) + '/test_helper'

class MightyAssociationsTest < Test::Unit::TestCase

  def setup
    empty_tables
  end
  
  def test_schema_loaded
    assert_equal([], Company.all)
    assert_equal([], Project.all)
    assert_equal([], Task.all)
    assert_equal([], Item.all)
  end
  
  def test_has_many_in_class
    project1 = Project.create!(:name => 'Wadus', :company => Company.create!(:name => 'Wadus'))
    project2 = Project.create!(:name => 'Wadus')
    assert_equal([project1], Company.projects)
  end
  
  def test_has_many_in_scope
    project1 = Project.create!(:name => 'Wadus', :company => Company.create!(:name => 'Wadus'))
    project2 = Project.create!(:name => 'Wadus', :company => Company.create!(:name => 'WadusWadus'))
    assert_equal([project1], Company.five_letters.projects)
  end
  
  def test_has_many_in_association
    task1 = Task.create(:name => 'Wadus', :project => Project.create!(:name => 'Wadus', :company => Company.create!(:name => 'Wadus')))
    task2 = Task.create(:name => 'Wadus', :project => Project.create!(:name => 'Wadus', :company => Company.create!(:name => 'WadusWadus')))
    assert_equal([task1], Company.find_by_name("Wadus").projects.tasks)
  end

  def test_has_many_through_in_class
    task1 = Task.create!(:name => 'Wadus', :project => Project.create!(:name => 'Wadus', :company => Company.create!(:name => 'Wadus')))
    task2 = Task.create!(:name => 'Wadus', :project => Project.create!(:name => 'Wadus'))
    task3 = Task.create!(:name => 'Wadus')
    assert_equal([task1], Company.tasks)
  end
  
  def test_has_many_through_in_scope
    task1 = Task.create!(:name => 'Wadus', :project => Project.create!(:name => 'Wadus', :company => Company.create!(:name => 'Wadus')))
    task2 = Task.create!(:name => 'Wadus', :project => Project.create!(:name => 'Wadus', :company => Company.create!(:name => 'WadusWadus')))
    assert_equal([task1], Company.five_letters.tasks)
  end
  
  def test_has_many_through_in_association
    item1 = Item.create!(:name => 'Wadus', :task => Task.create(:name => 'Wadus', :project => Project.create!(:name => 'Wadus', :company => Company.create!(:name => 'Wadus'))))
    item2 = Item.create!(:name => 'Wadus', :task => Task.create(:name => 'Wadus', :project => Project.create!(:name => 'Wadus', :company => Company.create!(:name => 'WadusWadus'))))
    assert_equal([item1], Company.find_by_name("Wadus").projects.items)
  end
  
  def test_has_many_is_chainable
    assert Company.projects.respond_to?(:find)
  end
  
  def test_pluralized_belongs_to_in_class
    company1 = Company.create!(:name => 'Wadus')
    company2 = Company.create!(:name => 'WadusWadus')
    company3 = Company.create!(:name => 'WadusWadusWadus')
    Project.create!(:company => company1, :name => 'Wadus')
    Project.create!(:company => company2, :name => 'WadusWadus')
    assert_equal([company1, company2], Project.companies)
  end
  
  def test_pluralized_belongs_to_in_scope
    company1 = Company.create!(:name => 'Wadus')
    company2 = Company.create!(:name => 'WadusWadus')
    company3 = Company.create!(:name => 'WadusWadusWadus')
    Project.create!(:company => company1, :name => 'Wadus')
    Project.create!(:company => company2, :name => 'WadusWadus')
    assert_equal([company1], Project.five_letters.companies)
  end
  
  def test_polymorphic
    company1 = Company.create!(:name => 'Wadus')
    company2 = Company.create!(:name => 'WadusWadus')
    tag = Tag.create!(:name => 'wadus')
    Tagging.create!(:tag => tag, :taggable => company1)
    assert_equal([tag], Company.tags)
  end
  
    
end
