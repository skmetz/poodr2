chainring = 52                    # number of teeth
cog       = 11
ratio     = chainring / cog.to_f
puts ratio                        # => 4.7272727272727275

chainring = 30
cog       = 27
ratio     = chainring / cog.to_f
puts ratio                        # => 1.1111111111111112
