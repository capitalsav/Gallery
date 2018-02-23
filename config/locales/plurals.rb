{ ru:
     { i18n:
           { plural:
                 { keys: [:zero, :one, :few, :other],
                   :rule => lambda { |n|
                     if n == 0
                       :zero
                     elsif (n % 10) == 1
                       :one
                     elsif ((n % 10) > 4 && (n % 10) <= 9) || (n > 9 && n < 21) || ((n.to_s.chars.length > 1) && (n % 10 == 0))
                       :other
                     elsif (n % 10) > 1 && (n % 10) < 5
                       :few
                     end
                   }
                 }
           }
     }
}