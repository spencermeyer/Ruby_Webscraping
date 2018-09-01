module Browserchoice
  class Browserchoices
    def self.random_alias 
      [
        'Linux Firefox',
        'Linux Mozilla',
        'Mac Firefox',
        'Mac Mozilla',
        'Mac Safari',
        'Mac Safari',
        'Windows IE 10',
        'Windows IE 11',
        'Windows Edge',
        'Windows Mozilla',
        'Windows Firefox',
      ].sample
    end
  end
end