# Token Project

## Build

Run these commands
```
cd build
cmake ..
make
```

## Deploy
   The built smart contract is under the 'token' directory in the 'build' directory
   
   You can then do a 'set contract' action with 'cleos' and point in to the './build/token' directory

Example 
```
cleos set contract mytoken build/token -p mytoken@active

--> deploys code on mytoken contract
```

### CMake Additions 
Additions to CMake should be done to the CMakeLists.txt in the './src' directory and not in the top level CMakeLists.txt

 # Testing

The test are writen using Hydra framework: https://klevoya.com/hydra/

To log in with Hydra - required to run the tests:
```
npm install --global @klevoya/hydra
hydra login
```

To run the tests:
```
npm install
npm test
