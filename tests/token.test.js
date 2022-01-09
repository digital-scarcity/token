const { loadConfig, Blockchain } = require("@klevoya/hydra");

const config = loadConfig("hydra.yml");

describe("token", () => {
  let blockchain = new Blockchain(config);
  let tester = blockchain.createAccount(`token`);

  beforeAll(async () => {
    users = [
      blockchain.createAccount('user1'),
      blockchain.createAccount('user2'),
      blockchain.createAccount('user3'),
      blockchain.createAccount('user4')
    ]

    tester.setContract(blockchain.contractTemplates[`token`]);
    tester.updateAuth(`active`, `owner`, {
      accounts: [
        {
          permission: {
            actor: tester.accountName,
            permission: `eosio.code`
          },
          weight: 1
        },
      ]
    });
    await tester.contract.create({ issuer: tester.accountName, maximum_supply: '10000000.00 HYPHA' })
    await tester.contract.issue({ to: tester.accountName, quantity: '130.00 HYPHA', memo: '' })


  });

  it("test reduce", async () => {
    expect.assertions(7);

    expect(tester.getTableRowsScoped(`accounts`)[tester.accountName]).toEqual([
      {
        balance: "130.00 HYPHA"
      }
    ]);

    await tester.contract.transfer({ from: tester.accountName, to: "user1", quantity: '100.00 HYPHA', memo: '' })

    expect(tester.getTableRowsScoped(`accounts`)[tester.accountName]).toEqual([
      {
        balance: "30.00 HYPHA"
      }
    ]);

    expect(tester.getTableRowsScoped(`accounts`)[`user1`]).toEqual([
      {
        balance: "100.00 HYPHA"
      }
    ]);

    expect(tester.getTableRowsScoped(`stat`)[`HYPHA`]).toEqual([
      {
        issuer: tester.accountName,
        max_supply: "10000000.00 HYPHA",
        supply: "130.00 HYPHA",
      }
    ]);

    await tester.contract.reduce({ account: "user1", quantity: '80.00 HYPHA', memo: '' })

    expect(tester.getTableRowsScoped(`accounts`)[`user1`]).toEqual([
      {
        balance: "20.00 HYPHA"
      }
    ]);

    expect(tester.getTableRowsScoped(`accounts`)[tester.accountName]).toEqual([
      {
        balance: "30.00 HYPHA"
      }
    ]);

    expect(tester.getTableRowsScoped(`stat`)[`HYPHA`]).toEqual([
      {
        issuer: tester.accountName,
        max_supply: "10000000.00 HYPHA",
        supply: "50.00 HYPHA",
      }
    ]);


  });
});
