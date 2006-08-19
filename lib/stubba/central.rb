module Stubba
  
  class Central
  
    attr_accessor :stubba_methods
  
    def initialize
      self.stubba_methods = []
    end
   
    def stub(method)
      unless stubba_methods.include?(method)
        method.stub 
        stubba_methods.push method
      end
    end
    
    def verify_all(&block)
      unique_mocks.each { |mock| mock.verify(&block) }
    end
    
    def unique_mocks
      stubba_methods.collect { |method| method.mock }.uniq
    end
  
    def unstub_all
      while stubba_methods.size > 0
        method = stubba_methods.pop
        method.unstub
      end
    end

  end

end