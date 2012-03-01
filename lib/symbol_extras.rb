module SymbolExtras
  
  Symbol.class_eval do
    
    # this resolves a symbol to a specific record that it identifies 
    # (eg; :wjg8 indentifies my record, :some_group_slug identifies a particular group, etc.)
    def resolve_as(model)
      # order of potential identifiers is important.
      identifier = [:identifier, :login, :name, :title].each{ |label| break label if model.respond_to? label }
      model.find(:all, :conditions => ["`#{model.table_name}`.#{identifier.to_s} = #{self.to_s}"]) if model.respond_to? identifier
    end
    
    
    def to_model
      self.to_s.to_model
    end
    
    def to_controller_class
      self.to_s.to_controller_class
    end
    
  end
  
end