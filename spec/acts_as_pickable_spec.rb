require 'spec_helper'

ROOT = File.expand_path(File.dirname(__FILE__))

class CoolElement < ActiveRecord::Base
  acts_as_pickable
end

class CoolerElement < ActiveRecord::Base
  acts_as_pickable :selected
end

describe CoolElement do
  subject { CoolElement }
  before(:each){ subject.destroy_all }

  context "when there is no elements" do
    it "should return nothing" do
      subject.new_picked.should == nil
    end
  end

  context "when there is only one element" do

    it "should be returned all the time" do
      c = subject.create
      10.times do
        subject.picked.should == c
      end
    end

    it "should be picked all the time" do
      c = subject.create
      10.times do
        subject.new_picked.should == c
      end
    end
  
    context "and we destroy it" do
      it "should return nothing" do
        c = subject.create
        c.destroy
        subject.picked.should == nil
      end
    end

  end

  context "when we have a lot of elements" do
    it "should pick each time a new one" do
      n = subject.create
      n.save!
      n.reload
      n.picked.should == true
      s = subject.create
      s.save!
      n.reload
      10.times do
        if n != s
          n.should_not eql s
        else
          s = subject.new_daylee
          n.reload
          next
        end
        n.should_not eql s
      end
    end
  
    it "should set as picked when created" do
      n = subject.create
      n.save!
      n.reload
      n.picked.should == true
    end

    it "should pick a new when old picked is deleted" do
      10.times do
        subject.delete_all
        b = subject.create
        n = subject.create
        subject.picked.should == n
        subject.picked.destroy
        b.reload
        subject.picked.should == b
      end
    end

    it "force all to be daylee and pick new daylee" do
        subject.delete_all
        b = subject.create
        n = subject.create
        c = subject.create
        b.picked = true
        n.picked = true
        b.save!
        n.save!
        c.save!
        c.reload
        n.reload
        b.reload
        subject.new_picked
        subject.all.each do |s|
          if subject.picked != s
            s.picked.should == false
          end
        end
    end

  end

end

describe CoolerElement do
  subject { CoolerElement }
  before(:each){ subject.destroy_all }

  context "when there is no elements" do
    it "should return nothing" do
      subject.new_picked.should == nil
    end
  end

  context "when there is only one element" do

    it "should be returned all the time" do
      c = subject.create
      10.times do
        subject.picked.should == c
      end
    end

    it "should be picked all the time" do
      c = subject.create
      10.times do
        subject.new_picked.should == c
      end
    end

    context "and we destroy it" do
      it "should return nothing" do
        c = subject.create
        c.destroy
        subject.picked.should == nil
      end
    end

  end

  context "when we have a lot of elements" do
    it "should pick each time a new one" do
      n = subject.create
      n.save!
      n.reload
      n.selected.should == true
      s = subject.create
      s.save!
      n.reload
      10.times do
        if n != s
          n.should_not eql s
        else
          s = subject.new_daylee
          n.reload
          next
        end
        n.should_not eql s
      end
    end

    it "should set as picked when created" do
      n = subject.create
      n.save!
      n.reload
      n.selected.should == true
    end

    it "should pick a new when old picked is deleted" do
      10.times do
        subject.delete_all
        b = subject.create
        n = subject.create
        subject.picked.should == n
        subject.picked.destroy
        b.reload
        subject.picked.should == b
      end
    end

    it "force all to be daylee and pick new daylee" do
        subject.delete_all
        b = subject.create
        n = subject.create
        c = subject.create
        b.selected = true
        n.selected = true
        b.save!
        n.save!
        c.save!
        c.reload
        n.reload
        b.reload
        subject.new_picked
        subject.all.each do |s|
          if subject.picked != s
            s.selected.should == false
          end
        end
    end

  end

end
