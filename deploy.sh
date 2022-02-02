
LOCAL_PRIVATE_KEY=5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
# DEV KEYS 
# 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
# EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV

cleos create account eosio hypha EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
cleos create account hypha dao.hypha EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
cleos create account hypha token.hypha EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
cleos create account hypha husd.hypha EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV

cleos set contract token.hypha build/token -p token.hypha@active
cleos set contract husd.hypha build/token -p husd.hypha@active
cleos set contract dao.hypha ../dao-contracts/build/dao -p dao.hypha@active

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

cleos push action husd.hypha create '{ 
	"issuer":"dao.hypha",
	"maximum_supply": "-1.00 HUSD",
}' -p husd.hypha@active

        #  void issue( const name& to, const asset& quantity, const string& memo );

cleos push action husd.hypha issue '{ 
	"to":"dao.hypha",
	"quantity": "1000000.00 HUSD",
    "memo": "issue initial amount"
}' -p dao.hypha@active

cleos transfer -c husd.hypha dao.hypha hypha "1000.00 HUSD"

#       ACTION setsetting(const string &key, const Content::FlexValue &value);

# account: dao.hypha
# name: setsetting
# authorization: [{"actor":"dao.hypha","permission":"active"}]
# data: {"key":"hypha_usd_value","value":["asset","8.0000 USD"]}

cleos push action dao.hypha setsetting '{ 
	"key":"hypha_usd_value",
	"value":["asset","0.5000 USD"]
}' -p dao.hypha@active
