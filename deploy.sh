
LOCAL_PRIVATE_KEY=5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
# DEV KEYS 
# 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
# EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV

cleos create account eosio hypha EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
cleos create account hypha dao.hypha EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
cleos create account hypha token.hypha EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
cleos create account hypha husd.hypha EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV


cleos set contract token.hypha build/token -p token.hypha@active
cleos set contract husd.hypha build/token -p token.hypha@active

# issue
        #  void create( const name&   issuer,
        #               const asset&  maximum_supply);

cleos push action token.hypha create '{ 
	"issuer":"dao.hypha",
	"maximum_supply": "-1.00 HYPHA",
}' -p token.hypha@active

        #  void issue( const name& to, const asset& quantity, const string& memo );

cleos push action token.hypha issue '{ 
	"to":"dao.hypha",
	"quantity": "1000000.00 HYPHA",
    "memo": "issue initial amount"
}' -p dao.hypha@active
